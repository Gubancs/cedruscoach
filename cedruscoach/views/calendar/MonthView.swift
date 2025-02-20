//
//  MonthView.swift
//  cedruscoach
//
//  Created by Gabor Kokeny on 20/02/2025.
//
import SwiftUI

struct MonthView: View {
    @Binding var selectedDate: Date
    let events: [Date: Color]

    let calendar = Calendar.current
    let weekdays = ["H.", "K.", "Sz.", "Cs.", "P.", "Szo.", "V."]

    var days: [Date] {
        let range = calendar.range(of: .day, in: .month, for: selectedDate)!
        let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: firstDay) }
    }

    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 7)

        VStack {
            // Hét napjainak rövidítése
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(days, id: \.self) { date in
                    DayView(date: date, isSelected: calendar.isDate(date, inSameDayAs: selectedDate), eventColor: events[date])
                        .onTapGesture {
                            selectedDate = date
                        }
                }
            }
        }
    }
}

#Preview {
    MonthView(selectedDate: .constant(Date()), events: [:])
}

