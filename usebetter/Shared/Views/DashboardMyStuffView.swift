//
//  DashboardMyStuffView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/12/22.
//

import SwiftUI

struct DashboardMyStuffView: View {
    @State var searchText: String
    @State var onAddNewItem: Bool = false
    @State var onItemClicked: Bool = false
    @EnvironmentObject var userFeedData: UserFeedModel
    let dvm = DashboardHomeViewModel()
    var items: [GridItem] {
        Array(repeating: .init(.flexible()), count: 3)
    }
    var body: some View {
        NavigationView {
        ZStack(alignment: .top) {
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .foregroundColor(.gray)
                    .padding(0)
                    .font(.largeTitle)
                    .frame(alignment: .topLeading)
                TextField("Search", text: $searchText)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    onSearchItem()
                }
                Spacer()
                NavigationLink(destination: AddItemView(), isActive: $onAddNewItem) {
                    Button(action: {
                        onAddNewItem = true
                    }) {
                        Image(systemName: "plus.bubble.fill")
                            .renderingMode(.original)
                            .font(.largeTitle)
                    }
                }
                Spacer()
            }
            .frame(minWidth: 0, maxHeight: 30, alignment: .topLeading)
            .padding(5)
            .offset(x:5, y: 5)
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    Spacer()
                    LazyVGrid(columns: items, spacing: 10) {
                        ForEach(userFeedData.filteredItems(searchText: $searchText.wrappedValue)) { item in
                            NavigationLink(destination: UpdateItemView(itemId: item.itemid, itemName: item.name, itemCount: String(item.itemCount)).environmentObject(userFeedData), label: {
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
                                        Image("notAvailable")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120,  alignment: .center)
                                    }
                                })
                        }
                    }
                }
                .padding()
            }
            .foregroundColor(Color.black.opacity(0.7))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
            .offset(x:0, y:40)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea([.bottom])
        }
    }
    
    func onSearchItem() {
        print("on search")
    }
    
    func onAdd() {
        
    }
}

struct DashboardMyStuffView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardMyStuffView(searchText: "")
    }
}
