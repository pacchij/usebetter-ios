//
//  FriendsFeedModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/18/22.
//

import Foundation
import Amplify

class FriendsFeedModel: ObservableObject {
     struct Constants {
         static var items = "items.json"
    }
    
    @Published var friendsItems: [UBItem] = []
    private var friendsRemoteItems: [UBItemRemote] = []
    private var s3FileManager = S3FileManager()
    
    init() {
        readCache()
    }
    private var currentUserKey: String {
        guard let username = Amplify.Auth.getCurrentUser()?.username else {
            print("UserFeedModel: updateRemote: No local file exists")
            return ""
        }
        return username + "/" + Constants.items
    }
    
    private func readCache() {
        DispatchQueue.global().async {
            
            //1. get list of users except current user files
            self.s3FileManager.listUserFolders { list in
                list.items.forEach { item in
                    print("FriendsFeedModel: readCache \(item)")
                    if item.key.suffix(4) != "json" {
                        return
                    }
                    if item.key != self.currentUserKey {
                        //2. download each user file into respective folder
                        self.downloadFile(key: item.key) { result in
                            //3. load each file
                            let friendItems = JsonInterpreter(filePath: item.key).read()
                            //4. update each file content in user thread
                            self.convertRemoteData(remoteFriendsItems: friendItems)
                        }
                    }
                }
            }
//            self.friendsRemoteItems = JsonInterpreter(filePath: "friendsfeed.json").read()
//            if self.friendsRemoteItems.isEmpty {
//                if JsonInterpreter(filePath: "friendsfeed.json").write(jsonString: DummyData.Constants.exampleUserData) {
//                    self.readCache()
//                }
//            }
//            else {
//                self.convertRemoteData()
//            }
        }
    }
    
    private func downloadFile(key: String, completion: @escaping (Bool)->Void) {
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            guard let index = key.firstIndex(of: "/") else {
                return completion(false)
            }
            let friendUsername = String(key.prefix(upTo: index))
            let friendPath = documentDirectory.appendingPathComponent(friendUsername)
            if !FileManager.default.fileExists(atPath: friendPath.path) {
                try! FileManager.default.createDirectory(at: friendPath, withIntermediateDirectories: true)
            }
            let pathWithFilename = friendPath.appendingPathComponent(Constants.items)
            s3FileManager.downloadRemote(key: key, localURL: pathWithFilename) { result in
                completion(result)
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
    
    private func convertRemoteData(remoteFriendsItems: [UBItemRemote]) {
        DispatchQueue.main.async {
            for remoteItem in remoteFriendsItems {
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

