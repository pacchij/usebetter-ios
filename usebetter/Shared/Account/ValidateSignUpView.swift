//
//  ValidateSignUpView.swift
//  usebetter (iOS)
//
//  Created by Prashanth Jaligama on 12/31/22.
//

import SwiftUI
import Combine

struct ValidateSignUpView: View {
    @State private var otp = ""
    @State private var shouldShowErrorMsg: Bool = false
    @State var email: String
    @State private var bag = Set<AnyCancellable>()
    private let errorMessage: String = "OTP validation failed. Try again."
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack() {
            VStack(spacing: 10) {
                Text("Verify One time password sent to your email")
                    .font(.body)
                    .foregroundColor(.green)
                    .padding()
                TextField("OTP", text: $otp)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        validateOtp()
                    }
                    .padding()
                    .frame(width: 200)
                Button("Validate") {
                    validateOtp()
                }
                
                Text(errorMessage)
                    .font(.subheadline)
                    .foregroundColor(Color.red)
                    .padding(10)
                    .opacity(shouldShowErrorMsg ? 1 : 0)
                HStack {
                    Text("Did not receive Code?")
                    Button("Resend", action: {
                        onResend()
                    })
                }
                Spacer()
            }
            .padding()
        }
    }
    
    private func validateOtp() {
        let _ = AccountManager.sharedInstance.confirmSignUp(username: $email.wrappedValue, confirmationCode: $otp.wrappedValue)
            .sink ( receiveValue: { result in
                switch result {
                case .success:
                    self.shouldShowErrorMsg = false
                    AccountManager.sharedInstance.signedInState.send(.signedIn)
                case .failure:
                    shouldShowErrorMsg = true
                }
            })
            .store(in: &bag)
    }
    
    private func onResend() {
        AccountManager.sharedInstance.resendSignUpCode(for: $email.wrappedValue)
    }
    
    private func moveToDashbordView() {
        DispatchQueue.main.async {
            viewRouter.currentPage = .dashboard
        }
    }
}

struct ValidateSignUpView_Preview: PreviewProvider {
    static var previews: some View {
        ValidateSignUpView(email: "pj@test.com").environmentObject(ViewRouter())
    }
}
