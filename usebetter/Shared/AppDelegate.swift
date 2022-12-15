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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        logger.log("UseBetter Logging initialized")
        do {
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin()	)
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.configure()
            logger.log("Amplify configured with auth plugin")
        } catch {
            logger.log("Failed to initialize Amplify with \(error)")
        }

        return true
    }
}
