//
//  DashboardMyStuffView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/12/22.
//

import SwiftUI

struct DashboardMyStuffView: View {
    @State var searchText: String
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
                .border(Color.green, width: 1)
                .onSubmit {
                    onSearchItem()
                }
                Spacer()
                Button(action: {
                    onAdd()
                }) {
                    Image(systemName: "plus.bubble.fill")
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
                            Image(item.name)
                                .resizable()
                                .frame(width: 120, height: 120,  alignment: .center)
                                .padding(1)
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
