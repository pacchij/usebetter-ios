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
    
    
    @State var activeTab: DasbhoardTabs?
    
    @FocusState private var phoneFieldIsFocused: Bool
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userFeedData: UserFeedModel
    @EnvironmentObject var friendsFeedData: FriendsFeedModel
    
    private let accountManager = AccountManager()
    @State private var bag = Set<AnyCancellable>()
    @State private var phoneNumber = "7142615481"
    @State private var email = "pacchij@yahoo.com"
    @State private var otp = ""
    @State private var userSignedIn = false
    @State private var shouldShowErrorMsg: Bool = false
    @State private var errorMessage: String = "Error Message..."
    @State private var shouldHideOTP: Bool = true
    @State private var password: String = "Test@123"
    @State private var signUpText: String = "Sign up / Login"
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
                    
//                HStack(spacing: 10) {
//                    Spacer()
//                        .frame(width: 10)
//                    Text("Phone Number")
//                        .font(.body)
//                        .foregroundColor(.green)
//                        .padding(10)
//                    Text("+1 USA")
//                        .font(.body)
//                        .foregroundColor(.green)
//                        .padding(2)
//                    TextField("Phone Number", text: $phoneNumber)
//                        .textFieldStyle(.roundedBorder)
//                        .focused($phoneFieldIsFocused)
//                        .onSubmit {
//                            validatePhoneNumber()
//                        }
//                        .keyboardType(.decimalPad)
//                    Spacer()
//                        .frame(width: 10)
//                }
                
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
                            validateEmail()
                        }
                    Spacer()
                        .frame(width: 10)
                }
                
                HStack(spacing: 10) {
                    Spacer()
                        .frame(width: 10)
                    Text("Password")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(10)
                
                    SecureField("Enter Password", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .focused($phoneFieldIsFocused)
                        .onSubmit {
                            validateEmail()
                        }
                    Spacer()
                        .frame(width: 10)
                }
                
                    
                HStack(spacing: 10) {
                    Spacer()
                        .frame(width: 10)
                    Text("OTP from your email")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(10)
                    TextField("OTP", text: $otp)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            validateOtp()
                        }
                    Spacer()
                        .frame(width: 10)
                }
                .opacity(shouldHideOTP ? 0 : 1)
                    
                Text($errorMessage.wrappedValue)
                .font(.subheadline)
                .foregroundColor(Color.red)
                .padding(10)
                .opacity(shouldShowErrorMsg ? 1 : 0)
          
                    Button(signUpText, action: {
                        if shouldHideOTP {
                            onSingnUp()
                        }
                        else {
                            validateOtp()
                        }
                    })
                }
            }
        }
    }
    
    func validateEmail() {
        
    }

    func validatePhoneNumber() {
        if self.$phoneNumber.wrappedValue.count == 10 {
            errorMessage = "Enter Valid Phone Number..."
            shouldShowErrorMsg = true
            print("unHide")
        }
        else {
            shouldShowErrorMsg = false
            print("unHide")
        }
    }
    
    func validatePassword() {
        print(self.password)
        print("submit called")

        if self.$password.wrappedValue.count == 6 {
            errorMessage = "Enter Valid Password 6 digits..."
            shouldShowErrorMsg = true
            print("unHide")
        }
        else {
            shouldShowErrorMsg = false
            print("unHide")
        }
    }
    
    private func validateOtp() {
        let _ = accountManager.confirmSignUp(username: $email.wrappedValue, confirmationCode: $otp.wrappedValue)
            .sink ( receiveValue: { result in
                switch result {
                case .success:
                    self.shouldHideOTP = true
                    self.shouldShowErrorMsg = false
                    self.signUpText = "Sign up / Login"
                    self.onSingnUp()
                case .failure:
                    shouldHideOTP = false
                    errorMessage = "Enter Valid OTP sent to your email"
                    signUpText = "Validate"
                    shouldShowErrorMsg = true
                }
            })
            .store(in: &bag)
    }
    
    func onSingnUp() {
        let _ = accountManager.signIn(email: $email.wrappedValue, password: $password.wrappedValue)
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
            case .pendingEmailConfirm:
                self.shouldHideOTP = false
                self.shouldShowErrorMsg = true
                self.errorMessage = "Enter Valid OTP sent to your email"
                self.signUpText = "Validate"
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
