//
//  UpdateItemView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/20/22.
//

import Foundation
import SwiftUI
import Contacts

struct UpdateItemView: View {
    @State var itemIndex: Int = 0
    @State var itemName: String = ""
    @State var itemCount: String = "1"
    @EnvironmentObject var userFeedData: UserFeedModel
    @EnvironmentObject var eventsModel: EventsModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var delegate = Delegate()

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                    .frame(height: 50)
                if let imageURL = userFeedData.userItems[itemIndex].imageURL {
                    AsyncImage(url: URL(string: imageURL)) { image1 in
                        image1.resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120,  alignment: .center)
                    } placeholder: {
                        ProgressView()
                    }
                }
                else {
                    AsyncImage(url: URL(string: "notAvailable")) { image1 in
                        image1.resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120,  alignment: .center)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Spacer()
                    .frame(height: 50)
                TextField(userFeedData.userItems[itemIndex].name, text: $itemName)
                    .onSubmit {
                        userFeedData.userItems[itemIndex].name = itemName
                    }
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("Tags:")
                    Text(userFeedData.userItems[itemIndex].getTags)
                }
                .padding(20)
                
                HStack {
                    Text("Available Counts: ")
                    TextField(String(userFeedData.userItems[itemIndex].itemCount), text: $itemCount)
                        .onSubmit {
                            userFeedData.userItems[itemIndex].itemCount = Int(itemCount) ?? 0
                        }
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 50)
                    Spacer().frame(height:50)
                }

                HStack {
                    if let contactName =  userFeedData.userItems[itemIndex].ownerid {
                        Text("shared To: ")
                        Text(contactName)
                            .frame(width:150)
                            .foregroundColor(.green)
                            .font(.callout)
                    }
                    else {
                        Text("share To: ")
                        Spacer().frame(width: 150)
                    }
                
                    Button(action: {
                        delegate.showPicker = true
                        print("button clicked")
                    }) {
                        Image(systemName: "plus.bubble.fill")
                            .renderingMode(.original)
                            .font(.largeTitle)
                    }
                    .sheet(isPresented: $delegate.showPicker, onDismiss: {
                        delegate.showPicker = false
                        eventsModel.sendRequest(for: userFeedData.userItems[itemIndex], byOwner: true)
                    }) {
                        ContactPicker(delegate: .constant(delegate))
                    }
                }
                
                NavigationLink(destination: WebContentView(url: userFeedData.userItems[itemIndex].originalItemURL ?? "https://amazon.com")) {
                    Label("Open item Link", systemImage: "icloud").font(.title2)
                }.padding([.top], 20)

                Spacer()
                    .frame(height: 50)
                Button("Update Item", action: {
                    userFeedData.userItems[itemIndex].name = itemName
                    userFeedData.userItems[itemIndex].itemCount = Int(itemCount) ?? 0
                    userFeedData.update()
                    presentationMode.wrappedValue.dismiss()
                })
            }
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding(5)
        }
        .navigationBarTitle("Update Item", displayMode: .inline)
        .edgesIgnoringSafeArea([.bottom])
    }
    
    func getFirstNumber(_ contact: CNContact?) -> String? {
        guard let contact = contact else {
            return nil
        }
        let validTypes = [
            CNLabelPhoneNumberiPhone,
            CNLabelPhoneNumberMobile,
            CNLabelPhoneNumberMain
        ]

        let numbers = contact.phoneNumbers.compactMap { phoneNumber -> String? in
            guard let label = phoneNumber.label, validTypes.contains(label) else { return nil }
            return phoneNumber.value.stringValue
        }

        guard !numbers.isEmpty else { return nil }

        return numbers[0]
    }
    
    func getContactName(_ contact: CNContact?) -> String {
        guard let contact = contact else {
            return ""
        }
        var fullName: String = ""
        if contact.namePrefix.count > 0 {
            fullName += contact.namePrefix
            fullName += " "
        }
        if contact.givenName.count > 0 {
            fullName += contact.givenName
            fullName += " "
        }
        if contact.middleName.count > 0 {
            fullName += contact.middleName
            fullName += " "
        }
        if contact.familyName.count > 0 {
            fullName += contact.familyName
            fullName += " "
        }
        if contact.nameSuffix.count > 0 {
            fullName += contact.nameSuffix
            fullName += " "
        }
        fullName = fullName.trimmingCharacters(in: .whitespaces)
        return fullName
    }
}


struct UpdateItemView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateItemView(itemIndex: 0)
    }
}
