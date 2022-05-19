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
                    UpdateItemView(item: self.item, itemName: self.item.name, itemCount: "1")
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
                //self.item.image = AsyncImage(url: URL(string:item.imageURL ?? ""))
                self.item.price = item.price
                self.item.tags = item.tags
                 
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

struct UpdateItemView: View {
    @State var item: UBItem
    @State var itemName: String
    @State var itemCount: String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                //if let imageURL = item.imageURL {
                    Spacer()
                        .frame(height: 50)
                    item.getImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 100, alignment: .center)
//                    AsyncImage(url: URL(string: imageURL)) { image in
//                        image.resizable()
//                            .scaledToFit()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .frame(width: 200, height: 100, alignment: .center)
 //               }
                
                Spacer()
                    .frame(height: 50)
                TextField(item.name, text: $itemName)
                    .onSubmit {
                        item.name = itemName
                    }
                    .border(Color.green, width: 1)
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(.roundedBorder)
                
                
                HStack {
                    Text("Tags:")
                    Text(item.getTags)
                }
                .padding(20)
                
                HStack {
                    Text("Available Counts: ")
                    TextField("1", text: $itemCount)
                        .onSubmit {
                            print("submitted")
                        }
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 50)
                }

                Spacer()
                    .frame(height: 50)
                Button("Update Item", action: {
                    item = UBItem(name: "")
                    presentationMode.wrappedValue.dismiss()
                })
            }
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding(5)
        }
        .navigationBarTitle("Update Item", displayMode: .inline)
        .edgesIgnoringSafeArea([.bottom])
    }
}


struct UpdateItemView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateItemView(item: UBItem(name: "some Long text describing the item as given in amazon", imageURL: "https://images-na.ssl-images-amazon.com/images/I/7115SjgfuxL.__AC_SY300_SX300_QL70_ML2_.jpg", tags: ["one", "two"]), itemName: "", itemCount: "1")
    }
}
