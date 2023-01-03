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
    let columns = [GridItem(.adaptive(minimum: UBConstants.itemIconSize))]
    var body: some View {
        UBNavigationStackView {
            ZStack(alignment: .top) {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .foregroundColor(.gray)
                            .font(.largeTitle)
                            .frame(alignment: .topLeading)
                        TextField("Search", text: $searchText)
                            .font(.body)
                            .multilineTextAlignment(.center)
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
                    }
                    .padding(5)
                    VStack() {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: columns) {
                                ForEach(userFeedData.filteredItems(searchText: $searchText.wrappedValue)) { item in
                                    NavigationLink(destination: UpdateItemView(itemId: item.itemid, itemName: item.name, itemCount: String(item.itemCount)).environmentObject(userFeedData), label: {
                                        UBAsyncImageView(asyncImage: item.imageURL)
                                    })
                                }
                                .padding(2)
                                .overlay( RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.2), lineWidth: 1))
                            }
                        }
                        .padding()
                    }
                    .padding(5)
                }
                .padding()
                .navigationBarHidden(true)
            }
        }
    }
    
    func onSearchItem() {
        logger.log("on search")
    }
    
    func onAdd() {
        
    }
}

struct DashboardMyStuffView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardMyStuffView(searchText: "")
    }
}
