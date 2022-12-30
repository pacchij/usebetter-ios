//
//  SignUpWithAppleView.swift
//  usebetter (iOS)
//
//  Created by Prashanth Jaligama on 12/26/22.
//

//import Foundation
//import UIKit
import SwiftUI
import AuthenticationServices

struct SignUpWithAppleView: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    @Environment(\.colorScheme) var colorScheme
    
    func makeUIView(context: Context) -> UIViewType  {
       let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn,
                                                 authorizationButtonStyle: colorScheme == .dark ? .white: .black)
       button.cornerRadius = 10
       return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}
