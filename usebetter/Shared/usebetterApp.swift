//
//  usebetterApp.swift
//  Shared
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

@main
struct usebetterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    @StateObject var userFeedData = UserFeedModel()
    @StateObject var friendsFeedData = FriendsFeedModel()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(viewRouter)
                .environmentObject(userFeedData)
                .environmentObject(friendsFeedData)
           
        }
    }
}
