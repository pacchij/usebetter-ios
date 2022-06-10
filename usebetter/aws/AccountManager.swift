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
    case signInSuccess
    case error
    case alreadySignedIn
    case signedUp
    case pendingEmailConfirm
}

enum OtpConfirmState {
    case success
    case failure
}

class AccountManager {
    var bag = Set<AnyCancellable>()
    
    var currentUsername: String? {
        Amplify.Auth.getCurrentUser()?.username 
    }
    
    func signIn(email: String, password: String) -> PassthroughSubject <SingInState, Never> {
        let signInSubject = PassthroughSubject <SingInState, Never>()
        //Try signIn First, if user does not exist, signUp
        guard Amplify.Auth.getCurrentUser() == nil else {
            print("AccountManager: signIn: already signed In \(Amplify.Auth.getCurrentUser()?.username ?? "")")
            signInSubject.send(.alreadySignedIn)
            return signInSubject
        }
        let _ = Amplify.Auth.signIn(username: email, password: password)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                        print("AccountManager: signIn: SignIn Failed \(authError)")
                    signInSubject.send(.signedUp)
                    self.signUp(email: email, password: password, listener: signInSubject)
                }
                else {
                    signInSubject.send(.signInSuccess)
                }
            }
            receiveValue: { result in
                switch result.nextStep {
                case .confirmSignUp(let info):
                    print("AccountManager: signIn confirmSignup \(info?.description ?? "")")
                case .done:
                    print("AccountManager: signIn: Sign IN succeeded")
                    signInSubject.send(.signInSuccess)
                default:
                    print("AccountManager: signIn \(result.nextStep)")
                }
            }
            .store(in: &bag)
        return signInSubject
    }
    
    func signUp(email: String, password: String, listener: PassthroughSubject <SingInState, Never>) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        let _ = Amplify.Auth.signUp(username: email, password: password, options: options)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("AccountManager: signUp: An error occurred while registering a user \(authError)")
                    listener.send(.error)
                }
            }
            receiveValue: { signUpResult in
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    listener.send(.pendingEmailConfirm)
                } else {
                    print("AccountManager: signUp: SignUp Complete")
                    listener.send(.signInSuccess)
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
