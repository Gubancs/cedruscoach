import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trainees: [Trainee]

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: TraineeListView()) {
                    VStack {
                        Text("\(trainees.count)")
                            .font(.system(size: 60, weight: .bold)) // Nagyobb szám
                            .foregroundColor(Color.primary) // Szöveg színe
                        
                        Text("Ügyfeleim száma")
                            .font(.title3)
                            .foregroundColor(Color.primary) // Kisebb felirat
                    }
                    .padding(10) // Padding a kereten belül
                    .frame(width: 300, height: 200) // Fix méret
                    .background(
                        RoundedRectangle(cornerRadius: 20) // Lekerekített keret
                            .fill(Color.secondary) // Háttérszín
                            .shadow(radius: 5) // Árnyék
                    )
                    .overlay( // Keret
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                }
                Spacer()
                HStack {
                    // Gomb 1
                    Button {
                        //TODO
                    } label: {
                        VStack {
                            Image(systemName: "house") // Ikon
                                .font(.title3)
                            Text("kezdőlap") // Szöveg
                                .font(.caption) // Kicsi betűméret
                        }
                        .frame(maxWidth: .infinity) // Szélesség kitöltése
                    }

                    // Gyakorlatok gomb
                    NavigationLink(destination: ExerciseListView()) {
                        VStack {
                            Image(systemName: "dumbbell") // Ikon
                                .font(.title3)
                            Text("gyakorlatok") // Szöveg
                                .font(.caption) // Kicsi betűméret
                        }
                        .frame(maxWidth: .infinity) // Szélesség kitöltése
                    }

                    // Gomb 3
                    Button {
                        //TODO
                    } label: {
                        VStack {
                            Image(systemName: "gear") // Ikon
                                .font(.title3)
                            Text("beállítások") // Szöveg
                                .font(.caption) // Kicsi betűméret
                        }
                        .frame(maxWidth: .infinity) // Szélesség kitöltése
                    }
                }
                .padding(.bottom)
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.primary) // Gombok színe
            }
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardView()
        .modelContainer(for: [Trainee.self, Exercise.self], inMemory: true) { result in
            switch result {
            case .success(let container):
                // Dummy adatok hozzáadása a Preview-hoz
                let dummyTrainees = [
                    Trainee(name: "Kökény Gábor",email: "kokeny19@gmail.com", gender: "Férfi", birthDate: Date(), height: 192, startingWeight: 88),
                ]
                
                for trainee in dummyTrainees {
                    container.mainContext.insert(trainee)
                }
            case .failure(let error):
                fatalError("Failed to create model container: \(error)")
            }
        }
}
