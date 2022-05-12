//
//  DashboardHomeView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/11/22.
//

import SwiftUI

struct DashboardHomeView: View {
    @State var searchText: String = " search"
    var items: [GridItem] {
        Array(repeating: .init(.flexible()), count: 3)
    }
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                TextField("Home Page", text: $searchText)
                .font(.subheadline)
                .frame(maxWidth: .infinity, minHeight: 30)
                .multilineTextAlignment(.center)
                .padding(5)
                .border(Color.green, width: 1)
                .onSubmit {
                    onSearchItem()
                }
            }
            .frame(minWidth: 0, maxHeight: 30, alignment: .topLeading)
            .padding(20)
            .offset(x:0, y: 10)
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: items, spacing: 10) {
                        ForEach(0..<100) { it in
                                Text("Item \(it)")
                                    .font(.title)
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
        
    }
}

struct DashboardHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardHomeView()
    }
}
