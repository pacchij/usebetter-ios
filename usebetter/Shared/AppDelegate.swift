//
//  AppDelegate.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/21/22.
//

import Foundation
import Amplify
import AWSCognitoAuthPlugin
import SwiftUI
import AWSAPIPlugin
import AWSS3StoragePlugin

import Firebase
import FirebaseMessaging
import UserNotifications
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        logger.log("[AppDelegate] UseBetter Logging initialized")
        do {
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.configure()
            logger.log("[AppDelegate] Amplify configured with auth plugin")
        } catch {
            logger.log("[AppDelegate] Failed to initialize Amplify with \(error)")
        }
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                logger.log("[AppDelegate] user is Nil error \(error)")
            } else {
              // Show the app's signed-in state.
                logger.log("[AppDelegate] user is Signed in")
            }
          }
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            logger.log("[AppDelegate] messaging:didReceiveRegistrationToken token is \(token)")
            let fcmRegTokenKey = "fcmRegTokenKey"
            let userDefaults = UserDefaults.standard
            let storedToken = userDefaults.string(forKey: fcmRegTokenKey)
            if storedToken == nil, fcmToken != storedToken {
                userDefaults.set(token, forKey: fcmRegTokenKey)
                logger.log("[AppDelegate] messaging:didReceiveRegistrationToken token changed or nil before. storing in user defaults")
            }
            else {
                logger.log("[AppDelegate] messaging:didReceiveRegistrationToken Stored fcmToken is: \(storedToken ?? "")")
            }
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let stringToken = String(decoding: deviceToken, as: UTF8.self)
        logger.log("[AppDelegate] messaging:didRegisterForRemoteNotificationsWithDeviceToken APNS device Token is: \(stringToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
}
