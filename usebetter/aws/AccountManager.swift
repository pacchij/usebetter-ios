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
    
    var currentUsername: String? {
        Amplify.Auth.getCurrentUser()?.username 
    }
    
    private init() {
        signedInState = Amplify.Auth.getCurrentUser() == nil ? .init(.notSignedIn) : .init(.signedIn)
    }
    
    func signIn(email: String, password: String) {
        //Try signIn First, if user does not exist, signUp
        guard Amplify.Auth.getCurrentUser() == nil else {
            print("AccountManager: signIn: already signed In \(Amplify.Auth.getCurrentUser()?.username ?? "")")
            self.signedInState.send(.alreadySignedIn)
            return
        }
        let _ = Amplify.Auth.signIn(username: email, password: password)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                        print("AccountManager: signIn: SignIn Failed \(authError)")
                    self.signUp(email: email, password: password)
                }
                else {
                    self.signedInState.send(.signedIn)
                }
            }
            receiveValue: { result in
                switch result.nextStep {
                case .confirmSignUp(let info):
                    print("AccountManager: signIn confirmSignup \(info?.description ?? "")")
                case .done:
                    print("AccountManager: signIn: Sign IN succeeded")
                    self.signedInState.send(.signedIn)
                default:
                    print("AccountManager: signIn \(result.nextStep)")
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
                    print("AccountManager: signUp: An error occurred while registering a user \(authError)")
                    self.signedInState.send(.error)
                }
            }
            receiveValue: { signUpResult in
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    self.signedInState.send(.pendingEmailConfirm)
                } else {
                    print("AccountManager: signUp: SignUp Complete")
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
                    print("AccountManager: confirm: confirm failed \(authError)")
                    otpState.send(.failure)
                }
            }
            receiveValue: { _ in
                print("AccountManager: confirm: confirm sucess")
                otpState.send(.success)
            }
            .store(in: &bag)
        return otpState
    }
}
