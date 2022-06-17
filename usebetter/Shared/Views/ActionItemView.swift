//
//  ActionItemView.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/30/22.
//

import Foundation
import SwiftUI

struct ActionItemView: View {
    @State var index = 0
    @State var isPreview = false
    @State private var contactName: String = "determining...."
    
    private let dashboardEventsViewModel = DashboardEventsViewModel()
    @EnvironmentObject var eventsModel: EventsModel
    
    let contactHelper = ContactHelper()
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                    .frame(height: 50)
                if let item = eventsModel.item(by: eventsModel.events[index].itemid)  {
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
                    AsyncImage(url: URL(string: "notAvailable")) { image1 in
                        image1.resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120,  alignment: .center)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Spacer()
                    .frame(height: 50)
                Text(item.name)
                    .frame(width: 400)
                
                HStack {
                    Text("Tags:")
                    Text(item.getTags)
                }
                .padding(20)
                
                HStack {
                    Text("Available Counts: ")
                    Text(String(item.itemCount))
                       .frame(width: 50)
                }
                Spacer().frame(height: 50)
                HStack {
                   
                    Text("shared By: ")
                    Text(self.contactName).frame(width:150)
                        .foregroundColor(.green)
                        .font(.callout)
                    
                }
                Spacer().frame(height: 50)
                    
                NavigationLink(destination: WebContentView(url: item.originalItemURL ?? "https://amazon.com")) {
                    Label("Open item Link", systemImage: "icloud").font(.title2)
                }.padding([.top], 20)
                    
                VStack {
                    let uiState = dashboardEventsViewModel.getUIState(for: eventsModel.events[index], isPreview)
                    
                    Text(uiState.label)
                        .frame(alignment: .topLeading)
                        
                    Spacer()
                    Text("Prashanth Jaligama")
                        .foregroundColor(Color.red.opacity(0.7))
                        .font(.title2)
                    Spacer()
                    HStack {
                        if let pbText = uiState.primaryButtonText {
                            Button(pbText, action: {
                                eventsModel.events[index].state = uiState.primaryButtonActionState?.rawValue ?? EventState.archived.rawValue
                            })
                            .padding(10)
                        }
                        
                        if let sbText = uiState.secondaryButtonText {
                            Button(sbText, action: {
                                eventsModel.events[index].state = uiState.secondaryButtonActionState?.rawValue ?? EventState.archived.rawValue
                            })
                            .padding(10)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 120, alignment: .trailing)
                
            }
            }
            .frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding(5)
           
        }
        .navigationBarTitle("View Item", displayMode: .inline)
        .edgesIgnoringSafeArea([.bottom])
        .onAppear() {
            contactHelper.contactFullname(for: eventsModel.events[index].receiverid) { name in
                self.contactName = name
            }
        }
    }
}

struct ActionItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActionItemView(index: 0, isPreview: true)
    }
}


