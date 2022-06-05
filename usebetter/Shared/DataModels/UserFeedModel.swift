//
//  UserFeedModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/18/22.
//

import Foundation
import Combine

import Amplify
import AWSS3

class UserFeedModel: ObservableObject {
    
    struct Constants {
        static var userFeed = "items.json"
    }
    
    @Published var userItems: [UBItem] = []
    private var userRemoteItems: [UBItemRemote] = []
    private var bag = Set<AnyCancellable>()
    private var s3FileManager = S3FileManager()
    
    init() {
        readCache()
    }
    
    func update() {
        updateLocalCache()
    }
    
    func append(item: UBItem) {
        userItems.append(item)
        updateLocalCache()
    }
    
    func sync() {
        readRemote() { _ in
        }
    }
    
    private func readCache() {
        DispatchQueue.global().async {
            self.userRemoteItems = JsonInterpreter(filePath: Constants.userFeed).read()
            if self.userRemoteItems.isEmpty {
                  self.readRemote() { result in
                      if result == true {
                          self.readCache()
                      }
                 }
            }
            else {
                self.convertRemoteData()
            }
        }
    }
    
    private func convertRemoteData() {
        DispatchQueue.main.async {
            for remoteItem in self.userRemoteItems {
                var item = UBItem(name: remoteItem.name, itemid: remoteItem.itemid ?? UUID())
                item.imageURL = remoteItem.imageURL
                item.tags = remoteItem.tags
                item.price = remoteItem.price
                item.description = remoteItem.description
                item.originalItemURL = remoteItem.originalItemURL
                item.itemCount = remoteItem.itemCount
                item.sharedContactNumber = remoteItem.sharedContactNumber
                item.sharedContactName = remoteItem.sharedContactName
                
                self.userItems.append(item)
            }
        }
    }
    
    private func updateLocalCache() {
        DispatchQueue.global().async {
            //update remote items
            self.userRemoteItems = []
            for item in self.userItems {
                var remoteItem = UBItemRemote(name: item.name, itemid: item.itemid)
                remoteItem.tags = item.tags
                remoteItem.price = item.price
                remoteItem.originalItemURL = item.originalItemURL
                remoteItem.imageURL = item.imageURL
                remoteItem.description = item.description
                remoteItem.itemCount = item.itemCount
                remoteItem.sharedContactNumber = item.sharedContactNumber
                remoteItem.sharedContactName = item.sharedContactName
                self.userRemoteItems.append(remoteItem)
            }
            JsonInterpreter(filePath: Constants.userFeed).write(data1: self.userRemoteItems)
            self.updateRemote()
        }
        
    }
    
    private func readRemote(completion: @escaping (Bool)->Void) {
        guard let localURL = userFeedFile() else {
            print("UserFeedModel: readRemote: No local file exists")
            return
        }
        
        guard let username = Amplify.Auth.getCurrentUser()?.username else {
            print("UserFeedModel: readRemote: No local file exists")
            return
        }
        
        s3FileManager.downloadRemote(key: username+"/"+Constants.userFeed, localURL: localURL) { result in
            print("UserFeedModel: readRemote: Completed: \(result)")
            completion(result)
        }
    }
    
    private func updateRemote() {
        guard let localURL = userFeedFile() else {
            print("UserFeedModel: updateRemote: No local file exists")
            return
        }
        
        guard let username = Amplify.Auth.getCurrentUser()?.username else {
            print("UserFeedModel: updateRemote: No local file exists")
            return
        }
        
        S3FileManager().updateRemote(key: username+"/"+Constants.userFeed, localURL: localURL) { result in
            print("UserFeedModel: updateRemote: Completed: \(result)")
        }
    }
    
    private func userFeedFile() -> URL? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(Constants.userFeed)
            return pathWithFilename
        }
        return nil
    }
 
}

