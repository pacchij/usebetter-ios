//
//  ContactPickerView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/21/22.
//

import Foundation
import SwiftUI
import ContactsUI
import Contacts
/*
struct ContactPickerView: View {
    @ObservedObject var delegate = Delegate()
    
    var body: some View {
        VStack {
            Text("Hi")

            Button(action: {
                delegate.showPicker = true
            }, label: {
                Text("Pick contact")
            })
            .sheet(isPresented: $delegate.showPicker, onDismiss: {
                delegate.showPicker = false
            }) {
                ContactPicker(delegate: .constant(delegate))
            }

            if let contact = delegate.contact {
                Text("Selected: \(contact.givenName)")
            }
        }
    }
}

struct ContactPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ContactPickerView()
    }
}
*/
