//
//  UBItem.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/12/22.
//

import SwiftUI
import CoreData

struct UBItem : Identifiable {
    var name: String
    var itemid: UUID
    var ownerid: String = AccountManager.sharedInstance.currentUsername ?? ""
    var itemCount: Int = 1
    var tags: [String] = []
    var imageURL: String?
    var description: String?
    var price: String?
    var originalItemURL: String?
    var id: String { itemid.uuidString }
}

extension UBItem {
    func includes(_ searchTag: String) -> Bool {
        if searchTag == "" {
            return true
        }
        
        if name.range(of: searchTag, options: .caseInsensitive) != nil {
            return true
        }
        
        if description?.range(of: searchTag, options: .caseInsensitive) != nil {
            return true
        }
        
        for tag in tags {
            if tag.range(of: searchTag, options: .caseInsensitive) != nil {
                return true
            }
        }
        return false
    }
}

extension UBItem {
    var getTags: String{
        var tagsWithComma: String = ""
        for tag in tags {
            tagsWithComma += tag
            tagsWithComma += ", "
        }
        return tagsWithComma
    }
    
    var getAsyncImage: AsyncImage<Image> {
        guard let imageURL = self.imageURL else {
            return AsyncImage(url: URL(string: "notAvailable"))
        }
        return AsyncImage(url: URL(string: imageURL))
    }
}

struct UBItemRemote : Codable {
    var name: String
    var itemid: UUID
    var ownerid: String
    var itemCount: Int = 1
    var tags: [String] = []
    var imageURL: String?
    var description: String?
    var price: String?
    var originalItemURL: String?
}
