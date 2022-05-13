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
        prepareData()
    }
    deinit {
        print("deinit: DashboardHomeViewModel")
    }
        
    func prepareData() {
        let names = ["ascent-chair-round", "baloon-airpump-electric", "bubble-machine-electric", "coffee-mugs", "extension-cord-50ft", "extension-cord-100ft", "iron", "kitchen-china", "ladder-aluminium-6ft", "ladder-telescopic", "party-chairs-plastic", "party-chairs-wood", "party-table-rectangle-plastic", "party-table-round-plastic", "utensils", "vaccum-cleaner"]
        let descriptions = ["ascent-chair-round", "baloon-airpump-electric", "bubble-machine-electric", "coffee-mugs", "extension-cord-50ft", "extension-cord-100ft", "iron", "kitchen-china", "ladder-aluminium-6ft", "ladder-telescopic", "party-chairs-plastic", "party-chairs-wood", "party-table-rectangle-plastic", "party-table-round-plastic", "utensils", "vaccum-cleaner"]
        let tags = [["ascent", "chair", "round"],
                    ["baloon", "airpump", "electric"],
                    ["bubble", "electric"],
                    ["coffee"],
                    ["extension-cord-50ft"],
                    ["extension-cord-100ft"],
                    ["iron"],
                    ["kitchen-china"],
                    ["ladder-aluminium-6ft"],
                    ["ladder-telescopic"],
                    ["party-chairs-plastic"],
                    ["party-chairs-wood"],
                    ["party-table-rectangle-plastic"],
                    ["party-table-round-plastic"],
                    ["utensils"],
                    ["vaccum-cleaner"] ]

        var i = 0
        for name in names {
            var item = UBItem(name: name)
            item.description = descriptions[i]
            item.tags = tags[i]
            item.image = Image(name)
            i = i + 1
            items.append(item)
        }
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
