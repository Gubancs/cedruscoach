
enum Equipment: String, CaseIterable, Identifiable {
    case gym = "Terem"
    case machine = "Machine"
    case smithMachine = "Smith gép"
    case dumbbells = "Kézi súlyzók"
    case ezCurlBar = "Francia rúd"
    case kettlebell = "Kettlebell"
    case barbell = "Rúd"
    case plate = "Tárcsa"
    case bodyWeight = "Saját testsúly"
    case other = "Egyéb"

    var id: String { self.rawValue }
}
