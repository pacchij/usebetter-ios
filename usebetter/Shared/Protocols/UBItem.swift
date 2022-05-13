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
    var description: String?
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
