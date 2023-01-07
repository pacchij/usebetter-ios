//
//  DashboardHomeView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

struct DashboardHomeView: View {
    @State var searchText: String? = nil
    @State private var searchText_: String = ""
    @EnvironmentObject var friendsFeedData: FriendsFeedModel
    @EnvironmentObject var notificationCenterDelegate: UBNotificationCenterDelegate
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
                        TextField("Search", text: $searchText_)
                            .font(.body)
                            .multilineTextAlignment(.center)
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
                    }
                    .padding(5)
                    VStack() {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: columns) {
                                ForEach(friendsFeedData.filteredItems(searchText: searchText)) { item in
                                    NavigationLink(destination: ReadOnlyItemView(item: item), label: {
                                        UBAsyncImageView(asyncImage: item.imageURL)
                                    })
                                }
                                .padding(2)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.2), lineWidth: 1))
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
        .onAppear {
            self.requestNotification()
        }
    }
    
    func onSearchItem() {
        searchText = $searchText_.wrappedValue
    }
    
    private func requestNotification() {
        UNUserNotificationCenter.current().delegate = self.notificationCenterDelegate
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { succeess, error in
            guard succeess else {
                logger.log("[AppDelegate] request authorization Result success= \(succeess) error= \(error)")
                return
            }
        }
    }
}

struct DashboardHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardHomeView(searchText: "").environmentObject(FriendsFeedModel())
    }
}


class MockFriendsFeedModel: FriendsFeedModel {
    override func filteredItems(searchText: String?) -> [UBItem] {
        var items: [UBItem] = []
        items.append(UBItem(name: "item1", itemid: UUID(), imageURL: "https://cdn.pixabay.com/photo/2015/03/17/02/01/cubes-677092__480.png"))
        items.append(UBItem(name: "item2", itemid: UUID(), imageURL: "https://cdn.pixabay.com/photo/2015/03/17/02/01/cubes-677092__480.png"))
        return items
    }
}
