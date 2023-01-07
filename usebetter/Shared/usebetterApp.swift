//
//  usebetterApp.swift
//  Shared
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI
import GoogleSignIn

@main
struct usebetterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    @StateObject var userFeedData = UserFeedModel()
    @StateObject var friendsFeedData = FriendsFeedModel()
    @StateObject var eventsModel = EventsModel()
    @StateObject var notificationCenterDelegate = UBNotificationCenterDelegate()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(viewRouter)
                .environmentObject(userFeedData)
                .environmentObject(friendsFeedData)
                .environmentObject(eventsModel)
                .environmentObject(notificationCenterDelegate)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}


class UBNotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
}
