//
//  SignUPView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI
import Combine
import Contacts

struct SignUpView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                UBNavigationStackView{
                    Text("Use Better")
                        .font(.title)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.green)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                    
                    Image("AppIcon")
                    
                    LoginOptionsView().environmentObject(viewRouter)
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(ViewRouter())
    }
}

