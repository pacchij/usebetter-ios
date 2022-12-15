//
//  URLParser.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/15/22.
//
import Foundation
import SwiftSoup

class URLParser {
    
    private let url: String
    private let parser: AmazonURLParser? = nil
    
    init(url: String) {
        self.url = url
    }
    
    func parse( callback: @escaping (_ item: UBItem?)->Void)  {
        logger.log("URLParser: parse: Entered")
        DispatchQueue.global().async {
            guard let url = URL(string: self.url) else {
                logger.log("URLParser: parse: error in url")
                callback(nil)
                return
            }
            let htmlContent = try! String(contentsOf: url)
            logger.log("URLParser: parse: parsing amazon url")
            AmazonURLParser().parse(html: htmlContent, callback: callback)
        }
    }
}

class AmazonURLParser {
    
    private func getTitle(for document: Document) -> String? {
        do {
            var titleElement = try document.select("#title")
            var title = try titleElement.first()?.text()
            
            if title == nil {
                titleElement = try document.select("#productTitle")
                title = try titleElement.first()?.text()
            }
            logger.log("AmazonURLParser: getTitle: \(title ?? "")" )
            return title
        }
        catch {
            logger.log("AmazonURLParser: getTitle: Exception \(error) ")
        }
        return nil
    }
    
    private func getPrice(for document: Document) -> String? {
        do {
            var priceElement = try document.select("#bundle-v2-btf-price")
            var price = try priceElement.first()?.text()
            
            if price == nil {
                priceElement = try document.select("#mbc-price-1")
                price = try priceElement.first()?.text()
            }
            
            if price == nil {
                priceElement = try document.select("#twister-plus-price-data-price")
                price = try priceElement.first()?.attr("value")
            }
            logger.log("AmazonURLParser: getPrice: \(price ?? "")" )
            return price
        }
        catch {
            logger.log("AmazonURLParser: getPrice: Exception \(error) ")
        }
        return nil
    }
    
    func getImage(for document: Document) -> String? {
        do {
            var imageBlock: Element? = try document.select("#image-block").first()
            var imageBlockHtml: String? = try imageBlock?.outerHtml()
            if imageBlockHtml == nil {
                imageBlock = try document.select("#imageBlock").first()
                imageBlockHtml = try imageBlock?.outerHtml()
            }
            
            if imageBlockHtml == nil {
                logger.log("AmazonURLParser: getImage: image block not found")
                return nil
            }

            let imageDocument = try SwiftSoup.parse(imageBlockHtml!)
            let images: Elements = try imageDocument.select("img[src]")
            let imagesStringArray: [String?] = images.array().map { try? $0.attr("src").description }
            
            logger.log("AmazonURLParser: getImage: images: \(imagesStringArray)")
            
            if imagesStringArray.isEmpty {
                logger.log("AmazonURLParser: getImage: no images found")
                return nil
            }
            
            return imagesStringArray[0]
        }
        catch Exception.Error(_, _) {
            logger.log("AmazonURLParser: getImage: : Excepiton:")
        }
        catch {
            logger.log("AmazonURLParser: getImage: : Unknown Excepiton")
        }
        return nil
    }
    
    func parse(html: String, callback: @escaping (_ item: UBItem?)->Void){
       
        do {
            logger.log("AmazonURLParser: parse: entered")
            let document: Document = try SwiftSoup.parse(html)
            logger.log("AmazonURLParser: parse: title: \(document)" )
            
            guard let title = getTitle(for: document) else {
                callback(nil)
                return
            }
                  
            guard let price = getPrice(for: document) else {
                callback(nil)
                return
            }
            
            guard let imageURL = getImage(for: document) else {
                callback(nil)
                return
            }
            
            let tags = getCategories(document: document)
            logger.log("AmazonURLParser: parse: categories \(tags)")
            
            var item = UBItem(name: title, itemid: UUID())
            item.description = title
            item.price = price
            item.tags = tags
            item.imageURL = imageURL
            
            callback(item)
            return
        }
        catch Exception.Error(_, _) {
            logger.log("AmazonURLParser: parse: : Excepiton: ")
        }
        catch {
            logger.log("AmazonURLParser: parse: : Unknown Excepiton")
        }
    
        logger.log("AmazonURLParser: parse: parse calling nil")
        callback(nil)

    }
    
    func getCategories(document: Document) -> [String] {
        do {
            let categoriesBlock: Element? = try document.select("#wayfinding-breadcrumbs_feature_div").first()
            let categoriesBlockHtml: String? = try categoriesBlock?.outerHtml()
            guard let categoriesBlockHtml = categoriesBlockHtml else {
                return []
            }
            
            let CategoriesDocument = try SwiftSoup.parse(categoriesBlockHtml)
            let images: Elements = try CategoriesDocument.select(".a-link-normal")
            var cats: [String] = []
            cats = try images.map {
                try $0.text()
            }
            return cats
        }
        catch Exception.Error(_, _) {
            logger.log("AmazonURLParser: getCategories: Excepiton: ")
        }
        catch {
            logger.log("AmazonURLParser: getCategories: Unknown Excepiton")
        }
        return []
    }
    
}
