//
//  TransactionsModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/30/22.
//

import Foundation
import Amplify
import Combine

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

struct Events: Identifiable {
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
    @Published var events: [Events] = []
    private var userfeed: UserFeedModel?
    private var friendsFeed: FriendsFeedModel?
    private var subscriptions = Set<AnyCancellable>()
    

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
        let t1 = Events(transid: UUID(), itemid: UUID(), owner: "17142615481", receiver: "17142615482", datetime: 1234567890, state: TransactionState(rawValue: 100)!)//, item: UBItem(name: "some item name", itemid: UUID(), imageURL: "https://m.media-amazon.com/images/I/41t1e3ZeMYS._AC_US40_.jpg"))
        events.append(t1)
        
        let t2 = Events(transid: UUID(), itemid: UUID(), owner: "17142615481", receiver: "17142615482", datetime: 1234567890, state: TransactionState(rawValue: 101)!)//, item: UBItem(name: "some item name", itemid: UUID(), imageURL: "https://m.media-amazon.com/images/I/41DEXHM8zLL._AC_US40_.jpg"))
        events.append(t2)
        
        let t3 = Events(transid: UUID(), itemid: UUID(), owner: "17142615481", receiver: "17142615482", datetime: 1234567890, state: TransactionState(rawValue: 102)!)//, item: UBItem(name: "some item name", itemid: UUID(), imageURL: "https://m.media-amazon.com/images/I/51kixorXZ6L._AC_US40_.jpg"))
        events.append(t3)
        
        let t4 = Events(transid: UUID(), itemid: UUID(), owner: "17142615481", receiver: "17142615482", datetime: 1234567890, state: TransactionState(rawValue: 103)!)//, item: UBItem(name: "some item name", itemid: UUID(), imageURL: "https://images-na.ssl-images-amazon.com/images/I/41nwF-OVmFS.__AC_SX300_SY300_QL70_ML2_.jpg"))
        events.append(t4)
        let keys = UBEvent.keys
        let predicateByOwner = keys.ownerid == AccountManager().currentUsername!
        
        Amplify.API.query(request: .paginatedList(UBEvent.self, where: predicateByOwner, limit: 100 ))
            .resultPublisher
            .sink {
                if case let .failure(error) = $0 {
                    print("TransactionModel: loadRemote: failed to query transactions by owner id \(error)")
                }
            }
            receiveValue: { result in
                switch result {
                case .success(let transactions):
                    if transactions.isEmpty {
                        print("TransactionModel: loadRemote: no by owner id transactions found")
                    }
                    print("TransactionModel: loadRemote:  by owner idtransactions read")
                case .failure(let error):
                    print("TransactionModel: loadRemote: by owner id failed \(error)")
                }
            }
            .store(in: &subscriptions)
        
        let predicateByReceiver = keys.receiverid == AccountManager().currentUsername!
        
        Amplify.API.query(request: .paginatedList(UBEvent.self, where: predicateByReceiver, limit: 100 ))
            .resultPublisher
            .sink {
                if case let .failure(error) = $0 {
                    print("TransactionModel: loadRemote: failed to  failed to query transactions by receiver id \(error)")
                }
            }
            receiveValue: { result in
                switch result {
                case .success(let transactions):
                    if transactions.isEmpty {
                        print("TransactionModel: loadRemote: no transactions found by receiver id")
                    }
                    print("TransactionModel: loadRemote: transactions read  by receiver id")
                case .failure(let error):
                    print("TransactionModel: loadRemote: failed to query transactions by receiver id  \(error)")
                }
            }
            .store(in: &subscriptions)
    }
    
    func sendRequest(for item: UBItem, byOwner: Bool = false) {
        let currentDateTime = UInt64(NSDate().timeIntervalSince1970)
        let t1 = Events(transid: UUID(), itemid: item.itemid, owner: item.ownerid, receiver: AccountManager().currentUsername!, datetime: currentDateTime, state: byOwner ? .requestCancelByOwner : .requestInitiatedByReceiver)
        events.append(t1)
        

        let stateValue: Int = byOwner ? TransactionState.requestCancelByOwner.rawValue : TransactionState.requestInitiatedByReceiver.rawValue
        let tr = UBEvent(itemid:  item.itemid.uuidString,
                              ownerid: item.ownerid,
                              receiverid: AccountManager().currentUsername!,
                              state: stateValue)

        
        Amplify.API.mutate(request: .create(tr))
            .resultPublisher
            .sink {
                if case let .failure(error) = $0 {
                    print("TransactionModel: sendRequest: failed to create transaction \(error)")
                }
            }
            receiveValue: { result in
                switch result {
                case .success(let trans):
                    print("TransactionModel: sendRequest: successfull \(trans)")
                case .failure(let error):
                    print("TransactionModel: sendRequest: receiveValue failed to create transaction \(error)")
                }
            }
            .store(in: &subscriptions)
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
