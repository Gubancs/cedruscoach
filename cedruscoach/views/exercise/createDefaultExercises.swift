import SwiftUI
import SwiftData

func createDefaultExercises() -> [Exercise] {
    return [
        Exercise(name: "Fekvenyomás", desc: "Egy klasszikus gyakorlat a mellizmokra.", primaryMuscle: MuscleGroup.chest, level: Level.medium, goal: Goal.gainMuscle, equipment: Equipment.gym),
        Exercise(name: "Húzódzkodás", desc: "Remek gyakorlat a hátizmokra.", primaryMuscle: MuscleGroup.back, level: Level.medium, goal: Goal.strength, equipment: Equipment.bodyWeight),
        Exercise(name: "Vállprés", desc: "Alapgyakorlat a vállizmokra.", primaryMuscle: MuscleGroup.shoulders, level: Level.medium, goal: Goal.gainMuscle, equipment: Equipment.dumbbells),
        Exercise(name: "Bicepsz hajlítás", desc: "A bicepsz fejlesztésére.", primaryMuscle: MuscleGroup.biceps, level: Level.beginner, goal: Goal.gainMuscle, equipment: Equipment.dumbbells),
        Exercise(name: "Tricepsz lenyomás", desc: "A tricepsz fejlesztésére.", primaryMuscle: MuscleGroup.triceps, level: Level.beginner, goal: Goal.gainMuscle, equipment: Equipment.gym),
        Exercise(name: "Guggolás", desc: "Összetett gyakorlat a lábakra és a törzsre.", primaryMuscle: MuscleGroup.legs, level: Level.medium, goal: Goal.strength, equipment: Equipment.bodyWeight),
        Exercise(name: "Felülés", desc: "A hasizmok erősítésére.", primaryMuscle: MuscleGroup.abs, level: Level.beginner, goal: Goal.loseWeight, equipment: Equipment.bodyWeight),
        Exercise(name: "Futás", desc: "Kardió gyakorlat a szív- és érrendszer egészségéért.", primaryMuscle: MuscleGroup.cardio, level: Level.beginner, goal: Goal.loseWeight, equipment: Equipment.gym)
    ]
}
