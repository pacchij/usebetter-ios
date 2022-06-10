//
//  TransactionsModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/30/22.
//

import Foundation

enum TransactionState: Int {
    case requestInitiatedByOwner = 100
    case returnRequestByOwner = 101
    case requestAcceptedByOwner = 102
    case requestCancelByOwner = 103

    
    case itemReceivedAckByOwner = 200
    case itemSentByOwner = 201
    
    case requestInitiatedByReceiver = 300
    case itemReceivedAckByReceiver = 301
    case itemReturnedByReceiver = 302
    case requestCancelledByReceiver = 303
    
    case archived = 500
}

struct Transactions: Identifiable {
    var transid: UUID
    var itemid: UUID
    var owner: String
    var receiver: String
    var datetime: UInt64
    var state: TransactionState
    var id: UUID { transid }
}

struct RemoteTransactions: Codable {
    var transid: UUID
    var itemid: UUID
    var owner: String
    var receiver: String
    var datetime: Int64
    var state: Int
}

class TransactionsModel: ObservableObject {
    @Published var transactions: [Transactions] = []
    private var userfeed: UserFeedModel?
    private var friendsFeed: FriendsFeedModel?
    

    init() {
        print("TransactionsModel: init")
        load()
    }
    
    func initialize(userfeed: UserFeedModel, friendsFeed: FriendsFeedModel) {
        self.userfeed = userfeed
        self.friendsFeed = friendsFeed
    }
    
    private func load() {
        DispatchQueue.global().async {
            self.loadRemote()
        }
    }
    
    private func loadRemote() {
        let t1 = Transactions(transid: UUID(), itemid: UUID(), owner: "17142615481", receiver: "17142615482", datetime: 1234567890, state: TransactionState(rawValue: 100)!)//, item: UBItem(name: "some item name", itemid: UUID(), imageURL: "https://m.media-amazon.com/images/I/41t1e3ZeMYS._AC_US40_.jpg"))
        transactions.append(t1)
        
        let t2 = Transactions(transid: UUID(), itemid: UUID(), owner: "17142615481", receiver: "17142615482", datetime: 1234567890, state: TransactionState(rawValue: 101)!)//, item: UBItem(name: "some item name", itemid: UUID(), imageURL: "https://m.media-amazon.com/images/I/41DEXHM8zLL._AC_US40_.jpg"))
        transactions.append(t2)
        
        let t3 = Transactions(transid: UUID(), itemid: UUID(), owner: "17142615481", receiver: "17142615482", datetime: 1234567890, state: TransactionState(rawValue: 102)!)//, item: UBItem(name: "some item name", itemid: UUID(), imageURL: "https://m.media-amazon.com/images/I/51kixorXZ6L._AC_US40_.jpg"))
        transactions.append(t3)
        
        let t4 = Transactions(transid: UUID(), itemid: UUID(), owner: "17142615481", receiver: "17142615482", datetime: 1234567890, state: TransactionState(rawValue: 103)!)//, item: UBItem(name: "some item name", itemid: UUID(), imageURL: "https://images-na.ssl-images-amazon.com/images/I/41nwF-OVmFS.__AC_SX300_SY300_QL70_ML2_.jpg"))
        transactions.append(t4)
    }
    
    func sendRequest(for item: UBItem, byOwner: Bool = false) {
        let t1 = Transactions(transid: UUID(), itemid: item.itemid, owner: item.ownerid, receiver: AccountManager().currentUsername!, datetime: UInt64(NSDate().timeIntervalSince1970), state: byOwner ? .requestCancelByOwner : .requestInitiatedByReceiver)
        transactions.append(t1)
    }
    
    func item(by id: UUID) -> UBItem? {
        if let userItem = userfeed?.item(by: id) {
            return userItem
        }
        else {
            return friendsFeed?.item(by: id)
        }
    }
}
