//
//  usebetterApp.swift
//  Shared
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

@main
struct usebetterApp: App {
    @StateObject var viewRouter = ViewRouter()
    @StateObject var userFeedData = UserFeedModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
                .environmentObject(userFeedData)
        }
    }
}
