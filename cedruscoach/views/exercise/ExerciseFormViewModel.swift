import SwiftUI
import Combine
import SwiftData

class ExerciseFormViewModel: ObservableObject {
    @Published var id: UUID? = nil
    @Published var name: String = ""
    @Published var desc: String = ""
    @Published var primaryMuscle: MuscleGroup = .chest
    @Published var level: Level = .beginner
    @Published var goal: Goal = .gainMuscle
    @Published var equipment: Equipment = .gym

    @Published var isNameInvalid: Bool = false
    @Published var isDescInvalid: Bool = false
    @Published var isPrimaryMuscleInvalid: Bool = false

    init(exercise: Exercise? = nil) {
        if let exercise = exercise {
            self.id = exercise.id
            self.name = exercise.name
            self.desc = exercise.desc
            self.primaryMuscle = MuscleGroup(rawValue: exercise.primaryMuscle) ?? .chest
            self.level = Level(rawValue: exercise.level) ?? .beginner
            self.goal = Goal(rawValue: exercise.goal) ?? .gainMuscle
            self.equipment = Equipment(rawValue: exercise.equipment) ?? .gym
        }
    }

    var isValid: Bool {
        return !isNameInvalid && !isDescInvalid && !isPrimaryMuscleInvalid
    }

    func validateForm() {
        isNameInvalid = name.isEmpty
        isDescInvalid = desc.isEmpty
        isPrimaryMuscleInvalid = primaryMuscle == .chest // Példa validáció, módosítsd szükség szerint
    }
    
    func saveExercise(context: ModelContext) {
        if let exerciseId = id {
            // Meglévő gyakorlat frissítése
            do {
                let existingExercise = try context.fetch(FetchDescriptor<Exercise>(predicate: #Predicate { $0.id == exerciseId })).first!
                existingExercise.name = name
                existingExercise.desc = desc
                existingExercise.primaryMuscle = primaryMuscle.rawValue
                existingExercise.level = level.rawValue
                existingExercise.goal = goal.rawValue
                existingExercise.equipment = equipment.rawValue
                
                try context.save()
                print("Gyakorlat sikeresen frissítve!")
            } catch {
                print("Hiba a gyakorlat frissítésekor: \(error)")
            }
        } else {
            // Új gyakorlat létrehozása
            let newExercise = Exercise(
                name: name,
                desc: desc,
                primaryMuscle: primaryMuscle,
                level: level,
                goal: goal,
                equipment: equipment
            )
            context.insert(newExercise)
            do {
                try context.save()
                print("Trainee sikeresen mentve!")
            } catch {
                print("Hiba a Trainee mentésekor: \(error)")
            }
        }
    }
}
