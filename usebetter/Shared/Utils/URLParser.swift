//
//  URLParser.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/15/22.
//
import Foundation
import SwiftSoup
//
//protocol URLParserProtocol {
//    func parse()
//    func item() -> UBItem?
//}
class URLParser {
    
    private let url: String
    private let parser: AmazonURLParser? = nil
    
    init(url: String) {
        self.url = url
    }
    
    func parse( callback: @escaping (_ item: UBItem?)->Void)  {
        DispatchQueue.global().async {
        print("parse entered")
        guard let url = URL(string: self.url) else {
            print("error")
            callback(nil)
            return
        }
        print("parse URL done")
        let htmlContent = try! String(contentsOf: url)
        print("parse String done")
        AmazonURLParser().parse(html: htmlContent, callback: callback)
        print("parse amazonurl parse done")
        }
    }
}

class AmazonURLParser {
    
    func parse(html: String, callback: @escaping (_ item: UBItem?)->Void){
       
        do {
            print("parse before swiftSoup")
            let document: Document = try SwiftSoup.parse(html)
            
            print("parse after swiftSoup")
            
            let titleElement: Elements = try document.select("#productTitle")
            let title = try titleElement.first()?.text() ?? ""
            print("title: ", title )
            
            var item = UBItem(name: title)
            item.description = title
            
            let price: Elements = try document.select("#mbc-price-1")
            let priceVal = try price.first()?.text()  ?? ""
            print("Price: ", priceVal)
            item.price = priceVal
           
            
            item.imageURL = self.imageURL(document: document)
            print("Image URL is ", item.imageURL ?? "empty")
            
            item.tags = self.categories(document: document)
            print("categories ", item.tags)
            
            callback(item)
        }
        catch Exception.Error(let type, let message) {
            print("URLParser: Excepiton: ", type, message)
        }
        catch {
            print("URLParser: Unknown Excepiton")
        }
    
        print("parse calling cbk")
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
