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
    @EnvironmentObject var eventsModel: EventsModel
    
    var body: some View {
        UBNavigationStackView {
            ZStack(alignment: .top) {
                VStack() {
                    Spacer().frame(height: 10)
                    Text("Events")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .top)
                    
                    DashboardEventsGridView().environmentObject(eventsModel)
                    Spacer()
                } //VStack
                .padding()
            }
        }
        .refreshable {
            logger.log("DashboardEventsView: refreshable. Reloadign Events")
            //eventsModel.loadRemote()
        }
        .navigationBarHidden(true)
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
            .environmentObject(MockEventsModel() as EventsModel)
    }
}

struct DashboardEventsGridView: View {
    // private var localEvents: [UBEvent] = []
    private let dashboardEventsViewModel = DashboardEventsViewModel()
    @EnvironmentObject var eventsModel: EventsModel
    //private static let iconSize = CGFloat(60)
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(eventsModel.filteredEvents(), id: \.id) { currentEvent in
                if let item = eventsModel.item(by: currentEvent.itemid) {
                    NavigationLink(destination: ReadOnlyItemView(item: item).environmentObject(eventsModel), label: {
                        UBAsyncImageView(asyncImage: item.imageURL)
                        
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
                    .padding(2)
                    .overlay( RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.5), lineWidth: 1))
                }
            }
        } //end of scroll view
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
        DashboardEventsGridView()
            .environmentObject(MockEventsModel() as EventsModel)
    }
}
