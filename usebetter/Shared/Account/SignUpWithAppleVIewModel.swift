//
//  SignUpWithAppleVIewModel.swift
//  usebetter (iOS)
//
//  Created by Prashanth Jaligama on 12/27/22.
//

import AuthenticationServices
import Amplify
import AWSCognitoAuthPlugin

enum UBAuthProvider: String {
    case signInWithApple
}

class SignUpWithAppleVIewModel: NSObject, ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            logger.log("[SignUpWithAppleVIewModel] authorizationController: ** ASAuthorizationAppleIDCredential - \(#function)** \n")
            logger.log("[SignUpWithAppleVIewModel] authorizationController: \(appleIdCredential.email ?? "Email not available.")")
            logger.log("[SignUpWithAppleVIewModel] authorizationController: \(appleIdCredential.fullName?.givenName ?? "givenName not available")")
            logger.log("[SignUpWithAppleVIewModel] authorizationController: \(appleIdCredential.fullName?.familyName ?? "Familyname not available")")
            logger.log("[SignUpWithAppleVIewModel] authorizationController: \(appleIdCredential.user)")
            logger.log("[SignUpWithAppleVIewModel] authorizationController: \(appleIdCredential.identityToken?.base64EncodedString() ?? "Identity token not available")")
            logger.log("[SignUpWithAppleVIewModel] authorizationController: \(appleIdCredential.authorizationCode?.base64EncodedString() ?? "Authorization code not available")")
            federatedSignIn(identityToken: String(data: appleIdCredential.identityToken!, encoding: .utf8) ?? "", for: UBAuthProvider.signInWithApple.rawValue)
            break
            
        case let passwordCredential as ASPasswordCredential:
            logger.log("[SignUpWithAppleVIewModel] authorizationController: ** ASPasswordCredential ")
            logger.log("[SignUpWithAppleVIewModel] authorizationController: \(passwordCredential.user)")
            logger.log("[SignUpWithAppleVIewModel] authorizationController: \(passwordCredential.password)")
            break
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        logger.log("[SignUpWithAppleVIewModel] authorizationController: didCompleteWithError: \(error)")
    }
    
    func federatedSignIn(identityToken: String, for providerName: String) {
        Task {
           // let stateMachine = AuthStateMachine()
            //stateMachine.
            do {
                //Amplify.Auth
                let awsCognitoPublin = try Amplify.Auth.getPlugin(for: "awsCognitoAuthPlugin") as? AWSCognitoAuthPlugin
                let result = try await awsCognitoPublin?.federateToIdentityPool(withProviderToken: identityToken, for: .apple)
                logger.log("[SignUpWithAppleVIewModel] federatedSignIn:result \(String(describing: result)) ")
            }
            catch {
                logger.log("[SignUpWithAppleVIewModel] federatedSignIn: Exception \(String(describing: error)) ")
            }
        }
//        guard let plugin = try? Amplify.Auth.getPlugin(for: AWSCognitoAuthPlugin().key),
//              let authPlugin = plugin as? AWSCognitoAuthPlugin,
//              case .userPool(let client) = authPlugin.getEscapeHatch() else {
//            return
//        }
//
//        client.federatedSignIn(providerName: providerName , token: identityToken) { state, error in
//            if let error = error {
//                logger.error("[SignUpWithAppleVIewModel] [signInFederated] error: \(error)")
//            }
//            else {
//                logger.log("[SignUpWithAppleVIewModel] [signInFederated] success. State is \(state?.rawValue ?? "state is empty")")
//            }
//        }
    }
    
    var window: UIWindow? {
       // if window_ == nil {

                guard let scene = UIApplication.shared.connectedScenes.first,
                      let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                      let localWindow = windowSceneDelegate.window else {
                    return nil
                }
            return localWindow
        }
      //  return window_
}
