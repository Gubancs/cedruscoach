//
//  cedruscoachApp.swift
//  cedruscoach
//
//  Created by Gabor Kokeny on 07/12/2024.
//

import SwiftUI
import SwiftData

@main
struct cedruscoachApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Trainee.self,
            Exercise.self,
            Workout.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
        .modelContainer(sharedModelContainer)
    }
}
