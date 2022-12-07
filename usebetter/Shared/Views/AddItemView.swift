//
//  AddItemView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/12/22.
//

import SwiftUI

struct OverlayTextView: View {
    @State var overlayText: String
    var body: some View {
        ZStack {
           
            Text(overlayText)
                .frame(width: 200, height: 100, alignment: .top)
                
            Color(white: 0, opacity: 0.3)
            Spacer()
            ProgressView().tint(.white)
        }
        .frame(width: 200, height: 100, alignment: .center)
    }
}

struct AddItemView: View {
    enum ItemParsingState {
        case notStarted
        case starting
        case complete
        case error
    }
    @State private var itemURL: String = ""
    @State private var isURLParsing: ItemParsingState = .notStarted
    @State private var item: UBItem = UBItem(name: "", itemid: UUID())
    @State private var itemName: String = ""
    @EnvironmentObject var userFeedData: UserFeedModel

    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                if isURLParsing == .error {
                    Text("Failed to add item. Try Again...")
                        .foregroundColor(Color.red)
                    Spacer().frame(height: 50)
                }
                if isURLParsing == .notStarted || isURLParsing == .error {
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
                    UpdateItemView(itemId: userFeedData.userItems[0].itemid)
                }
            }
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .center)
            .padding(5)
            .overlay {
                if isURLParsing == .starting {
                    OverlayTextView(overlayText: "Analyzing Link...")
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
                guard let item = item else {
                    isURLParsing = .error
                    print("AddItemView: parse callback return nil")
                    return
                }
                self.item.name = item.name
                self.item.description = item.description
                self.item.imageURL = item.imageURL
                self.item.price = item.price
                self.item.tags = item.tags
                self.item.originalItemURL = $itemURL.wrappedValue
                 
                userFeedData.append(item: self.item)
                print("callback returned with item: ", item)
                isURLParsing = .complete
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
