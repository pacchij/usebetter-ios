//
//  LoginOptionsView.swift
//  usebetter (iOS)
//
//  Created by Prashanth Jaligama on 12/27/22.
//

import SwiftUI
import Combine
import AuthenticationServices
import Amplify

struct LoginOptionsView: View {
    @State private var bag = Set<AnyCancellable>()
    @State private var phoneNumber = "7142615481"
    @State private var email = ""
    @State private var otp = ""
    @State private var userSignedIn = false
    @State private var shouldShowErrorMsg: Bool = false
    @State private var errorMessage: String = "Error Message..."
    @State private var shouldHideOTP: Bool = true
    @State private var password: String = ""
    @State private var signUpText: String = "Login"
    @FocusState private var phoneFieldIsFocused: Bool
    private let signUpWithAppleVIewModel = SignUpWithAppleVIewModel()
    private let accountManager = AccountManager.sharedInstance
    
    struct Constants {
        static let loginOptionWidth = CGFloat(280)
        static let signInAppleHeight = CGFloat(40)
        static let emailHeight = CGFloat(40)
    }
    var body: some View {
        VStack {
            SignUpWithAppleView()
                .frame(width: Constants.loginOptionWidth, height: Constants.signInAppleHeight, alignment: .center)
                .onTapGesture(perform: showAppleLoginView)
            
            
            Text("or")
            TextField("Enter Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    validateEmail()
                }
            
                .frame(width: Constants.loginOptionWidth, alignment: .topLeading)
            SecureField("Enter Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .focused($phoneFieldIsFocused)
                .onSubmit {
                    validateEmail()
                }
                .frame(width: Constants.loginOptionWidth, alignment: .topLeading)
            
            Button(signUpText, action: {
                onSingnUp()
            })
            Button("apple sign in test", action: {
                socialSignInWithWebUI()
            })
        }
    }
    
    func validateEmail() {
        
    }
    
    func showAppleLoginView() {
        logger.log("[LoginOptionsView] showAppleLoginView: Entered")
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = signUpWithAppleVIewModel
        controller.performRequests()
    }
    
    func onSingnUp() {
        let _ = accountManager.signIn(email: $email.wrappedValue, password: $password.wrappedValue)
        accountManager.signedInState.sink (
            receiveValue: { signInState in
                logger.log("signedup view: reeived value \(signInState.hashValue)")
                switch signInState {
                case .notSignedIn:
                    self.userSignedIn = false
                    self.shouldHideOTP = true
                    self.shouldShowErrorMsg = false
                case .signedIn:
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
    
    func socialSignInWithWebUI() {
        //do {
        //_ = Amplify.Auth.signInWithWebUI(for: .apple, presentationAnchor: self.window!, options: options)
            //signInResult.
            //if signInResult.isSignedIn {
            //    print("Sign in succeeded")
            //}
//        } catch let error as AuthError {
//            print("Sign in failed \(error)")
//        } catch {
//            print("Unexpected error: \(error)")
//        }
    }
    
    var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        return window
    }
}

struct LoginOptionsView_Preview: PreviewProvider {
    static var previews: some View {
        LoginOptionsView()
    }
}
