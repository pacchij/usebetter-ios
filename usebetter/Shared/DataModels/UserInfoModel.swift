//
//  UserInfoModel.swift
//  usebetter (iOS)
//
//  Created by Prashanth Jaligama on 2/19/23.
//

import Foundation
import Amplify
import Combine


class UserInfoModel: ObservableObject {
    private var currentUserInfo: UBUser? = nil
    private var bag = Set<AnyCancellable>()
    
    public init() {
        registerForEvents()
    }
    
    private func registerForEvents() {
        AccountManager.sharedInstance.signedInState
            .combineLatest(AppUserDefaults.shared.userAttributeChanged)
            .sink {
                if ($0.0 == .signedIn || $0.0 == .alreadySignedIn) && ($0.1 == true) {
                Task {
                    await self.updateUserInfo()
                }
            }
        }
        .store(in: &bag)
    }
    
    private func updateUserInfo() async {
        guard let currentUser = AccountManager.sharedInstance.currentUsername else {
            return
        }
        guard let emailId = AppUserDefaults.shared.emailId else {
            return
        }
        var updatedUser = UBUser(userId: currentUser, email: emailId)
        updatedUser.displayName = AppUserDefaults.shared.displayName
        updatedUser.firstName = AppUserDefaults.shared.firstName
        updatedUser.lastName = AppUserDefaults.shared.lastName
        updatedUser.fcmToken = AppUserDefaults.shared.fcmToken
        updatedUser.apnsToken = AppUserDefaults.shared.apnsToken
        
        do {
            let result = try await Amplify.API.mutate(request: .create(updatedUser))
            switch result {
            case .success(let dbSucessData):
                logger.log("UserInfoModel: updatedUserInfo success \(String(describing: dbSucessData))")
            case .failure(let error):
                logger.log("UserInfoModel: updatedUserInfo failed \(error)")
            }
            
        }
        catch {
            logger.log("EventsModel: loadEventsByReceiver: failed to query events \(error)")
        }
    }
    
    private func loadUserInfo() async {
        guard let currentUser = AccountManager.sharedInstance.currentUsername else {
            return
        }
        
        let keys = UBUser.keys
        let request = GraphQLRequest<UBUser>.get(UBUser.self, byId: currentUser)
        do {
            let result = try await Amplify.API.query(request: request)
            switch result {
            case .success(_):
//                if eventsFromDB.isEmpty {
//                    logger.log("EventsModel: loadEventsByReceiver: no events found")
//                }
                logger.log("EventsModel: loadEventsByReceiver: events read")
//                self.updateMappedItems(eventsToMerge: eventsFromDB)
//                await self.loadEventsRecursively(currentPage: eventsFromDB)
            case .failure(let error):
                logger.log("EventsModel: loadEventsByReceiver: failed to query events \(error)")
            }
        }
        catch {
            logger.error("EventsModel: loadEventsByReceiver: Exception \(error)")
        }
        
    }
    
    private func updateUserInfo() {
        
    }
    
    private func loadUserFriends() {
        
    }
    
    private func updateUserFriends() {
        
    }
    
    
}
