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
    var image: Image?
    var imageURL: String?
    var description: String?
    var price: String?
    var tags: [String] = []
    var id: String { name }
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
    
    var getImage: Image {
        guard let image = self.image else {
            return Image("notAvailable")
        }
        return image
    }
}
