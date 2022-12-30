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

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        logger.log("UseBetter Logging initialized")
        do {
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.configure()
            logger.log("Amplify configured with auth plugin")
        } catch {
            logger.log("Failed to initialize Amplify with \(error)")
        }
        
//        // Initialize AWSMobileClient singleton
//        AWSMobileClient.default().initialize { (userState, error) in
//            if let userState = userState {
//                print("UserState: \(userState.rawValue)")
//            } else if let error = error {
//                print("error: \(error.localizedDescription)")
//            }
//        }
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization() { succeess, error in
            guard succeess else {
                logger.log("[AppDelegate] request authorization failed")
                return
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
            logger.log("[AppDelegate] messaging token is \(token)")
        }
    }
}