/*
class DummyData {
    struct Constants {
        static let exampleUserData = """
            [
                {
                    "name": "Best Choice Products 6ft Plastic Folding Table, Indoor Outdoor Heavy Duty Portable w/Handle, Lock for Picnic, Party, Camping - White",
                    "imageURL": "https://m.media-amazon.com/images/I/61mU+7VlqKL._AC_SY300_SX300_.jpg",
                    "tags":  ["Patio, Lawn & Garden", "Patio Furniture & Accessories", "Tables", "Picnic Tables"],
                    "originalSourceURL": "https://www.amazon.com/Best-ChoiceProducts-Folding-Portable-Plastic/dp/B00D49B0US/ref=sr_1_5?crid=2SS10QTLPW7C1&keywords=party%2Btable&qid=1653021805&sprefix=party%2Btable%2Caps%2C151&sr=8-5&th=1",
                    "price": "65.79",
        "itemCount": "1"
                },
                {
                    "name": "Louisville 6 feet Fiberglass Step Ladder",
                    "imageURL": "https://images-na.ssl-images-amazon.com/images/I/51B0MfFWB1L.__AC_SX300_SY300_QL70_ML2_.jpg",
                    "tags":  ["Tools & Home Improvement", "Building Supplies", "Ladders", "Step Ladders"],
                    "originalSourceURL": "https://www.amazon.com/Louisville-Ladder-Available-FS1506-Fiberglass/dp/B000KL2YB2/ref=sxin_14_ac_d_hl?ac_md=4-1-NiB0byAxMCBmZWV0-ac_d_hl_hl_rf&crid=25DZNZESRWHVP&cv_ct_cx=ladder&keywords=ladder&pd_rd_i=B000KL2YB2&pd_rd_r=09c2f6de-3bf1-4879-b895-512b16cb8160&pd_rd_w=ei1A2&pd_rd_wg=g4Nbt&pf_rd_p=c62cb81a-0a35-442f-8d53-cc7156305bbb&pf_rd_r=BW1BK1BGFSSMHVVNRSPX&qid=1653022143&sprefix=ladder%2Caps%2C162&sr=1-2-25fd44b4-555a-4528-b40c-891e95133f20&th=1",
                    "price": "169.99",
                "itemCount": "1"
                },
                {
                    "name": "YYDeek Bubble Machine Automatic Bubble Blower for Kids, Blowing 4000 Bubbles Per Minute, Two-Speed Design Powered by Plug in or Battery, Portable Bubble Maker for Toddlers Outdoor Backyard Party",
                    "imageURL": "https://m.media-amazon.com/images/I/411K-JCNMkL._AC_US40_.jpg",
                    "tags":  ["Toys & Games", "Sports & Outdoor Play", "Bubbles", "Bubble Makers"],
                    "originalSourceURL": "https://www.amazon.com/YYDeek-Automatic-Two-Speed-Portable-Toddlers/dp/B09T6NWSJ6/ref=sr_1_47?keywords=bubble+maker&qid=1653022295&sr=8-47",
                    "price": "18.00",
        "itemCount": "1"
                },
                {
                    "name": "Telescoping Ladder Aluminum Telescopic Extension Multi-Purpose Folding Ladder Portable Heavy Duty Steps Anti-Slip Rubber Feet 330lbs Max Capacity",
                    "imageURL": "https://images-na.ssl-images-amazon.com/images/I/61cqq5N3k7L.__AC_SX300_SY300_QL70_ML2_.jpg",
                    "tags":  ["Tools & Home Improvement", "Building Supplies", "Ladders", "Step Ladders"],
                    "originalSourceURL": "https://www.amazon.com/ATCEPFU-Telescoping-Telescopic-Extension-Multi-Purpose/dp/B09D3ZMGS5/ref=sr_1_1_sspa?crid=4TJ6932ABGU&keywords=telescopic%2Bladder&qid=1653022497&sprefix=telescopic%2Bladde%2Caps%2C134&sr=8-1-spons&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEyWFBaNjM3NEVIQkY2JmVuY3J5cHRlZElkPUEwNTEzNjU0UUc0RkdZREhaMVJSJmVuY3J5cHRlZEFkSWQ9QTA2ODA1MDkxTTlYUUM2WkJFMTlBJndpZGdldE5hbWU9c3BfYXRmJmFjdGlvbj1jbGlja1JlZGlyZWN0JmRvTm90TG9nQ2xpY2s9dHJ1ZQ&th=1",
                    "price": "169.99",
        "itemCount": "1"
                }
            ]
        """
    }
}
 */
