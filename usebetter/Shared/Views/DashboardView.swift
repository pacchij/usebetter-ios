//
//  DashboardView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

enum DasbhoardTabs: Hashable {
    case home
    case groups
    case myStuff
    case settings
    case none
}

struct DashboardView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userFeedData: UserFeedModel
    @EnvironmentObject var friendsFeedData: FriendsFeedModel
    @EnvironmentObject var transactions: TransactionsModel
    var body: some View {
        TabView {
            DashboardHomeView(searchText: "")
                .environmentObject(friendsFeedData)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            DashboardMyStuffView(searchText: "")
                .environmentObject(userFeedData)
                .tabItem {
                    Label("MyStuff", systemImage: "bag")
                }
            DashboardEventsView()
                .environmentObject(transactions)
                .tabItem {
                    Label("Events", systemImage: "person.3.sequence.fill")
                }
            DashboardSettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(ViewRouter())
            .environmentObject(UserFeedModel())
    }
}

