import Foundation
import SwiftData


@Model
class Workout {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var trainee: Trainee? // relationship
    var date: Date

    init(name: String, trainee: Trainee? = nil, date: Date = Date()) {
        self.name = name
        self.trainee = trainee
        self.date = date
    }
}
