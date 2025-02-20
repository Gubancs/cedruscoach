//
//  DayView.swift
//  cedruscoach
//
//  Created by Gabor Kokeny on 20/02/2025.
//
import SwiftUI

struct DayView: View {
    let date: Date
    let isSelected: Bool
    let eventColor: Color?

    var body: some View {
        Text("\(Calendar.current.component(.day, from: date))")
            .font(.headline)
            .frame(width: 40, height: 40)
            .background(isSelected ? Color.blue.opacity(0.3) : Color.clear)
            .overlay(
                Circle()
                    .fill(eventColor ?? Color.clear)
                    .frame(width: 10, height: 10)
                    .offset(y: 15)
            )
            .clipShape(Circle())
    }
}


#Preview {
    DayView(date: Date(), isSelected: true, eventColor: .red)
}
