//
//  DashboardHomeViewModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/12/22.
//

import SwiftUI

class DashboardHomeViewModel {
    private var items: [UBItem] = []
    init() {
        print("init: DashboardHomeViewModel")
    }
    
    deinit {
        print("deinit: DashboardHomeViewModel")
    }
    
    func items(searchTag: String?) -> [UBItem] {
        let filteredItems = items.filter {
            guard let searchTag = searchTag else {
                return true
            }
            return $0.includes(searchTag)
        }
        return filteredItems
    }
}
