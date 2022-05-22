//
//  FriendsFeedModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/18/22.
//

import Foundation

class FriendsFeedModel: ObservableObject {
    
    @Published var friendsItems: [UBItem] = []
    private var friendsRemoteItems: [UBItemRemote] = []
    
    init() {
        readCache()
    }
    
    private func readCache() {
        DispatchQueue.global().async {
            self.friendsRemoteItems = JsonInterpreter(filePath: "friendsfeed.json").read()
            if self.friendsRemoteItems.isEmpty {
                if JsonInterpreter(filePath: "friendsfeed.json").write(jsonString: DummyData.Constants.exampleUserData) {
                    self.readCache()
                }
            }
            else {
                self.convertRemoteData()
            }
        }
    }
    
    private func convertRemoteData() {
        DispatchQueue.main.async {
            for remoteItem in self.friendsRemoteItems {
                var item = UBItem(name: remoteItem.name)
                item.imageURL = remoteItem.imageURL
                item.tags = remoteItem.tags
                item.price = remoteItem.price
                item.description = remoteItem.description
                item.originalItemURL = remoteItem.originalItemURL
                item.itemCount = remoteItem.itemCount
                item.sharedContactNumber = remoteItem.sharedContactNumber
                
                self.friendsItems.append(item)
            }
        }
    }
    
    /* TODO
    private func readRemote() {}
    
    private func updateRemote() {}
     */
    
}

