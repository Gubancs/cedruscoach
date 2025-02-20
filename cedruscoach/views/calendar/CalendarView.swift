//
//  CalendarView.swift
//  cedruscoach
//
//  Created by Gabor Kokeny on 20/02/2025.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    let events: [Date: Color] = [
        Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 20))!: .red,
        Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 25))!: .blue
    ]

    var body: some View {
        VStack {
            Text("Edzés Naptár")
                .font(.title)
                .padding()

            MonthView(selectedDate: $selectedDate, events: events)
                .padding()
            
            EventListView(selectedDate: selectedDate, events: events)
                            .padding()
        }
    }
}


#Preview {
    CalendarView()
}
