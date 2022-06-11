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
    @EnvironmentObject var transactions: TransactionsModel
    
    let contactHelper = ContactHelper()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                    .frame(height: 50)
                if let imageURL = item.imageURL {
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
                    
                }
                
                NavigationLink(destination: WebContentView(url: item.originalItemURL ?? "https://amazon.com")) {
                    Label("Open item Link", systemImage: "icloud").font(.title2)
                }.padding([.top], 20)

                Button("Request To Use Better", action: {
                    transactions.sendRequest(for: item)
                })
                .font(.subheadline)
            }
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding(5)
        }
        .navigationBarTitle("View Item", displayMode: .inline)
        .edgesIgnoringSafeArea([.bottom])
        .onAppear() {
            contactHelper.contactFullname(for: item.ownerid) { name in
                self.contactName = name
            }
        }
    }
}

struct ReadOnlyItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReadOnlyItemView(item: UBItem(name: "Some long name to see", itemid: UUID(), ownerid: "17142615481"))
    }
}
