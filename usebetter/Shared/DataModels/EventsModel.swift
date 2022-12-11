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
    @Published var mappedItems: [String: UBEvent] = [:]
    private var userfeed: UserFeedModel?
    private var friendsFeed: FriendsFeedModel?
    private var subscriptions = Set<AnyCancellable>()
    private var byOwnerSink: AnyCancellable!
    private var byReceiverSink: AnyCancellable!
    
    init() {
        print("EventsModel: init")
        registerForEvents()
    }
    
    func initialize(userfeed: UserFeedModel, friendsFeed: FriendsFeedModel) {
        self.userfeed = userfeed
        self.friendsFeed = friendsFeed
    }
    
    private func registerForEvents() {
        AccountManager.sharedInstance.signedInState.sink { signInState in
            if signInState == .signedIn || signInState == .alreadySignedIn {
                self.load()
            }
        }
        .store(in: &subscriptions)
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
        let predicateByOwner = keys.ownerid == AccountManager.sharedInstance.currentUsername
        
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
                    self.updateMappedItems(eventsToMerge: eventsFromDB)
                case .failure(let error):
                    print("EventsModel: loadEvensByOwner: failed \(error)")
                }
            }
    }
    
    private func loadEventsByReceiver() {
        let keys = UBEvent.keys
        let predicateByReceiver = keys.receiverid == AccountManager.sharedInstance.currentUsername
        
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
                    self.updateMappedItems(eventsToMerge: eventsFromDB)
                case .failure(let error):
                    print("EventsModel: loadEventsByReceiver: failed to query events \(error)")
                }
            }
    }
    
    func createRequest(for item: UBItem, byOwner: Bool = false) {
        let stateValue: Int = byOwner ? EventState.requestCancelByOwner.rawValue : EventState.requestInitiatedByReceiver.rawValue
        let tr = UBEvent(itemid:  item.itemid.uuidString,
                              ownerid: item.ownerid,
                         receiverid: AccountManager.sharedInstance.currentUsername!,
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
    
    private func updateMappedItems(eventsToMerge: List<UBEvent>) {
        DispatchQueue.main.async {
            print("EventsModel: updateMappedItems: \(eventsToMerge.count)")
            eventsToMerge.forEach { eventInDB in
                self.mappedItems[eventInDB.id] = eventInDB
            }
            self.events = self.mappedItems.map {$0.1}
        }
    }
    
    func updateEventState(by eventId: String, newState: EventState) {
        mappedItems[eventId]?.state = newState.rawValue
        updateRemoteEvent(by: eventId)
    }
    
    private func updateRemoteEvent(by eventId: String) {
        guard let event = mappedItems[eventId] else {
            print("EventsModel: updateEvent: eventId does not exists \(eventId)")
            return
        }
        
        //Event update is new record DB, this way old transaction is not overwritten
        Amplify.API.mutate(request: .create(event))
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
                    self.loadEventsByReceiver()
                case .failure(let error):
                    print("EventsModel: sendRequest: receiveValue failed to create evnets \(error)")
                }
            }
            .store(in: &subscriptions)
    }
}
