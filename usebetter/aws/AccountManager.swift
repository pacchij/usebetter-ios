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
}

class AccountManager {
    var bag = Set<AnyCancellable>()
    
    func signIn(email: String, username: String, password: String) -> PassthroughSubject <SingInState, Never> {
        let signInSubject = PassthroughSubject <SingInState, Never>()
        //Try signIn First, if user does not exist, signUp
        guard Amplify.Auth.getCurrentUser() == nil else {
            print("already signed In \(Amplify.Auth.getCurrentUser()?.username ?? "")")
            signInSubject.send(.alreadySignedIn)
            return signInSubject
        }
        let _ = Amplify.Auth.signIn(username: username, password: password)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                        print("SignIn Failed \(authError)")
                    signInSubject.send(.signedUp)
                    self.signUp(email: email, username: username, password: password, listener: signInSubject)
                }
                else {
                    signInSubject.send(.signInSuccess)
                }
            }
            receiveValue: { _ in
                print("Sign IN succeeded")
                signInSubject.send(.signInSuccess)
            }
            .store(in: &bag)
        return signInSubject
    }
    
    func signUp(email: String, username: String, password: String, listener: PassthroughSubject <SingInState, Never>) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        let _ = Amplify.Auth.signUp(username: username, password: password, options: options)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("An error occurred while registering a user \(authError)")
                    listener.send(.error)
                }
            }
            receiveValue: { signUpResult in
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
                //Amplify.Auth.confirm(userAttribute: <#T##AuthUserAttributeKey#>, confirmationCode: <#T##String#>)
                listener.send(.signInSuccess)
            }
            .store(in: &bag)
    }
}
