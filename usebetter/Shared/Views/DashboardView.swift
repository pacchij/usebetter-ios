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
    var body: some View {
        TabView {
            DashboardHomeView(searchText: "")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            DashboardMyStuffView(searchText: "")
                .tabItem {
                    Label("MyStuff", systemImage: "bag")
                }
            DashboardGroupsView()
                .tabItem {
                    Label("Groups", systemImage: "person.3.sequence.fill")
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
        DashboardView().environmentObject(ViewRouter())
    }
}

struct DashboardGroupsView: View {
    var body: some View {
        Text("Welcome to Groups view")
    }
}

//struct DashboardMyStuffView: View {
//    var body: some View {
//        Text("Welcome to My Stuff view")
//    }
//}

struct DashboardSettingsView: View {
    var body: some View {
        Text("Welcome to Settings view")
    }
}
