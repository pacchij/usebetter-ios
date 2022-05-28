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
    @State private var password: String = "Test@123"
    
    @State var activeTab: DasbhoardTabs?
    
    @FocusState private var phoneFieldIsFocused: Bool
    @State private var phoneNumber = "7142615481"
    @State private var email = "pacchij@yahoo.com"
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userFeedData: UserFeedModel
    @EnvironmentObject var friendsFeedData: FriendsFeedModel
    
    private let accountManager = AccountManager()
    @State private var bag = Set<AnyCancellable>()
    @State private var userSignedIn = false
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                if userSignedIn {
                    DashboardView()
                        .environmentObject(viewRouter)
                        .environmentObject(userFeedData)
                        .environmentObject(friendsFeedData)
                }
                else {
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
                    TextField("Phone Number", text: $phoneNumber)
                        .textFieldStyle(.roundedBorder)
                        .focused($phoneFieldIsFocused)
                        .onSubmit {
                            validatePhoneNumber()
                        }
                        .keyboardType(.decimalPad)
                    Spacer()
                        .frame(width: 10)
                }
                
                HStack(spacing: 10) {
                    Spacer()
                        .frame(width: 10)
                    Text("Email")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(10)
                    TextField("email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            validatePhoneNumber()
                        }
                    Spacer()
                        .frame(width: 10)
                }
                
                HStack(spacing: 10) {
                    Spacer()
                        .frame(width: 10)
                    Text("Email")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(10)
                
                    SecureField("Enter email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .focused($phoneFieldIsFocused)
                        .onSubmit {
                            validateEmail()
                        }
                    Spacer()
                        .frame(width: 10)
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
                
                
                Button("Sign up / Login", action: onSingnUp)
                }
            }
        }
    }
    
    func validateEmail() {
        
    }

    func validatePhoneNumber() {
        if self.$phoneNumber.wrappedValue.count == 10 {
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
        let _ = accountManager.signIn(email: $email.wrappedValue, username: "+1" + $phoneNumber.wrappedValue, password: $password.wrappedValue)
            .sink (
            receiveValue: { signInState in
                print("signedup view: reeived value \(signInState)")
                switch signInState {
                case .signInSuccess:
                    self.userSignedIn = true
                case .alreadySignedIn:
                    self.userSignedIn = true
                case .signedUp:
                    self.userSignedIn = false
                case .error:
                    self.userSignedIn = false
                }
            })
            .store(in: &bag)
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
