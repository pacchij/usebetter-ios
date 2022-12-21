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
    private static let iconSize = CGFloat(90)
    let columns = [GridItem(.adaptive(minimum: DashboardHomeView.iconSize))]
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
                    LazyVGrid(columns: columns) {
                        ForEach(friendsFeedData.filteredItems(searchText: $searchText.wrappedValue)) { item in
                            NavigationLink(destination: ReadOnlyItemView(item: item), label: {
                                if let imageURL = item.imageURL {
                                    AsyncImage(url: URL(string: imageURL)) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: DashboardHomeView.iconSize, height: DashboardHomeView.iconSize,  alignment: .center)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                else {
                                    AsyncImage(url: URL(string: "notAvailable")) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: DashboardHomeView.iconSize, height: DashboardHomeView.iconSize,  alignment: .center)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            })
                        }
                        .padding(5)
                        .overlay( RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.2), lineWidth: 1))
                    }
                }
                .padding()
            }
            .padding()
            .offset(x:0, y:40)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea([.bottom])
        }
    }
    
    func onSearchItem() {
        logger.log("on search")
    }
}

struct DashboardHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardHomeView(searchText: "").environmentObject(FriendsFeedModel())
    }
}
