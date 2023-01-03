//
//  UpdateItemView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/20/22.
//

import Foundation
import SwiftUI

struct ReadOnlyItemView: View {
    @State var item: UBItem
    @State private var itemName: String = ""
    @State private var itemCount: String = "1"
    @State private var contactName: String = "determining...."
    @State var onItemLinkSelected: Bool = false
    @EnvironmentObject var userFeedData: UserFeedModel
    @EnvironmentObject var eventsModel: EventsModel
    
    let contactHelper = ContactHelper()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                    .frame(height: 50)
                UBAsyncImageView(asyncImage: item.imageURL)
                Spacer()
                    .frame(height: 50)
                Text(item.name)
                    .frame(width: 400)
                
                HStack {
                    Text("Tags:")
                    Text(item.getTags)
                }
                .padding(20)
                
                HStack {
                    Text("Available Counts: ")
                    Text(String(item.itemCount))
                        .frame(width: 50)
                }
                Spacer().frame(height: 50)
                HStack {
                    
                    Text("shared By: ")
                    Text(self.contactName).frame(width:150)
                        .foregroundColor(.green)
                        .font(.callout)
                    
                }.padding(20)
                
                Button("Request To Use Better", action: {
                    eventsModel.createRequest(for: item)
                })
                .font(.subheadline)
                
                NavigationLink(destination: WebContentView(url: item.originalItemURL ?? "https://amazon.com")) {
                    Label("Open item Link", systemImage: "icloud").font(.title2)
                }.padding([.top], 20)
            }
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding(5)
        }
        .navigationBarTitle("View Item", displayMode: .inline)
        .edgesIgnoringSafeArea([.bottom])
        .onAppear() {
            self.contactName = AccountManager.sharedInstance.displayName
        }
    }
}

struct ReadOnlyItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReadOnlyItemView(item: UBItem(name: "Some long name to see", itemid: UUID(), ownerid: "17142615481"))
    }
}
