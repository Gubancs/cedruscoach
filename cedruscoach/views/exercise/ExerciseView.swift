import SwiftUI
import SwiftData

struct ExerciseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var viewModel: ExerciseFormViewModel
    @State private var showingEquipmentSelectView = false

    init(exercise: Exercise? = nil) {
        _viewModel = ObservedObject(wrappedValue: ExerciseFormViewModel(exercise: exercise))
    }

    var body: some View {
       
        HStack(alignment: .center) {
            Button("Mégse") {
                dismiss()
            }
            .padding(.leading, 20)
            
            Spacer()
            
            Text("Gyakorlat adatai")
                .foregroundColor(.primary)
            
            Spacer()
            
            Button("Mentés") {
                viewModel.validateForm()
                if viewModel.isValid {
                    viewModel.saveExercise(context: modelContext)
                    dismiss()
                }
            }.padding(.trailing, 20)
        }
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        Form {
            Section(header: Text("Alap adatok")) {
                VStack(alignment: .leading) {
                    Text("Név").font(.caption)
                    TextField("Gyakorlat neve", text: $viewModel.name)
                    if viewModel.isNameInvalid {
                        Text("A név megadása kötelező")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                VStack(alignment: .leading) {
                    Text("Leírás").font(.caption)
                    TextEditor(text: $viewModel.desc)
                        .frame(height: 100)
                    if viewModel.isDescInvalid {
                        Text("A leírás megadása kötelező")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                VStack(alignment: .leading) {
                    Text("Fő izomcsoport").font(.caption)
                    Picker("Fő izomcsoport", selection: $viewModel.primaryMuscle) {
                        ForEach(MuscleGroup.allCases, id: \.self) { muscleGroup in
                            Text(muscleGroup.rawValue).tag(muscleGroup)
                        }
                    }
                    if viewModel.isPrimaryMuscleInvalid {
                        Text("A fő izomcsoport kiválasztása kötelező")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }

            Section(header: Text("További beállítások")) {
                
                Picker("Szint", selection: $viewModel.level) {
                    ForEach(Level.allCases, id: \.self) { level in
                        Text(level.rawValue).tag(level)
                    }
                }

                Picker("Cél", selection: $viewModel.goal) {
                    ForEach(Goal.allCases, id: \.self) { goal in
                        Text(goal.rawValue).tag(goal)
                    }
                }

                Button {
                    showingEquipmentSelectView = true
               } label: {
                   HStack {
                       Text("Eszköz: \(viewModel.equipment.rawValue)")
                       Spacer()
                       Image(systemName: "chevron.right")
                   }
               }
               .sheet(isPresented: $showingEquipmentSelectView) {
                   EquipmentSelectView(selectedEquipment: $viewModel.equipment)
               }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ExerciseView()
        .modelContainer(for: [Exercise.self], inMemory: true)
}
