//
//  DashboardSettingsView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/28/22.
//

import SwiftUI
import Amplify

struct DashboardSettingsView: View {
    @State private var changedDisplayName = "DisplayName"
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("User Profile")
                            .font(.title)
                        Spacer()
                            .frame(height: 100)
                        if Amplify.Auth.getCurrentUser() != nil {
                            HStack {
                                Text("Email: ")
                                Text(userid)
                            }
                            HStack() {
                                Text("Display Name: ")
                                TextField(displayName, text: $changedDisplayName)
                                    .textFieldStyle(.roundedBorder)
                                    .onSubmit {
                                        updateDisplayName()
                                    }
                            }
                        }
                    }// VStack
                    .padding(10)
                }
            } // ZStack
        }  // Navigation view
        .onAppear {
            changedDisplayName = displayName
        }
    } // body
    
    private func updateDisplayName() {
        print("DashboardSettingsView: updateDisplayName")
        Amplify.Auth.update(userAttribute: AuthUserAttribute(AuthUserAttributeKey.custom("displayName"), value: $changedDisplayName.wrappedValue)) { error in
            print("DashboardSettingsView: updateDisplayName error \(error)")
        }
    }
    private var userid: String {
        AccountManager.sharedInstance.currentUsername ?? "unknown"
    }
    private var displayName: String {
        AccountManager.sharedInstance.displayName
    }
}

struct DashboardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSettingsView()
    }
}
