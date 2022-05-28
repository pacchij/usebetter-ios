//
//  DashboardSettingsView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/28/22.
//

import SwiftUI
import Amplify

struct DashboardSettingsView: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                if Amplify.Auth.getCurrentUser() == nil {
                    Text("Welcome to Settings view")
                }
                else {
                    VStack {
                        Text("User name")
                        Text(Amplify.Auth.getCurrentUser()?.username ?? "")
                    }
                }
            }
        }
    }
}

struct DashboardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSettingsView()
    }
}
