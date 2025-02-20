import SwiftUI
import SwiftData
import UIKit

struct TraineeListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var trainees: [Trainee]

    @State private var showingAddTraineeView = false
    @State private var showingDeleteConfirmation = false
    @State private var traineeToDelete: Trainee? = nil

    var body: some View {
        List {
            ForEach(trainees) { trainee in
                NavigationLink {
                    TraineeDetailsView(trainee: trainee) // TraineeDetailsView megjelenítése
                } label: {
                    HStack {
                        // Profilkép
                        if let imageData = trainee.profileImageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())    
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                        }

                        VStack(alignment: .leading) { // Név és életkor
                            Text(trainee.name)
                            if let birthDate = trainee.birthDate {
                                Text("\(calculateAge(from: birthDate)) éves \(trainee.gender)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .onDelete(perform: confirmDeleteTrainee)
        }
        .navigationTitle("Ügyfeleim")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddTraineeView = true
                }) {
                    Label("Ügyfél hozzáadása", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddTraineeView) {
            TraineeView()
        }
        .confirmationDialog(
            "Biztosan törlöd a kijelölt ügyfelet?",
            isPresented: $showingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Törlés", role: .destructive) {
                deleteTrainee()
            }
            Button("Mégse", role: .cancel) { }
        } message: {
            Text("Ez a művelet nem vonható vissza.")
        }
    }

    private func confirmDeleteTrainee(offsets: IndexSet) {
        if let index = offsets.first {
            traineeToDelete = trainees[index]
            showingDeleteConfirmation = true
        }
    }

    private func deleteTrainee() {
        if let traineeToDelete {
            modelContext.delete(traineeToDelete)
        }
        self.traineeToDelete = nil
    }
}

#Preview {
    TraineeListView()
        .modelContainer(for: [Trainee.self], inMemory: true) { result in
            switch result {
            case .success(let container):
                // Dummy adatok hozzáadása a Preview-hoz
                let dummyTrainees = [
                    Trainee(name: "Kökény Gábor",email: "kokeny19@gmail.com", gender: Gender.male.id, birthDate: Calendar.current.date(byAdding: .year, value: -35, to: Date())!, height: 192, startingWeight: 88),
                    Trainee(name: "Teszt Elek",email: "teszt@example.com", gender: Gender.male.id, birthDate: Calendar.current.date(byAdding: .year, value: -52, to: Date())!, height: 175, startingWeight: 70),
                     Trainee(name: "Minta Mari",email: "minta@example.com", gender: Gender.female.id, birthDate: Calendar.current.date(byAdding: .year, value: -40, to: Date())!, height: 160, startingWeight: 60)
                ]

                for trainee in dummyTrainees {
                    container.mainContext.insert(trainee)
                }
            case .failure(let error):
                fatalError("Failed to create model container: \(error)")
            }
        }
}
