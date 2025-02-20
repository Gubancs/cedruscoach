import Foundation

extension Date {
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let currentDate = Date()

        // Maximum Date (5 years ago)
        let maxDate = calendar.date(byAdding: .year, value: -5, to: currentDate) ?? currentDate

        // Minimum Date (100 years ago)
        let minDate = calendar.date(byAdding: .year, value: -100, to: currentDate) ?? currentDate

        return minDate...maxDate
    }

     func isWithinAgeRange(minYears: Int, maxYears: Int) -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let age = calendar.dateComponents([.year], from: self, to: now).year!

        return age >= minYears && age <= maxYears
    }
}
