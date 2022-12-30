//
//  FriendsFeedModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/18/22.
//

import Foundation
import Amplify
import Combine

struct UBMetaData : Codable {
    var lastModified: String?
}


class FriendsFeedModel: ObservableObject {
    struct Constants {
        static var items = "items.json"
        static var metaData = "metaData.json"
    }
    
    @Published var friendsItems: [UBItem] = []
    var mappedItems: [UUID: UBItem] = [:]
    private var friendsRemoteItems: [UBItemRemote] = []
    private var s3FileManager = S3FileManager()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        registerForEvents()
    }
    
    func item(by id: UUID) -> UBItem? {
        mappedItems[id]
    }
    
    private func registerForEvents() {
        AccountManager.sharedInstance.signedInState.sink { signInState in
            if signInState == .signedIn || signInState == .alreadySignedIn {
                self.readCache()
            }
        }
        .store(in: &subscriptions)
    }
    
    private var currentUserKey: String {
        guard let username = AccountManager.sharedInstance.currentUsername else {
            logger.log("FriendFeedModel: updateRemote: No local file exists")
            return ""
        }
        return username + "/" + Constants.items
    }
    
    private func readCache() {
        DispatchQueue.global().async {
            
            //1. get list of users except current user files
            self.s3FileManager.listUserFolders { list in
                list.items.forEach { [unowned self] item in
                    logger.log("FriendsFeedModel: readCache \(item.key)")
                    if item.key.suffix(4) != "json" {
                        return
                    }
                    if item.key != self.currentUserKey {
                        //2. download each user file into respective folder, only if remote file updated
                        if self.isRemoteFileChanged(key: item.key, lastModified: item.lastModified) {
                            logger.log("FriendFeedModel: readCache: RemoteFileChanged: downloading...")
                            self.downloadFile(key: item.key) { result in
                                //3. modify the downloaded file lastModifiedDate
                                self.updateLastModifiedDate(key: item.key, lastModified: item.lastModified ?? Date())
                                self.loadFile(key: item.key)
                            }
                        }
                        else {
                            self.loadFile(key: item.key)
                        }
                    }
                }
            }
        }
    }
    
    private func loadFile(key: String) {
        //4. load each file
        let friendItems = JsonInterpreter(filePath: key).read(type: UBItemRemote.self)
        //5. update each file content in user thread
        self.convertRemoteData(friendUsername: self.friendUserId(key: key) ?? "", remoteFriendsItems: friendItems)
    }
    private func isRemoteFileChanged(key: String, lastModified: Date?) ->  Bool {
        guard let remoteLastModified = lastModified else {
            return true
        }
        let friendPath = friendDocumentDirectory(key: key)
        let metadataFilename = friendPath.appendingPathComponent(Constants.items)
        
        if !FileManager.default.fileExists(atPath: metadataFilename.path) {
            return true
        }
        else {
            guard let attrs = try? FileManager.default.attributesOfItem(atPath: metadataFilename.path) else {
                return true
            }
            guard let lastModifiedDateFromFile = attrs[FileAttributeKey.modificationDate] as? Date else {
                return true
            }
            
            if lastModifiedDateFromFile < remoteLastModified {
                return true
            }
        }
        return false
    }
    
    private func friendUserId(key: String) -> String? {
        guard let index = key.firstIndex(of: "/") else {
            return nil
        }
        return String(key.prefix(upTo: index))
    }
    
    private func downloadFile(key: String, completion: @escaping (Bool)->Void) {
        let friendPath = friendDocumentDirectory(key: key)
        let pathWithFilename = friendPath.appendingPathComponent(Constants.items)
        s3FileManager.downloadRemote(key: key, localURL: pathWithFilename) { result in
            completion(result)
        }
    }
    
    private func updateLastModifiedDate(key: String, lastModified: Date) {
        let friendPath = friendDocumentDirectory(key: key)
        let pathWithFilename = friendPath.appendingPathComponent(Constants.items)
        
        var attrs: [FileAttributeKey: Any] = [:]
        attrs[FileAttributeKey.modificationDate] = lastModified
        
        try? FileManager.default.setAttributes(attrs, ofItemAtPath: pathWithFilename.path)
    }
    
    private func friendDocumentDirectory(key: String) -> URL {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("FriendsFeedModel: friendDocumentDirectory: invalid document directory")
        }
        guard let friendUsername = friendUserId(key: key) else {
            fatalError("FriendsFeedModel: friendDocumentDirectory: invalid user id")
        }
        let friendPath = documentDirectory.appendingPathComponent(friendUsername)
        if !FileManager.default.fileExists(atPath: friendPath.path) {
            try! FileManager.default.createDirectory(at: friendPath, withIntermediateDirectories: true)
        }
        return friendPath
    }
    
    private func convertRemoteData() {
        DispatchQueue.main.async {
            for remoteItem in self.friendsRemoteItems {
                var item = UBItem(name: remoteItem.name, itemid: remoteItem.itemid)
                item.imageURL = remoteItem.imageURL
                item.tags = remoteItem.tags
                item.price = remoteItem.price
                item.description = remoteItem.description
                item.originalItemURL = remoteItem.originalItemURL
                item.itemCount = remoteItem.itemCount
                item.ownerid = remoteItem.ownerid
                
                self.friendsItems.append(item)
            }
            self.updateMappedItems()
        }
    }
    
    private func convertRemoteData(friendUsername: String, remoteFriendsItems: [UBItemRemote]) {
        DispatchQueue.main.async {
            for remoteItem in remoteFriendsItems {
                var item = UBItem(name: remoteItem.name, itemid: remoteItem.itemid)
                item.imageURL = remoteItem.imageURL
                item.tags = remoteItem.tags
                item.price = remoteItem.price
                item.description = remoteItem.description
                item.originalItemURL = remoteItem.originalItemURL
                item.itemCount = remoteItem.itemCount
                item.ownerid = remoteItem.ownerid
                
                self.friendsItems.append(item)
            }
            self.updateMappedItems()
        }
    }
    
    private func updateMappedItems() {
        self.mappedItems = self.friendsItems.reduce(into: [UUID: UBItem]() ) {
            $0[$1.itemid] = $1
        }
    }
    
    func filteredItems(searchText: String?) -> [UBItem] {
        guard let searchText = searchText else {
            return self.friendsItems
        }
        
        let items = friendsItems.filter {
            $0.includes(searchText)
        }
        return items
    }
}

