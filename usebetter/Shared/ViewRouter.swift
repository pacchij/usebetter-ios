//
//  ContentView.swift
//  Shared
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

enum CurrentPage {
    case signUp
    case dashboard
}
class ViewRouter: ObservableObject {
    @Published var currentPage: CurrentPage = .dashboard
}
