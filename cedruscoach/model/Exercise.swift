import Foundation
import SwiftData

@Model
class Exercise: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var desc: String
    var primaryMuscle: String
    var level: String
    var goal: String
    var equipment: String

    init(name: String, desc: String, primaryMuscle: MuscleGroup, level: Level, goal: Goal, equipment: Equipment) {
        self.name = name
        self.desc = desc
        self.primaryMuscle = primaryMuscle.id
        self.level = level.id
        self.goal = goal.id
        self.equipment = equipment.id
    }
}
