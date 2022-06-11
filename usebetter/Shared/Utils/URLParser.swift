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
        print("URLParser: parse: Entered")
        DispatchQueue.global().async {
            guard let url = URL(string: self.url) else {
                print("URLParser: parse: error in url")
                callback(nil)
                return
            }
            let htmlContent = try! String(contentsOf: url)
            print("URLParser: parse: parsing amazon url")
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
            print("AmazonURLParser: getTitle: ", title ?? "" )
            return title
        }
        catch {
            print("AmazonURLParser: getTitle: Exception \(error) ")
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
            print("AmazonURLParser: getPrice: ", price ?? "" )
            return price
        }
        catch {
            print("AmazonURLParser: getPrice: Exception \(error) ")
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
                print("AmazonURLParser: getImage: image block not found")
                return nil
            }

            let imageDocument = try SwiftSoup.parse(imageBlockHtml!)
            let images: Elements = try imageDocument.select("img[src]")
            let imagesStringArray: [String?] = images.array().map { try? $0.attr("src").description }
            
            print("AmazonURLParser: getImage: images: ", imagesStringArray)
            
            if imagesStringArray.isEmpty {
                print("AmazonURLParser: getImage: no images found")
                return nil
            }
            
            return imagesStringArray[0]
        }
        catch Exception.Error(let type, let message) {
            print("AmazonURLParser: getImage: : Excepiton: ", type, message)
        }
        catch {
            print("AmazonURLParser: getImage: : Unknown Excepiton")
        }
        return nil
    }
    
    func parse(html: String, callback: @escaping (_ item: UBItem?)->Void){
       
        do {
            print("AmazonURLParser: parse: entered")
            let document: Document = try SwiftSoup.parse(html)
            print("AmazonURLParser: parse: title: ", document )
            
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
            print("AmazonURLParser: parse: categories ", tags)
            
            var item = UBItem(name: title, itemid: UUID())
            item.description = title
            item.price = price
            item.tags = tags
            item.imageURL = imageURL
            
            callback(item)
            return
        }
        catch Exception.Error(let type, let message) {
            print("AmazonURLParser: parse: : Excepiton: ", type, message)
        }
        catch {
            print("AmazonURLParser: parse: : Unknown Excepiton")
        }
    
        print("AmazonURLParser: parse: parse calling nil")
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
        catch Exception.Error(let type, let message) {
            print("AmazonURLParser: getCategories: Excepiton: ", type, message)
        }
        catch {
            print("AmazonURLParser: getCategories: Unknown Excepiton")
        }
        return []
    }
    
}
