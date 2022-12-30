//
//  SignUpWithAppleVIewModel.swift
//  usebetter (iOS)
//
//  Created by Prashanth Jaligama on 12/27/22.
//

import AuthenticationServices
import Amplify
//import AmplifyPl

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
    
    func signin(userid: String) {
        guard let plugin = try? Amplify.Auth.getPlugin(for: AWSCognitoAuthPlugin().key),
              let authPlugin = plugin as? AWSCognitoAuthPlugin,
              
              
    }
}
