//
//  SignUPView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

struct SignUpView: View {
    @State private var shouldHideErrorMsg: Bool = true
    @FocusState private var phoneFieldIsFocused: Bool
    @ObservedObject var phoneNumber = NumbersOnly()
    @EnvironmentObject var viewRouter: ViewRouter

    @State var activeTab: DasbhoardTabs?

    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("Use Better")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.green)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
            
                HStack(spacing: 10) {
                    Text("Phone Number")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(10)
                    Text("+1")
                        .font(.body)
                        .foregroundColor(.green)
                        .padding(2)
                    TextField("Phone Number", text: $phoneNumber.value)
                        .font(.subheadline)
                        .focused($phoneFieldIsFocused)
                        .onSubmit {
                            validatePhoneNumber()
                        }
                        .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .padding(10)
                        .keyboardType(.decimalPad)
                }
                Text("Enter Valid Phone Number...")
                    .font(.subheadline)
                    .foregroundColor(Color.red)
                    .padding(10)
                    .opacity(shouldHideErrorMsg ? 0 : 1)
                
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
    
    func onSingnUp() {
        viewRouter.currentPage = .dashboard
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
