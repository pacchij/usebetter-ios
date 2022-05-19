//
//  DashboardHomeView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

struct DashboardHomeView: View {
    @State var searchText: String
    @State var onItemClicked: Bool = false
    let dvm = DashboardHomeViewModel()
    var items: [GridItem] {
        Array(repeating: .init(.flexible()), count: 3)
    }
    var body: some View {
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
                        ForEach(dvm.items(searchTag: searchText)) { item in
                            NavigationLink(destination: UpdateItemView(item: item, itemName: item.name, itemCount: "1"), isActive: $onItemClicked) {
                                Button {
                                    print("Button is tapped")
                                    onItemClicked = true
                                } label: {
                                    item.getImage
                                        .resizable()
                                        .frame(width: 120, height: 120,  alignment: .center)
                                        .padding(1)
                                }
                            }
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
    }
    
    func onSearchItem() {
        print("on search")
    }
}

struct DashboardHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardHomeView(searchText: "")
    }
}
