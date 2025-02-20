import Foundation

func calculateAge(from birthDate: Date) -> Int {
    let calendar = Calendar.current
    let now = Date()
    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
    return ageComponents.year ?? 0
}
