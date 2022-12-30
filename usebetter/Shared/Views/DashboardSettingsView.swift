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
                        if AccountManager.sharedInstance.currentUsername != nil {
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
        logger.log("DashboardSettingsView: updateDisplayName")
        Task {
            do {
                let result = try await Amplify.Auth.update(userAttribute: AuthUserAttribute(AuthUserAttributeKey.custom("displayName"), value: $changedDisplayName.wrappedValue))
                logger.log("DashboardSettingsView: updateDisplayName updated \(result.isUpdated) ")
            }
            catch {
                logger.log("DashboardSettingsView: updateDisplayName error ")
            }
        }
    }
    private var userid: String {
        AccountManager.sharedInstance.currentUsername ?? "unknown"
    }
    private var displayName: String {
        AccountManager.sharedInstance.displayName
    }
}

//struct DashboardSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardSettingsView()
//    }
//}
