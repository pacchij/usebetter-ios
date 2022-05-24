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

class AccountManager {
    var bag = Set<AnyCancellable>()
    
    func signUp(phoneNumber: String, password: String) { 
        let userAttributes = [AuthUserAttribute(.phoneNumber, value: phoneNumber)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        let _ = Amplify.Auth.signUp(username: phoneNumber, password: password, options: options)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("An error occurred while registering a user \(authError)")
                }
            }
            receiveValue: { signUpResult in
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }

            }
            .store(in: &bag)
            
        //return sink
    }
}
