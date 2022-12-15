//
//  UserFeedModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/18/22.
//

import Foundation
import Combine
import os

import Amplify
import AWSS3

class UserFeedModel: ObservableObject {
    
    struct Constants {
        static var userFeed = "items.json"
    }
    
    @Published var userItems: [UBItem] = []
    var mappedItems: [UUID: UBItem] = [:]
    private var userRemoteItems: [UBItemRemote] = []
    private var bag = Set<AnyCancellable>()
    private var s3FileManager = S3FileManager()
    
    init() {
        registerForEvents()
    }
    
    func update() {
        updateLocalCache()
    }
    
    func append(item: UBItem) {
        userItems.append(item)
        updateMappedItems()
        updateLocalCache()
    }
    
    func sync() {
        readRemote() { _ in
        }
    }
    
    func item(by id: UUID) -> UBItem? {
        mappedItems[id]
    }
    
    func updateName(by id: UUID, name: String) {
        mappedItems[id]?.name = name
    }
    
    func updateCount(by id: UUID, count: Int) {
        mappedItems[id]?.itemCount = count
    }
    
    private func registerForEvents() {
        AccountManager.sharedInstance.signedInState.sink { signInState in
            if signInState == .signedIn || signInState == .alreadySignedIn {
                self.readCache()            }
        }
        .store(in: &bag)
    }
    
    private func readCache() {
        DispatchQueue.global().async {
            self.userRemoteItems = JsonInterpreter(filePath: Constants.userFeed).read(type: UBItemRemote.self)
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
                var item = UBItem(name: remoteItem.name, itemid: remoteItem.itemid)
                item.imageURL = remoteItem.imageURL
                item.tags = remoteItem.tags
                item.price = remoteItem.price
                item.description = remoteItem.description
                item.originalItemURL = remoteItem.originalItemURL
                item.itemCount = remoteItem.itemCount
                item.ownerid = remoteItem.ownerid
                
                self.userItems.append(item)
            }
            self.updateMappedItems()
        }
    }
    
    private func updateLocalCache() {
        DispatchQueue.global().async {
            //update remote items
            self.userRemoteItems = []
            for item in self.userItems {
                var remoteItem = UBItemRemote(name: item.name, itemid: item.itemid, ownerid: item.ownerid)
                remoteItem.tags = item.tags
                remoteItem.price = item.price
                remoteItem.originalItemURL = item.originalItemURL
                remoteItem.imageURL = item.imageURL
                remoteItem.description = item.description
                remoteItem.itemCount = item.itemCount
                remoteItem.ownerid = item.ownerid
                self.userRemoteItems.append(remoteItem)
            }
            JsonInterpreter(filePath: Constants.userFeed).write(data: self.userRemoteItems)
            self.updateRemote()
        }
    }
    
    private func readRemote(completion: @escaping (Bool)->Void) {
        guard let localURL = userFeedFile() else {
            logger.log("UserFeedModel: readRemote: No local file exists")
            return
        }
        
        guard let username = Amplify.Auth.getCurrentUser()?.username else {
            logger.log("UserFeedModel: readRemote: No local file exists")
            return
        }
        
        s3FileManager.downloadRemote(key: username+"/"+Constants.userFeed, localURL: localURL) { result in
            logger.log("UserFeedModel: readRemote: Completed: \(result)")
            completion(result)
        }
    }
    
    private func updateRemote() {
        guard let localURL = userFeedFile() else {
            logger.log("UserFeedModel: updateRemote: No local file exists")
            return
        }
        
        guard let username = Amplify.Auth.getCurrentUser()?.username else {
            logger.log("UserFeedModel: updateRemote: No local file exists")
            return
        }
        
        S3FileManager().updateRemote(key: username+"/"+Constants.userFeed, localURL: localURL) { result in
            logger.log("UserFeedModel: updateRemote: Completed: \(result)")
        }
    }
    
    private func userFeedFile() -> URL? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(Constants.userFeed)
            return pathWithFilename
        }
        return nil
    }
    
    private func updateMappedItems() {
        self.mappedItems = self.userItems.reduce(into: [UUID: UBItem]() ) {
            $0[$1.itemid] = $1
        }
    }
    
    func filteredItems(searchText: String?) -> [UBItem] {
        guard let searchText = searchText, searchText.count > 0 else {
            return self.userItems
        }
        
        let items = userItems.filter {
            $0.includes(searchText)
        }
        return items
    }
 
}
