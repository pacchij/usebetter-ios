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
    
    private func getTitle() -> String? {
        do {
            var titleElement = try document.select("#productTitle")
            var title = try titleElement.first()?.text()
            
            if title == nil {
                titleElement = try document.select("#title")
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
    
    func parse(html: String, callback: @escaping (_ item: UBItem?)->Void){
       
        do {
            print("AmazonURLParser: parse: entered")
            let document: Document = try SwiftSoup.parse(html)
            print("AmazonURLParser: parse: title: ", document )
            
            guard let title = getTitle() else {
                callback(nil)
                return
            }
                  
            let price: Elements = try document.select("#mbc-price-1")
            let priceVal = try price.first()?.text()
            print("AmazonURLParser: parse: Price: ", priceVal ?? "")
            
            let imageURL = self.imageURL(document: document)
            print("AmazonURLParser: parse: Image URL is ", imageURL ?? "empty")
            
            let tags = self.categories(document: document)
            print("AmazonURLParser: parse: categories ", tags)
            
            if priceVal == nil, imageURL ==  nil, tags.isEmpty {
                print("AmazonURLParser: parse: empty price, title or tags")
                callback(nil)
                return
            }
            
            var item = UBItem(name: title, itemid: UUID())
            item.description = title
            item.price = priceVal
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
    
    func imageURL(document: Document) -> String? {
        do {
            let imageBlock: Element? = try document.select("#imageBlock").first()
            let imageBlockHtml: String? = try imageBlock?.outerHtml()
            guard let imageBlockHtml = imageBlockHtml else {
                return nil
            }

            let imageDocument = try SwiftSoup.parse(imageBlockHtml)
            let images: Elements = try imageDocument.select("img[src]")
            let imagesStringArray: [String?] = images.array().map { try? $0.attr("src").description }
            
            print("images: ", imagesStringArray)
            
            return imagesStringArray[0]
        }
        catch Exception.Error(let type, let message) {
            print("URLParser: Excepiton: ", type, message)
        }
        catch {
            print("URLParser: Unknown Excepiton")
        }
        return nil
    }
    
    func categories(document: Document) -> [String] {
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
            print("URLParser: Excepiton: ", type, message)
        }
        catch {
            print("URLParser: Unknown Excepiton")
        }
        return []
    }
    
}
