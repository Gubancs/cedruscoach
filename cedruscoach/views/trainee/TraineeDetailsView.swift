import SwiftUI
import UIKit

struct TraineeDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let trainee: Trainee
    @State private var showingEditView = false // Állapotváltozó a szerkesztéshez

    var body: some View {
            Form {
                Section(header: Text("Profilkép")) {
                    HStack {
                        Spacer() // Középre igazítás
                        if let imageData = trainee.profileImageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                        Spacer() // Középre igazítás
                    }
                }

                Section(header: Text("Alap adatok")) {
                    Text("Név: \(trainee.name)")
                    Text("Email: \(trainee.email)")
                    if let phoneNumber = trainee.phoneNumber {
                        Text("Telefonszám: \(phoneNumber)")
                    } else {
                        Text("Telefonszám: Nincs megadva")
                            .foregroundColor(.gray)
                    }
                    if let birthDate = trainee.birthDate {
                        Text("Születési dátum: \(birthDate, formatter: dateFormatter)")
                    } else {
                        Text("Születési dátum: Nincs megadva")
                            .foregroundColor(.gray)
                    }
                    Text("Nem: \(trainee.gender)")
                }

                Section(header: Text("Testi adatok")) {
                    if let height = trainee.height {
                        Text("Magasság: \(height) cm")
                    } else {
                        Text("Magasság: Nincs megadva")
                            .foregroundColor(.gray)
                    }
                    if let startingWeight = trainee.startingWeight {
                        Text("Kezdő súly: \(startingWeight, specifier: "%.2f") kg")
                    } else {
                        Text("Kezdő súly: Nincs megadva")
                            .foregroundColor(.gray)
                    }
                }

                Section(header: Text("Egyéb")) {
                    if let notes = trainee.notes {
                        Text("\(notes)")
                    } else {
                        Text("Jelenleg nincs jegyzet")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Ügyfél adatai")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingEditView = true // Szerkesztő nézet megjelenítése
                    } label: {
                        Image(systemName: "pencil") // Szerkesztés ikon
                    }
                }
            }
            .sheet(isPresented: $showingEditView) { // A TraineeView megjelenítése
                TraineeView(trainee: trainee) // Szerkesztő nézet
            }
        .navigationViewStyle(.stack)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "hu_HU")
        return formatter
    }()
}

#Preview {
    // Dummy Trainee adatok a Preview-hoz
    let dummyTrainee =   Trainee(name: "Kökény Gbor",email: "kokeny19@gmail.com", gender: Gender.male.rawValue, birthDate: Date(), height: 192, startingWeight: 88,phoneNumber: "06301234567",notes: "nagyon motivált")

    return TraineeDetailsView(trainee: dummyTrainee)
        .modelContainer(for: [Trainee.self], inMemory: true)
}
