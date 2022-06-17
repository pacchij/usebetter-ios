//
//  SpashView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/28/22.
//

import SwiftUI
import Amplify

struct SplashView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userFeedData: UserFeedModel
    @EnvironmentObject var friendsFeedData: FriendsFeedModel
    @EnvironmentObject var eventsModel: EventsModel
    @State private var isReady = false
    var body: some View {
        if isReady {
            ContentView()
                .environmentObject(viewRouter)
                .environmentObject(userFeedData)
                .environmentObject(friendsFeedData)
                .environmentObject(eventsModel)
        }
        else {
            ZStack {
                Text("Use Better")
                    .foregroundColor(.green)
                    .font(.largeTitle)
            }
            .onAppear {
                DispatchQueue.global().asyncAfter(deadline: .now() + 1.0 ) {
                    if !isAppAlreadyLaunchedOnce() {
                        let _ = Amplify.Auth.signOut() { _ in
                            self.isReady = true
                        }
                    }
                    else {
                        self.isReady = true
                        self.eventsModel.initialize(userfeed: userFeedData, friendsFeed: friendsFeedData)
                    }
                } //Dispatch
            } //onAppear
        } //else
    } //body
        
    func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            print("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
