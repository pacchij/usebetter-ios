//
//  ContentView.swift
//  Shared
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

class NavigationController: ObservableObject {
    @Published var activeTab: DasbhoardTabs? = DasbhoardTabs.none
    
    func open(_ tab: DasbhoardTabs) {
        activeTab = tab
    }
}


struct ContentView: View {
    enum ScreenItems: String {
        case signUp
        case signedIn
    }
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userFeedData: UserFeedModel
    @State var selectedScreenItem: ScreenItems? = .signUp
    @State var signedInFlag: Bool = false
    @State var signUpFlag: Bool = true
    @State var navigationController: NavigationController = NavigationController()
    @State var activeTab: DasbhoardTabs? = DasbhoardTabs.none
    var body: some View {
        switch viewRouter.currentPage {
        case .signUp:
            SignUpView().environmentObject(viewRouter)
        case .dashboard:
            DashboardView()
                .environmentObject(viewRouter)
                .environmentObject(userFeedData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewRouter())
    }
}
