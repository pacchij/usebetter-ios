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
                //Get the current user
                _ = AccountManager.sharedInstance.currentUsername
                DispatchQueue.global().asyncAfter(deadline: .now() + 1.0 ) {
                    if !isAppAlreadyLaunchedOnce() {
                        Task {
                            _ = await Amplify.Auth.signOut()
                            self.isReady = true
                        }
                    }
                    else {
                        self.eventsModel.initialize(userfeed: userFeedData, friendsFeed: friendsFeedData)
                        //update only on the main ui thread
                        DispatchQueue.main.async {
                            if AccountManager.sharedInstance.currentUsername == nil {
                                viewRouter.currentPage = .signUp
                            }
                            else {
                                viewRouter.currentPage = .dashboard
                            }
                        }
                        self.isReady = true
                    }
                } //Dispatch
            } //onAppear
        } //else
    } //body
    
    func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            logger.log("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            logger.log("App launched first time")
            return false
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
