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
        logger.log("EventsModel: init")
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
        Task {
            await loadEvensByOwner()
            await loadEventsByReceiver()
        }
    }
    
    private func loadEvensByOwner() async {
        let keys = UBEvent.keys
        let predicateByOwner = keys.ownerid == AccountManager.sharedInstance.currentUsername
        let request = GraphQLRequest<UBEvent>.list(UBEvent.self, where: predicateByOwner, limit: 1000)
        do {
            let result = try await Amplify.API.query(request: request)
            switch result {
            case .success(let eventsFromDB):
                if eventsFromDB.isEmpty {
                    logger.log("EventsModel: loadEvensByOwner: no events found")
                }
                logger.log("EventsModel: loadEvensByOwner: events read")
                self.updateMappedItems(eventsToMerge: eventsFromDB)
                await self.loadEventsRecursively(currentPage: eventsFromDB)
            case .failure(let error):
                logger.log("EventsModel: loadEvensByOwner: failed \(error)")
            }
        }
        catch {
            logger.error("EventsModel: loadEvensByOwner: Exception \(error)")
        }
    }
    
    private func loadEventsRecursively(currentPage: List<UBEvent>?) async {
        if let current = currentPage, current.hasNextPage() {
            do {
                let currentEvents = try await current.getNextPage()
                self.updateMappedItems(eventsToMerge: currentEvents)
                await self.loadEventsRecursively(currentPage: currentEvents)
            } catch {
                print("Failed to get next page \(error)")
            }
        }
    }
    
    private func loadEventsByReceiver() async {
        let keys = UBEvent.keys
        let predicateByReceiver = keys.receiverid == AccountManager.sharedInstance.currentUsername
        let request = GraphQLRequest<UBEvent>.list(UBEvent.self, where: predicateByReceiver, limit: 1000)
        do {
            let result = try await Amplify.API.query(request: request)
            switch result {
            case .success(let eventsFromDB):
                if eventsFromDB.isEmpty {
                    logger.log("EventsModel: loadEventsByReceiver: no events found")
                }
                logger.log("EventsModel: loadEventsByReceiver: events read")
                self.updateMappedItems(eventsToMerge: eventsFromDB)
                await self.loadEventsRecursively(currentPage: eventsFromDB)
            case .failure(let error):
                logger.log("EventsModel: loadEventsByReceiver: failed to query events \(error)")
            }
        }
        catch {
            logger.error("EventsModel: loadEventsByReceiver: Exception \(error)")
        }
    }
    
    func createRequest(for item: UBItem, byOwner: Bool = false) {
        Task {
            let stateValue: Int = byOwner ? EventState.requestCancelByOwner.rawValue : EventState.requestInitiatedByReceiver.rawValue
            let tr = UBEvent(itemid:  item.itemid.uuidString,
                             ownerid: item.ownerid,
                             receiverid: AccountManager.sharedInstance.currentUsername!,
                             state: stateValue)
            do {
                let result = try await Amplify.API.mutate(request: .create(tr))
                switch result {
                case .success(_):
                    logger.log("EventsModel: sendRequest: successfull")
                    self.loadRemote()
                case .failure(let error):
                    logger.log("EventsModel: sendRequest: receiveValue failed to create evnets \(error)")
                }
            }
            catch {
                logger.log("EventsModel: sendRequest: failed to create events \(error)")
            }
        }
    }
    
    func item(by id: String) -> UBItem? {
        guard let itemUUID = UUID(uuidString: id) else {
            logger.log("EventsModel: item: item id is invalid")
            return nil
        }
        if let userItem = userfeed?.item(by: itemUUID) {
            return userItem
        }
        else {
            return friendsFeed?.item(by: itemUUID)
        }
    }
    
    func event(by id: String) -> UBEvent? {
        mappedItems[id]
    }
    
    private func updateMappedItems(eventsToMerge: List<UBEvent>) {
        DispatchQueue.main.async {
            logger.log("EventsModel: updateMappedItems: \(eventsToMerge.count)")
            eventsToMerge.forEach { eventInDB in
                self.mappedItems[eventInDB.id] = eventInDB
            }
            self.events = self.mappedItems.map {$0.1}
        }
    }
    
    func updateEventState(by eventId: String, newState: EventState) {
        mappedItems[eventId]?.state = newState.rawValue
        Task {
            await updateRemoteEvent(by: eventId)
        }
    }
    
    private func updateRemoteEvent(by eventId: String) async {
        guard let event = mappedItems[eventId] else {
            logger.log("EventsModel: updateEvent: eventId does not exists \(eventId)")
            return
        }
        do {
            //Event update is new record DB, this way old transaction is not overwritten
            let result = try await Amplify.API.mutate(request: .create(event))
            switch result {
            case .success(_):
                logger.log("EventsModel: updateRemoteEvent: successfull")
                self.loadRemote()
            case .failure(let error):
                logger.log("EventsModel: updateRemoteEvent: receiveValue failed to create evnets \(error)")
            }
        }
        catch {
            logger.log("EventsModel: updateRemoteEvent: Exception to create events \(error)")
        }
    }
    
    func filteredEvents() -> [UBEvent] {
        return self.events
    }
}


class MockEventsModel: EventsModel {
    override func filteredEvents() -> [UBEvent] {
        var mockEvents: [UBEvent] = []
        mockEvents.append(UBEvent(itemid: UUID().uuidString, ownerid: "ownerid1", receiverid: "receivedid1", state: EventState.requestInitiatedByOwner.rawValue))
        mockEvents.append(UBEvent(itemid: UUID().uuidString, ownerid: "ownerid2", receiverid: "receivedid1", state: EventState.requestInitiatedByOwner.rawValue))
        mockEvents.append(UBEvent(itemid: UUID().uuidString, ownerid: "ownerid3", receiverid: "receivedid1", state: EventState.requestInitiatedByOwner.rawValue))
        return mockEvents
    }
    
    override func item(by id: String) -> UBItem? {
        UBItem(name: "item1", itemid: UUID())
    }
}
