//
//  DashboardEventsView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/30/22.
//

import Foundation
import SwiftUI
import Amplify

struct DashboardEventsView: View {
    @State var searchText: String = ""
    @State var primaryActionButtonText = "Accept"
    @State var secondaryActionButtonText = "Cancel"
    @State var detailedSummaryLabelText = ""
    @State var isPreview = false
    
    private let dashboardEventsViewModel = DashboardEventsViewModel()
    
    @EnvironmentObject var transactions: TransactionsModel
    var items: [GridItem] {
        Array(repeating: .init(.flexible()), count: 2)
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
                }
                .frame(minWidth: 0, maxHeight: 30, alignment: .topLeading)
                .padding(5)
                .offset(x:5, y: 5)
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 70)
                    Text("Events")
                        .font(.title)
                    
                   
                    ScrollView(.vertical, showsIndicators: false) {
                        if transactions.transactions.count == 0 {
                            Text("No Events found")
                        }
                        else {
                            ForEach(transactions.transactions.indices, id:\.self) { index in
                                if let item = transactions.item(by: transactions.transactions[index].itemid) {
                                HStack {
                                   
                                    NavigationLink(destination: ActionItemView(index: index).environmentObject(transactions), label: {
                                        if let imageURL = item.imageURL {
                                            AsyncImage(url: URL(string: imageURL)) { image1 in
                                                image1.resizable()
                                                    .scaledToFit()
                                                    .frame(width: 120, height: 120,  alignment: .leading)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                        }
                                        else {
                                              Image("notAvailable")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 120, height: 120,  alignment: .leading)
                                        }
                                    
                                    
                                    VStack {
                                        let uiState = dashboardEventsViewModel.getUIState(for: transactions.transactions[index], isPreview)
                                        
                                        Text(uiState.label)
                                            .frame(alignment: .topLeading)
                                            .foregroundColor(Color.black)
                                            
                                        Spacer()
                                        Text("Prashanth Jaligama")
                                            .foregroundColor(Color.red.opacity(0.7))
                                            .font(.title2)
                                        Spacer()
                                        HStack {
                                            if let pbText = uiState.primaryButtonText {
                                                Button(pbText, action: {
                                                    transactions.transactions[index].state = uiState.primaryButtonActionState ?? .archived
                                                })
                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                                                .padding(10)
                                            }
                                            
                                            if let sbText = uiState.secondaryButtonText {
                                                Button(sbText, action: {
                                                    transactions.transactions[index].state = uiState.secondaryButtonActionState ?? .archived
                                                })
                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .trailing)
                                                .padding(10)
                                            }
                                        } //HStack for buttons
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .trailing)
                                    } //VStack for right side texts
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .trailing)
                                    }) //End of navigation
                                } //HSTck for each Row
                                .padding(5)
                                .frame(width: .infinity, height: .infinity, alignment: .top)
                                }
                            } //end of forEach
                            .background(Color.green.opacity(0.2))
                            .frame(height: 130,  alignment: .center)
                            .padding([.trailing, .leading], 2)
                    } //scroll view
                    } //else
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea([.bottom])
                } //VStack
                 
            }
        }
    } //Body
    
    func onSearchItem() {
        print("on search")
    }
    
    func backgroundColorByState(for state: TransactionState) -> Color {
        switch state {
        case .archived:
            return Color.gray.opacity(0.5)
        default:
            return Color.green.opacity(0.5)
        }
    }
    
    
}

struct DashboardEventsView_Previews: PreviewProvider {
    static var previews: some View {
        
        DashboardEventsView(isPreview: true)
            .environmentObject(TransactionsModel())
            
    }
}
