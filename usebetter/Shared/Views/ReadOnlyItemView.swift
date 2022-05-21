//
//  UpdateItemView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/20/22.
//

import Foundation
import SwiftUI

struct ReadOnlyItemView: View {
    @State var itemIndex: Int
    @State private var itemName: String = ""
    @State private var itemCount: String = "1"
    @EnvironmentObject var userFeedData: UserFeedModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                    .frame(height: 50)
                if let imageURL = userFeedData.userItems[itemIndex].imageURL {//} item.imageURL {
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
                Text(userFeedData.userItems[itemIndex].name)
                
                HStack {
                    Text("Tags:")
                    Text( userFeedData.userItems[itemIndex].getTags)
                }
                .padding(20)
                
                HStack {
                    Text("Available Counts: ")
                    TextField(userFeedData.userItems[itemIndex].itemCount, text: $itemCount)
                        .onSubmit {
                            print("submitted")
                        }
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 50)
                }
            }
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding(5)
        }
        .navigationBarTitle("Update Item", displayMode: .inline)
        .edgesIgnoringSafeArea([.bottom])
    }
}


struct ReadOnlyItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReadOnlyItemView(itemIndex: 0)
    }
}
