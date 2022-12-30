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
        //        Task {
        //            switch(AWSMobileClient.default().currentUserState) {
        //            case .signedIn:
        //                logger.log("[AccountManager] fetchSignInState: signedIn")
        //                if let localuser = currentUsername {
        //                    logger.debug("AccountManager fetchSignInState: currentUsername = \(localuser)")
        //                }
        //                signedInState = (try? await Amplify.Auth.getCurrentUser()) == nil ? .init(.notSignedIn) : .init(.signedIn)
        //                if signedInState.value == .signedIn {
        //                    fetchAttributes()
        //                }
        //            case .signedOut:
        //                logger.log("[AccountManager] fetchSignInState: signedOut")
        //            case .signedOutFederatedTokensInvalid:
        //                logger.log("[AccountManager] fetchSignInState: signedOutFederatedTokensInvalid")
        //            case .signedOutUserPoolsTokenInvalid:
        //                logger.log("[AccountManager] fetchSignInState: signedOutUserPoolsTokenInvalid")
        //            case .guest:
        //                logger.log("[AccountManager] fetchSignInState: guest")
        //            case .unknown:
        //                logger.log("[AccountManager] fetchSignInState: unknown")
        //            @unknown default:
        //                logger.log("[AccountManager] fetchSignInState: default")
        //            }
        //        }
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
    //                .resultPublisher
    //                .sink {
    //                    if case let .failure(authError) = $0 {
    //                        logger.log("AccountManager: signIn: SignIn Failed \(authError)")
    //                        self.signUp(email: email, password: password)
    //                    }
    //                    else {
    //                        self.signedInState.send(.signedIn)
    //                    }
    //                }
    //        receiveValue: { result in
    //            switch result.nextStep {
    //            case .confirmSignUp(let info):
    //                logger.log("AccountManager: signIn confirmSignup \(info?.description ?? "")")
    //            case .done:
    //                logger.log("AccountManager: signIn: Sign IN succeeded")
    //                self.signedInState.send(.signedIn)
    //            default:
    //                logger.log("AccountManager: signIn ")
    //            }
    //        }
    //.store(in: &bag)
    //        }
    //    }
    
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
    //            .resultPublisher
    //            .sink {
    //                if case let .failure(authError) = $0 {
    //                    logger.log("AccountManager: signUp: An error occurred while registering a user \(authError)")
    //                    self.signedInState.send(.error)
    //                }
    //            }
    //    receiveValue: { signUpResult in
    //        if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
    //            logger.log("Delivery details \(String(describing: deliveryDetails))")
    //            self.signedInState.send(.pendingEmailConfirm)
    //        } else {
    //            logger.log("AccountManager: signUp: SignUp Complete")
    //            Amplify.Auth.update(userAttribute: AuthUserAttribute(AuthUserAttributeKey.custom("displayName"), value: email)) { error in
    //                logger.log("AccountManager: signUp updateUserAttribute return error")
    //            }
    //            self.signedInState.send(.signedIn)
    //        }
    //    }
    //        //.store(in: &bag)
    //    }
    
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
    //            .resultPublisher
    //            .sink {
    //                if case let .failure(authError) = $0 {
    //                    logger.log("AccountManager: confirm: confirm failed \(authError)")
    //                    otpState.send(.failure)
    //                }
    //            }
    //    receiveValue: { _ in
    //        logger.log("AccountManager: confirm: confirm sucess")
    //        otpState.send(.success)
    //    }
    //        // .store(in: &bag)
    //        return otpState
    //    }
    
    private func fetchAttributes()  {
        logger.log("AccountManager: fetchAttributes entered")
        Task {
            do {
                self.attributes = try await Amplify.Auth.fetchUserAttributes()
            }
            catch {
                logger.error("AccountManager: fetchAttributes Exception")
            }
        }
    }
    //.resultPublisher
    //            .sink {
    //                if case let .failure(fetchError) = $0 {
    //                    logger.log("AccountManager: fetchAttributes: failed with error \(fetchError)")
    //                }
    //                else {
    //                    logger.log("AccountManager: fetchAttributes: success")
    //                }
    //            }
    //        receiveValue: { attributes in
    //            logger.log("AccountManager: fetchAttributes attributes - \(attributes)")
    // self.attributes = attributes
    // .store(in: &bag)
    // }
    
    var displayName: String {
        if signedInState.value != .signedIn {
            return "Unassigned"
        }
        
        let key = AuthUserAttributeKey.custom("displayName")
        let results = self.attributes.filter { attr in
            attr.key == key
        }
        return (results.count > 0) ? results[0].value : currentUsername ?? "Unassigned"
    }
}
