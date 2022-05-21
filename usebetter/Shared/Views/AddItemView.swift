//
//  AddItemView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/12/22.
//

import SwiftUI

struct AddItemView: View {
    enum ItemParsingState {
        case notStarted
        case starting
        case complete
    }
    @State private var itemURL: String
    @State private var isURLParsing: ItemParsingState
    @State private var item: UBItem = UBItem(name: "")
    @State private var itemName: String
    @EnvironmentObject var userFeedData: UserFeedModel
    init() {
        itemURL = ""
        isURLParsing = .notStarted
        itemName = ""
    }
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                if isURLParsing == .notStarted {
                    Text("Paste Amazon Link")
                    HStack{
                        Spacer()
                    TextField("URL", text: $itemURL)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(5)
                        .border(Color.green, width: 1)
                        .onSubmit {
                            onURLAdd()
                        }
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 50)
                    Button("Submit", action: {
                        onURLAdd()
                    })
                }
                else if isURLParsing == .complete && self.item.name != "" {
                    UpdateItemView(itemIndex: userFeedData.userItems.count-1)
                }
            }
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .center)
            .padding(5)
            .overlay {
                if isURLParsing == .starting {
                    ZStack {
                       
                        Text("Analyzing Link...")
                            .frame(width: 200, height: 100, alignment: .top)
                            
                        Color(white: 0, opacity: 0.3)
                        Spacer()
                        ProgressView().tint(.white)
                    }
                    .frame(width: 200, height: 100, alignment: .center)
                }
            }
        }
        .navigationBarTitle("Add Item", displayMode: .inline)
        .edgesIgnoringSafeArea([.bottom])
    }
    
    func onURLAdd() {
        isURLParsing = .starting
        URLParser(url: itemURL).parse() { item in
            DispatchQueue.main.async {
                isURLParsing = .complete
                guard let item = item else {
                    print("AddItemView: parse callback return nil")
                    return
                }
                self.item.name = item.name
                self.item.description = item.description
                self.item.imageURL = item.imageURL
                self.item.price = item.price
                self.item.tags = item.tags
                self.item.originalItemURL = itemURL
                 
                userFeedData.append(item: self.item)
                print("callback returned with item: ", item)
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
