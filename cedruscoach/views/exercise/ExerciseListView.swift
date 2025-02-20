import SwiftUI
import SwiftData

struct ExerciseListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var exercises: [Exercise]
    @State private var searchText = ""
    @State private var isInitialized = false
    @State private var showingAddExerciseView = false // Új állapotváltozó

    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return exercises
        } else {
            return exercises.filter { exercise in
                exercise.name.localizedCaseInsensitiveContains(searchText) ||
                exercise.desc.localizedCaseInsensitiveContains(searchText) ||
                exercise.primaryMuscle.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
                .padding(.top)

            List {
                exerciseListContent()
            }
            .listStyle(.plain)
        }
        .navigationTitle("Gyakorlatok")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddExerciseView = true
                }) {
                    Label("Gyakorlat hozzáadása", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExerciseView) {
            ExerciseView()
        }
        .onAppear {
            if !isInitialized {
                initializeData()
                isInitialized = true
            }
        }
    }

    @ViewBuilder
    private func exerciseListContent() -> some View {
        ForEach(filteredExercises) { exercise in
            NavigationLink {
                ExerciseView(exercise: exercise)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .font(.headline)
                        Text("Fő izomcsoport: \(exercise.primaryMuscle)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Szint: \(exercise.level)")
                            .font(.caption)
                            .foregroundColor(Level(rawValue: exercise.level)?.color ?? .gray)
                        Text("Cél: \(exercise.goal)")
                            .font(.caption)
                    }
                }
            }
        }
    }

    private func initializeData() {
        // Ellenőrizzük, hogy vannak-e már gyakorlatok az adatbázisban
        let descriptor = FetchDescriptor<Exercise>()
        var count = 0

        do {
            count = try modelContext.fetchCount(descriptor)
        } catch {
            print("Nem sikerült megszámolni a gyakorlatokat: \(error)")
        }

        if count == 0 {
            // Ha nincsenek, akkor létrehozzuk az alapértelmezett gyakorlatokat
            let defaultExercises = createDefaultExercises()
            for exercise in defaultExercises {
                modelContext.insert(exercise)
            }
            
            do {
                try modelContext.save()
                print("Sikeresen létrehoztuk a default gyakorlatokat")
            } catch {
                print("Nem sikerült elmenteni a gyakorlatokat: \(error)")
            }
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Keresés", text: $searchText)
                .foregroundColor(.primary)
            
            if !searchText.isEmpty {
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(0.6)
                }
            }
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
    }
}

#Preview {
    ExerciseListView()
        .modelContainer(for: [Exercise.self], inMemory: true)
}
