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
    private var localEvents: [UBEvent] = []
    private let dashboardEventsViewModel = DashboardEventsViewModel()
    
    @EnvironmentObject var eventsModel: EventsModel
    var items: [GridItem] {
        Array(repeating: .init(.flexible()), count: 2)
    }
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 10)
                    Text("Events")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        if eventsModel.events.count == 0 {
                            Text("No Events found")
                        }
                        else {
                            DashboardEventsGridView()
                        } //scroll view
                    } //else
                    .navigationBarHidden(true)
                    //.edgesIgnoringSafeArea([.])
                } //VStack
            }
        }
        .refreshable {
            logger.log("DashboardEventsView: refreshable. Reloadign Events")
            eventsModel.loadRemote()
        }
    } //Body
    
    func onSearchItem() {
        logger.log("on search")
    }
    
    func backgroundColorByState(for state: EventState) -> Color {
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
        
        DashboardEventsView()
            .environmentObject(EventsModel())
        
    }
}

struct DashboardEventsGridView: View {
    private var localEvents: [UBEvent] = []
    private let dashboardEventsViewModel = DashboardEventsViewModel()
    @EnvironmentObject var eventsModel: EventsModel
    private static let iconSize = CGFloat(60)
    var body: some View {
        VStack{
            ForEach(eventsModel.events, id: \.id) { currentEvent in
                VStack {
                    if let item = eventsModel.item(by: currentEvent.itemid) {
                    NavigationLink(destination: ReadOnlyItemView(item: item).environmentObject(eventsModel), label: {
                        if let imageURL = item.imageURL {
                            AsyncImage(url: URL(string: imageURL)) { localImage in
                                localImage.resizable()
                                    .scaledToFit()
                                    .frame(width: DashboardEventsGridView.iconSize, height: DashboardEventsGridView.iconSize,  alignment: .topLeading)
                            } placeholder: {
                                ProgressView()
                            }
                            
                        }
                        else {
                            Image("notAvailable")
                                .resizable()
                                .scaledToFit()
                                .frame(width: DashboardEventsGridView.iconSize, height: DashboardEventsGridView.iconSize,  alignment: .topLeading)
                        }
                        
                        VStack {
                            let uiState = dashboardEventsViewModel.getUIState(for: currentEvent, false)
                            
                            Text(uiState.label)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text(eventReceiverName(event: currentEvent))
                                .foregroundColor(Color.orange.opacity(0.5))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            HStack {
                                if let pbText = uiState.primaryButtonText {
                                    Button(pbText, action: {
                                        eventsModel.updateEventState(by: currentEvent.id, newState: uiState.primaryButtonActionState ?? EventState.archived)
                                    })
                                    .padding(10)
                                }
                                
                                if let sbText = uiState.secondaryButtonText {
                                    Button(sbText, action: {
                                        eventsModel.updateEventState(by: currentEvent.id, newState: uiState.secondaryButtonActionState ?? EventState.archived)
                                    })
                                    .padding(10)
                                }
                            } //HStack for buttons
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        } //VStack for right side texts
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }) //End of navigation
                }
                            } //VSTck for each Row
                            .padding(5)
                            .overlay( RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.5), lineWidth: 1))
            } //end of forEach
            .padding([.trailing, .leading], 5)
            .frame(width: UIScreen.main.bounds.width)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
    
    private func eventReceiverName(event: UBEvent) -> String {
        if event.ownerid == (AccountManager.sharedInstance.currentUsername ?? "") {
            return event.receiverid
        }
        else {
            return event.ownerid
        }
    }
}


struct DashboardEventsGridView_Previews: PreviewProvider {
    static var previews: some View {
        
        DashboardEventsView()
            .environmentObject(EventsModel())
        
    }
}
