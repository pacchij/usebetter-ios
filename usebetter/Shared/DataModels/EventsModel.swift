//
//  EventsModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/30/22.
//

import Foundation
import Amplify
import Combine

enum EventState: Int {
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

class EventsModel: ObservableObject {
    @Published var events: [UBEvent] = []
    private var userfeed: UserFeedModel?
    private var friendsFeed: FriendsFeedModel?
    private var subscriptions = Set<AnyCancellable>()
    private var byOwnerSink: AnyCancellable!
    private var byReceiverSink: AnyCancellable!
    
    init() {
        print("EventsModel: init")
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
    
    func loadRemote() {
        loadEvensByOwner()
        loadEventsByReceiver()
    }
    
    private func loadEvensByOwner() {
        let keys = UBEvent.keys
        let predicateByOwner = keys.ownerid == AccountManager().currentUsername!
        
        byOwnerSink = Amplify.API.query(request: .paginatedList(UBEvent.self, where: predicateByOwner, limit: 100 ))
            .resultPublisher
            .sink {
                self.byOwnerSink.cancel()
                if case let .failure(error) = $0 {
                    print("EventsModel: loadEvensByOwner: failed to query events \(error)")
                }
            }
            receiveValue: { result in
                switch result {
                case .success(let eventsFromDB):
                    if eventsFromDB.isEmpty {
                        print("EventsModel: loadEvensByOwner: no events found")
                    }
                    print("EventsModel: loadEvensByOwner: events read")
                case .failure(let error):
                    print("EventsModel: loadEvensByOwner: failed \(error)")
                }
            }
    }
    
    private func loadEventsByReceiver() {
        let keys = UBEvent.keys
        let predicateByReceiver = keys.receiverid == AccountManager().currentUsername!
        
        byReceiverSink = Amplify.API.query(request: .paginatedList(UBEvent.self, where: predicateByReceiver, limit: 100 ))
            .resultPublisher
            .sink {
                self.byReceiverSink.cancel()
                if case let .failure(error) = $0 {
                    print("EventsModel: loadEventsByReceiver: failed to query events \(error)")
                }
            }
            receiveValue: { result in
                switch result {
                case .success(let eventsFromDB):
                    if eventsFromDB.isEmpty {
                        print("EventsModel: loadEventsByReceiver: no events found")
                    }
                    print("EventsModel: loadEventsByReceiver: events read")
                case .failure(let error):
                    print("EventsModel: loadEventsByReceiver: failed to query events \(error)")
                }
            }
    }
    
    func sendRequest(for item: UBItem, byOwner: Bool = false) {
        let stateValue: Int = byOwner ? EventState.requestCancelByOwner.rawValue : EventState.requestInitiatedByReceiver.rawValue
        let tr = UBEvent(itemid:  item.itemid.uuidString,
                              ownerid: item.ownerid,
                              receiverid: AccountManager().currentUsername!,
                              state: stateValue)
        
        Amplify.API.mutate(request: .create(tr))
            .resultPublisher
            .sink {
                if case let .failure(error) = $0 {
                    print("EventsModel: sendRequest: failed to create events \(error)")
                }
            }
            receiveValue: { result in
                switch result {
                case .success(let trans):
                    print("EventsModel: sendRequest: successfull \(trans)")
                case .failure(let error):
                    print("EventsModel: sendRequest: receiveValue failed to create evnets \(error)")
                }
            }
            .store(in: &subscriptions)
    }
    
    func item(by id: String) -> UBItem? {
        guard let itemUUID = UUID(uuidString: id) else {
            print("EventsModel: item: item id is invalid")
            return nil
        }
        if let userItem = userfeed?.item(by: itemUUID) {
            return userItem
        }
        else {
            return friendsFeed?.item(by: itemUUID)
        }
    }
}
