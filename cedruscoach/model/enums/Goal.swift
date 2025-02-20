enum Goal: String, CaseIterable, Identifiable {
    case gainMuscle = "Izomnövelés"
    case strength = "Erőnlét"
    case loseWeight = "Fogyás"

    var id: String { self.rawValue }
    
}
