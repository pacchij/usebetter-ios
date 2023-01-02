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
import AWSCognitoAuthPlugin
import GoogleSignInSwift

struct LoginOptionsView: View {
    @State private var bag = Set<AnyCancellable>()
    @State private var phoneNumber = "7142615481"
    @State private var email = ""
    @State private var otp = ""
    @State private var userSignedIn = false
    @State private var shouldShowOTPValidation: Int? = nil
    @State private var shouldShowErrorMsg: Bool = false
    private var errorMessage: String = "Password should be at least 6 digits"
    @State private var password: String = ""
    private var signUpText: String = "Login"
    @FocusState private var phoneFieldIsFocused: Bool
    private let signUpWithAppleVIewModel = SignUpWithAppleVIewModel()
    private let accountManager = AccountManager.sharedInstance
    @State private var window_: UIWindow? = nil
    private var connectedScene = UIApplication.shared.connectedScenes.first
    private let googleSignInButtonViewModel = GoogleSignInButtonViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    struct Constants {
        static let loginOptionWidth = CGFloat(280)
        static let signInAppleHeight = CGFloat(40)
        static let emailHeight = CGFloat(40)
    }
    var body: some View {
        VStack {
            
            UBNavigationStackView {
                NavigationLink(destination: ValidateSignUpView(email: $email.wrappedValue).environmentObject(viewRouter), tag: 1,  selection: $shouldShowOTPValidation) {
                    EmptyView()
                }
            }
            SignUpWithAppleView()
                .frame(width: Constants.loginOptionWidth, height: Constants.signInAppleHeight, alignment: .center)
                .onTapGesture(perform: appleSignInWithWebUI)
                .padding()
            
            GoogleSignInButton(viewModel: googleSignInButtonViewModel, action: googleSignInWithWebUI)
                .frame(width: Constants.loginOptionWidth, height: Constants.signInAppleHeight, alignment: .center)
                .cornerRadius(10)
                .padding()
            
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
                    validatePassword()
                    if !shouldShowErrorMsg {
                        onSingnUp()
                    }
                }
                .frame(width: Constants.loginOptionWidth, alignment: .topLeading)
            
            Button(signUpText, action: {
                validatePassword()
                if !shouldShowErrorMsg {
                    onSingnUp()
                }
            })
            
            Text(errorMessage)
                .opacity(shouldShowErrorMsg ? 1 : 0)
                .foregroundColor(Color.red)
        }
        .onAppear {
            window_ = window
            logger.log("access window \(window)")
            googleSignInButtonViewModel.scheme = .dark
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
        let _ = accountManager.signUp(email: $email.wrappedValue, password: $password.wrappedValue)
        accountManager.signedInState.sink (
            receiveValue: { signInState in
                logger.log("[LoginOptionView] onSignedUp: signInState changed: reeived value \(signInState.hashValue)")
                switch signInState {
                case .notSignedIn:
                    self.userSignedIn = false
                    self.shouldShowOTPValidation = nil
                case .signedIn:
                    self.userSignedIn = true
                    shouldShowOTPValidation = nil
                    moveToDashbordView()
                case .alreadySignedIn:
                    self.userSignedIn = true
                    viewRouter.currentPage = .dashboard
                case .signedUp:
                    self.userSignedIn = false
                case .error:
                    self.userSignedIn = false
                case .pendingEmailConfirm, .pendingEmailConfirmReSent:
                    logger.log("[LoginOptionView] onSignUp: pendingEmailConfirm")
                    self.shouldShowOTPValidation = 1
                }
            })
        .store(in: &bag)
    }
    
    func appleSignInWithWebUI() {
        Task {
            do {
                let signInResult = try await Amplify.Auth.signInWithWebUI(for: .apple, presentationAnchor: self.window_!)
                if signInResult.isSignedIn {
                    print("[LoginOptionsView] appleSignInWithWebUI: Sign in succeeded")
                    AccountManager.sharedInstance.signedInState.send(.signedIn)
                }
            } catch let error as AuthError {
                print("Sign in failed \(error)")
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
    
    func googleSignInWithWebUI() {
        Task {
            do {
                let signInResult = try await Amplify.Auth.signInWithWebUI(for: .google, presentationAnchor: self.window_!)
                if signInResult.isSignedIn {
                    print("[LoginOptionsView] googleSignInWithWebUI Sign in succeeded")
                    AccountManager.sharedInstance.signedInState.send(.signedIn)
                }
            } catch let error as AuthError {
                print("Sign in failed \(error)")
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
    
    var window: UIWindow? {
        if window_ == nil {
            
            guard let scene = connectedScene,
                  let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                  let localWindow = windowSceneDelegate.window else {
                return window_
            }
            return localWindow
            
        }
        return window_
    }
    
    private func validatePassword() {
        if self.$password.wrappedValue.count < 6 {
            shouldShowErrorMsg = true
        }
        else {
            shouldShowErrorMsg = false
        }
    }
    
    private func moveToDashbordView() {
        DispatchQueue.main.async {
            viewRouter.currentPage = .dashboard
        }
    }
}

struct LoginOptionsView_Preview: PreviewProvider {
    static var previews: some View {
        LoginOptionsView()
    }
}
