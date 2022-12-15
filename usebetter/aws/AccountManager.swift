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
    
    var currentUsername: String? {
        Amplify.Auth.getCurrentUser()?.username 
    }
    
    private init() {
        signedInState = Amplify.Auth.getCurrentUser() == nil ? .init(.notSignedIn) : .init(.signedIn)
        if signedInState.value == .signedIn {
            fetchAttributes()
        }
    }
    
    func signIn(email: String, password: String) {
        //Try signIn First, if user does not exist, signUp
        guard Amplify.Auth.getCurrentUser() == nil else {
            logger.log("AccountManager: signIn: already signed In \(Amplify.Auth.getCurrentUser()?.username ?? "")")
            self.signedInState.send(.alreadySignedIn)
            return
        }
        let _ = Amplify.Auth.signIn(username: email, password: password)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                        logger.log("AccountManager: signIn: SignIn Failed \(authError)")
                    self.signUp(email: email, password: password)
                }
                else {
                    self.signedInState.send(.signedIn)
                }
            }
            receiveValue: { result in
                switch result.nextStep {
                case .confirmSignUp(let info):
                    logger.log("AccountManager: signIn confirmSignup \(info?.description ?? "")")
                case .done:
                    logger.log("AccountManager: signIn: Sign IN succeeded")
                    self.signedInState.send(.signedIn)
                default:
                    logger.log("AccountManager: signIn ")
                }
            }
            .store(in: &bag)
    }
    
    private func signUp(email: String, password: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        let _ = Amplify.Auth.signUp(username: email, password: password, options: options)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    logger.log("AccountManager: signUp: An error occurred while registering a user \(authError)")
                    self.signedInState.send(.error)
                }
            }
            receiveValue: { signUpResult in
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    logger.log("Delivery details \(String(describing: deliveryDetails))")
                    self.signedInState.send(.pendingEmailConfirm)
                } else {
                    logger.log("AccountManager: signUp: SignUp Complete")
                    Amplify.Auth.update(userAttribute: AuthUserAttribute(AuthUserAttributeKey.custom("displayName"), value: email)) { error in
                        logger.log("AccountManager: signUp updateUserAttribute return error")
                    }
                    self.signedInState.send(.signedIn)
                }
            }
            .store(in: &bag)
    }
    
    func confirmSignUp(username: String, confirmationCode: String) -> PassthroughSubject<OtpConfirmState, Never> {
        let otpState = PassthroughSubject <OtpConfirmState, Never>()
        let _ = Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    logger.log("AccountManager: confirm: confirm failed \(authError)")
                    otpState.send(.failure)
                }
            }
            receiveValue: { _ in
                logger.log("AccountManager: confirm: confirm sucess")
                otpState.send(.success)
            }
            .store(in: &bag)
        return otpState
    }
    
    private func fetchAttributes()  {
        logger.log("AccountManager: fetchAttributes")
        let _  = Amplify.Auth.fetchUserAttributes()
                .resultPublisher
                .sink {
                    if case let .failure(fetchError) = $0 {
                        logger.log("AccountManager: fetchAttributes: failed with error \(fetchError)")
                    }
                    else {
                        logger.log("AccountManager: fetchAttributes: success")
                    }
                }
                receiveValue: { attributes in
                    logger.log("AccountManager: fetchAttributes attributes - \(attributes)")
                    self.attributes = attributes
                }
                .store(in: &bag)
    }
    
    var displayName: String {
        if signedInState.value != .signedIn {
            return "Unassigned"
        }
        
        let key = AuthUserAttributeKey.custom("displayName")
        let results = self.attributes.filter { attr in
            attr.key == key
        }
        return (results.count > 0) ? results[0].value : Amplify.Auth.getCurrentUser()?.username ?? "Unassigned"
    }
}
