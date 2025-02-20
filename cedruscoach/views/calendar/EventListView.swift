//
//  EventListView.swift
//  cedruscoach
//
//  Created by Gabor Kokeny on 20/02/2025.
//
import SwiftUI


struct EventListView: View {
    let selectedDate: Date
    let events: [Date: [String]]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Órák ezen a napon:")
                .font(.headline)
                .padding(.bottom, 5)

            if let eventList = events[selectedDate], !eventList.isEmpty {
                List(eventList, id: \.self) { event in
                    Text(event)
                }
                .frame(height: 150)
            } else {
                Text("Nincsenek órák ezen a napon.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
