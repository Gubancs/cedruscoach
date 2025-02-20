enum Gender: String, CaseIterable, Identifiable {
    case male = "Férfi"
    case female = "Nő"
    case other = "Egyéb" // Nem kötelező, de ha van "egyéb" opciód

    var id: String { self.rawValue }
}
