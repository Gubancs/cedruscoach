enum MuscleGroup: String, CaseIterable, Identifiable {
    case chest = "Mell"
    case back = "Hát"
    case shoulders = "Váll"
    case biceps = "Bicepsz"
    case triceps = "Tricepsz"
    case legs = "Láb"
    case abs = "Has"
    case cardio = "Kardió"

    var id: String { self.rawValue }
}
