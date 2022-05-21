//
//  DashboardHomeView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

struct DashboardHomeView: View {
    @State var searchText: String
    @EnvironmentObject var friendsFeedData: FriendsFeedModel
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
                Button(action: {}) {
                    Image(systemName: "slider.vertical.3")
                        .renderingMode(.original)
                        .font(.largeTitle)
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
                        ForEach(friendsFeedData.friendsItems) { item in
                            NavigationLink(destination: ReadOnlyItemView(item: item), label: {
                                if let imageURL = item.imageURL {
                                    AsyncImage(url: URL(string: imageURL)) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120,  alignment: .center)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                else {
                                    AsyncImage(url: URL(string: "notAvailable")) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120,  alignment: .center)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            })
                        }
                        Spacer()
                            .frame(height: 20)
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
}

struct DashboardHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardHomeView(searchText: "").environmentObject(FriendsFeedModel())
    }
}
