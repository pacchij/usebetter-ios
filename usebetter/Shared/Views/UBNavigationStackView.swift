//
//  UBNavigationStackView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 1/2/23.
//

import SwiftUI

struct UBNavigationStackView<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
        }
    }
}
