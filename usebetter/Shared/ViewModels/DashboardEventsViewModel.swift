//
//  DashboardEventsViewModel.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 6/1/22.
//

import Foundation
import SwiftUI
import Amplify

struct EventUIStates {
    var label: String
    var primaryButtonText: String?
    var primaryButtonActionState: EventState?
    var secondaryButtonText: String?
    var secondaryButtonActionState: EventState?
}

struct EventsStateMachine {
    var state: EventState
    var ownerUIState: EventUIStates
    var receiverUIState: EventUIStates
}

class DashboardEventsViewModel {
    var eventsStateMachine: [EventState: EventsStateMachine] = [:]
    
    private let invalidUIState = EventUIStates(label: "Unknown state", primaryButtonText: nil, primaryButtonActionState: nil, secondaryButtonText: nil, secondaryButtonActionState: nil)
    private let previewUIState = EventUIStates(label: "Example UI State", primaryButtonText: "Accept", primaryButtonActionState: .archived, secondaryButtonText: "Cancel", secondaryButtonActionState: .archived)
    
    init() {
        initializeStates()
        
    }
    
    func stateMachine(for state: EventState) {
        
    }
    private func initializeStates() {
        eventsStateMachine[.requestInitiatedByOwner] = EventsStateMachine(state: .requestInitiatedByOwner,
                            ownerUIState: EventUIStates(label: "You initiated UseBetter to", primaryButtonText: "Sent", primaryButtonActionState: .itemSentByOwner, secondaryButtonText: "Cancel", secondaryButtonActionState: .requestCancelByOwner),
                            receiverUIState: EventUIStates(label: "You have a request to UseBetter from", primaryButtonText: "Received", primaryButtonActionState: .itemReceivedAckByReceiver, secondaryButtonText: "Cancel", secondaryButtonActionState: .requestCancelledByReceiver)
                                )
        
        eventsStateMachine[.returnRequestByOwner] = EventsStateMachine(state: .returnRequestByOwner,
                             ownerUIState: EventUIStates(label: "You requested return from", primaryButtonText: "Received", primaryButtonActionState: .itemReceivedAckByOwner, secondaryButtonText: "Cancel", secondaryButtonActionState: .requestCancelByOwner),
                             receiverUIState: EventUIStates(label: "You have a request to return from", primaryButtonText: "Sent", primaryButtonActionState: .itemReturnedByReceiver, secondaryButtonText: nil, secondaryButtonActionState: nil)
                                )
        
        eventsStateMachine[.requestAcceptedByOwner] = EventsStateMachine(state: .requestAcceptedByOwner,
                                                                         ownerUIState: EventUIStates(label: "You accepted UseBetter request from", primaryButtonText: "Sent", primaryButtonActionState: .itemSentByOwner, secondaryButtonText: "Cancel", secondaryButtonActionState: .requestCancelByOwner),
                                                                         receiverUIState: EventUIStates(label: "Your request accepted by", primaryButtonText: "Received", primaryButtonActionState: .itemReceivedAckByReceiver, secondaryButtonText: "Cancel", secondaryButtonActionState: .requestCancelledByReceiver)
                                )
        
        
        eventsStateMachine[.requestCancelByOwner] = EventsStateMachine(state: .requestCancelByOwner,
                             ownerUIState: EventUIStates(label: "You cancelled UseBetter request from", primaryButtonText: nil, primaryButtonActionState: nil, secondaryButtonText: nil, secondaryButtonActionState: nil),
                             receiverUIState: EventUIStates(label: "Your request cancelled by", primaryButtonText: "Request Again", primaryButtonActionState: .requestInitiatedByReceiver, secondaryButtonText: "Cancel", secondaryButtonActionState: .archived)
                                )
        
        
        eventsStateMachine[.itemReceivedAckByOwner] = EventsStateMachine(state: .itemReceivedAckByOwner,
                             ownerUIState: EventUIStates(label: "You received item from", primaryButtonText: "Received", primaryButtonActionState: .itemReceivedAckByOwner, secondaryButtonText: nil, secondaryButtonActionState: nil),
                             receiverUIState: EventUIStates(label: "Your item received by", primaryButtonText: "Send Thanks", primaryButtonActionState: .archived, secondaryButtonText: nil, secondaryButtonActionState: nil)
                                )
        
        eventsStateMachine[.itemSentByOwner] = EventsStateMachine(state: .itemSentByOwner,
                                                                  ownerUIState: EventUIStates(label: "You sent an item to", primaryButtonText: "Received", primaryButtonActionState: .itemReceivedAckByOwner, secondaryButtonText: nil, secondaryButtonActionState: nil),
                                                                  receiverUIState: EventUIStates(label: "You have an item from", primaryButtonText: "Return", primaryButtonActionState: .itemReturnedByReceiver, secondaryButtonText: nil, secondaryButtonActionState: nil)
                                )
        
        eventsStateMachine[.requestInitiatedByReceiver] = EventsStateMachine(state: .requestInitiatedByReceiver,
                             ownerUIState: EventUIStates(label: "You have a new request from", primaryButtonText: "Accept", primaryButtonActionState: .requestAcceptedByOwner, secondaryButtonText: "Ignore", secondaryButtonActionState: .requestCancelByOwner),
                             receiverUIState: EventUIStates(label: "You requested an item from", primaryButtonText: "Received", primaryButtonActionState: .itemReceivedAckByReceiver, secondaryButtonText: "Cancel", secondaryButtonActionState: .requestCancelledByReceiver)
                                )
        
        
        eventsStateMachine[.itemReceivedAckByReceiver] = EventsStateMachine(state: .itemReceivedAckByReceiver,
                             ownerUIState: EventUIStates(label: "You sent an item to", primaryButtonText: "Request Return", primaryButtonActionState: .returnRequestByOwner, secondaryButtonText: nil, secondaryButtonActionState: nil),
                             receiverUIState: EventUIStates(label: "You have an item from", primaryButtonText: "Returned", primaryButtonActionState: .itemReturnedByReceiver, secondaryButtonText: nil, secondaryButtonActionState: nil)
                                )
        
        
        eventsStateMachine[.itemReturnedByReceiver] = EventsStateMachine(state: .itemReturnedByReceiver,
                             ownerUIState: EventUIStates(label: "Your item returned by", primaryButtonText: "Received", primaryButtonActionState: .itemReceivedAckByOwner, secondaryButtonText: nil, secondaryButtonActionState: nil),
                             receiverUIState: EventUIStates(label: "You returned an item to", primaryButtonText: "Thank You", primaryButtonActionState: .archived, secondaryButtonText: nil, secondaryButtonActionState: nil)
                                )
        
        
        eventsStateMachine[.requestCancelledByReceiver] = EventsStateMachine(state: .requestCancelledByReceiver,
                             ownerUIState: EventUIStates(label: "Request cancelled by", primaryButtonText: nil, primaryButtonActionState: nil, secondaryButtonText: nil, secondaryButtonActionState: nil),
                             receiverUIState: EventUIStates(label: "You cancelled request to", primaryButtonText: nil, primaryButtonActionState: nil, secondaryButtonText: nil, secondaryButtonActionState: nil)
                                )
        
        eventsStateMachine[.archived] = EventsStateMachine(state: .archived,
                             ownerUIState: EventUIStates(label: "Archived item with", primaryButtonText: nil, primaryButtonActionState: nil, secondaryButtonText: nil, secondaryButtonActionState: nil),
                             receiverUIState: EventUIStates(label: "Archived item with", primaryButtonText: nil, primaryButtonActionState: nil, secondaryButtonText: nil, secondaryButtonActionState: nil)
                                )
    }
    
    func getUIState(for event: UBEvent, _ isPreview: Bool = false) -> EventUIStates {
        guard !isPreview else {
            return previewUIState
        }
        guard let currentUser = Amplify.Auth.getCurrentUser() else {
            return invalidUIState
        }
        let eventState = EventState(rawValue: event.state) ?? EventState.archived
        logger.log("DashboardEventsViewModel: getUIState: currentUser \(currentUser.username) event.ownerID \(event.ownerid) eventState \(eventState.rawValue)")
        if currentUser.username == event.ownerid {
            return eventsStateMachine[eventState]?.ownerUIState ?? invalidUIState
        }
        else {
            return eventsStateMachine[eventState]?.receiverUIState ?? invalidUIState
        }
    }
}
