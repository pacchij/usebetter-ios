//
//  AccountManager.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/22/22.
//

import Foundation
import Combine

//aws
import AWSCognitoAuthPlugin
import Amplify
//import AWSMobileClientXCF

enum SingInState {
    case signedIn
    case error
    case alreadySignedIn
    case signedUp
    case pendingEmailConfirm
    case notSignedIn
}

enum OtpConfirmState {
    case success
    case failure
}

class AccountManager {
    var bag = Set<AnyCancellable>()
    static var sharedInstance = AccountManager()
    var signedInState: CurrentValueSubject<SingInState, Never> = .init(.notSignedIn)
    private var attributes: [AuthUserAttribute] = []
    private var currentUserName_: String? = nil
    
    var currentUsername: String? {
        if currentUserName_ == nil {
            Task {
                currentUserName_ = try? await Amplify.Auth.getCurrentUser().username
                logger.debug("[AccountManager] currentUsername:  success")
                if currentUserName_ != nil {
                    self.signedInState.send(.signedIn)
                    fetchAttributes()
                }
            }
        }
        return currentUserName_
    }
    
    private init() {
        fetchSignInState()
    }
    
    private func fetchSignInState() {
        _ = currentUsername
    }
    
    func signIn(email: String, password: String) {
        Task {
            do {
                //Try signIn First, if user does not exist, signUp
                guard currentUsername == nil else {
                    logger.log("AccountManager: signIn: already signed In \(self.currentUsername ?? "")")
                    self.signedInState.send(.alreadySignedIn)
                    return
                }
                let result = try await Amplify.Auth.signIn(username: email, password: password)
                if result.isSignedIn {
                    self.signedInState.send(.signedIn)
                }
                else {
                    self.signedInState.send(.notSignedIn)
                }
            }
            catch {
                logger.error("AccountManager: signIn Exception")
                self.signedInState.send(.error)
            }
        }
    }
    
    private func signUp(email: String, password: String) {
        Task {
            do {
                let userAttributes = [AuthUserAttribute(.email, value: email)]
                let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
                let result = try await Amplify.Auth.signUp(username: email, password: password, options: options)
                if result.isSignUpComplete {
                    self.signedInState.send(.signedIn)
                }
                else {
                    switch result.nextStep {
                    case .confirmUser(let details, let info, let userid):
                        logger.log("confirm user is pending")
                    case .done:
                        logger.log("confirm user is done")
                    }
                }
            }
        }
    }
    
    func confirmSignUp(username: String, confirmationCode: String) -> PassthroughSubject<OtpConfirmState, Never> {
        let otpState = PassthroughSubject <OtpConfirmState, Never>()
        Task {
            do {
                let result = try await Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode)
                if result.isSignUpComplete {
                    otpState.send(.success)
                }
                else {
                    otpState.send(.failure)
                }
            }
            catch {
                logger.error("AccountManager: fetchAttributes Exception")
                otpState.send(.failure)
            }
        }
        return otpState
    }
    
    private func fetchAttributes()  {
        logger.log("AccountManager: fetchAttributes entered")
        Task {
            do {
                self.attributes = try await Amplify.Auth.fetchUserAttributes()
                logger.log("AccountManager: fetchAttributes: \(String(describing: self.attributes))")
            }
            catch {
                logger.error("AccountManager: fetchAttributes Exception \(error)")
            }
        }
    }
    
    var displayName: String {
        if signedInState.value != .signedIn {
            return "Unassigned"
        }
        
        let key = AuthUserAttributeKey.custom("displayName")
        let results = self.attributes.filter { attr in
            attr.key == key
        }
        if results.count > 0 {
            return results[0].value
        }
        else {
            let firstNameKey = AuthUserAttributeKey.custom("firstName")
            let fName = self.attributes.filter { attr in
                attr.key == firstNameKey
            }
            let lastNameKey = AuthUserAttributeKey.custom("lastName")
            let lName = self.attributes.filter { attr in
                attr.key == lastNameKey
            }
            if fName.count > 0 || lName.count > 0 {
                var displayName_ = ""
                if fName.count > 0 {
                    displayName_ += fName[0].value
                    displayName_ += " "
                }
                if lName.count > 0 {
                    displayName_ += lName[0].value
                }
                return displayName_
            }
            else {
                return emailId
            }
        }
    }
    
    var emailId: String {
        if signedInState.value != .signedIn {
            return ""
        }
        
        let key = AuthUserAttributeKey.email
        let results = self.attributes.filter { attr in
            attr.key == key
        }
        return (results.count > 0) ? results[0].value : ""
    }
}
