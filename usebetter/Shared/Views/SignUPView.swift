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
    @State private var shouldHideErrorMsg: Bool = true
    @State private var shouldHidePwdErrorMsg: Bool = true
    @State private var password: String = ""
    
    @State var activeTab: DasbhoardTabs?
    
    @FocusState private var phoneFieldIsFocused: Bool
    @ObservedObject var phoneNumber = NumbersOnly()
    @EnvironmentObject var viewRouter: ViewRouter
    
    private let accountManager = AccountManager()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("Use Better")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.green)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                
                Image("AppIcon")
                    
                    
                    
            
                HStack(spacing: 10) {
                    Spacer()
                        .frame(width: 10)
                    Text("Phone Number")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(10)
                    Text("+1 USA")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(2)
                    TextField("Phone Number", text: $phoneNumber.value)
                        .textFieldStyle(.roundedBorder)
                        .focused($phoneFieldIsFocused)
                        .onSubmit {
                            validatePhoneNumber()
                        }
                        .keyboardType(.decimalPad)
                    Spacer()
                        .frame(width: 10)
                }
                
                SecureField("Enter a Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .focused($phoneFieldIsFocused)
                    .onSubmit {
                        validatePassword()
                    }
                Text("Enter Valid Phone Number...")
                    .font(.subheadline)
                    .foregroundColor(Color.red)
                    .padding(10)
                    .opacity(shouldHideErrorMsg ? 0 : 1)
                Text("Enter Valid Password 6 digits...")
                    .font(.subheadline)
                    .foregroundColor(Color.red)
                    .padding(10)
                    .opacity(shouldHidePwdErrorMsg ? 0 : 1)
                
                
                Button("Sign Up", action: onSingnUp)
            }
        }
    }
    func validatePhoneNumber() {
        print(self.$phoneNumber.value)
        print("submit called")

        if self.$phoneNumber.value.wrappedValue.count == 10 {
            shouldHideErrorMsg = true
            print("unHide")
        }
        else {
            shouldHideErrorMsg = false
            print("unHide")
        }
    }
    func validatePassword() {
        print(self.password)
        print("submit called")

        if self.$password.wrappedValue.count == 6 {
            shouldHidePwdErrorMsg = true
            print("unHide")
        }
        else {
            shouldHidePwdErrorMsg = false
            print("unHide")
        }
    }
    
    
    func onSingnUp() {
        accountManager.signUp(phoneNumber: "+1" + $phoneNumber.value.wrappedValue, password: $password.wrappedValue)
    }
}

class NumbersOnly: ObservableObject {
    @Published var value: String = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(ViewRouter())
    }
}
