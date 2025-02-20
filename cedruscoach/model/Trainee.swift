import Foundation
import SwiftData
import UIKit

@Model
class Trainee: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var email: String
    var gender: String
    var birthDate: Date?
    var height: Int? // Módosítva Int-re
    var startingWeight: Double? // Marad Double
    var phoneNumber: String?
    var notes: String?
    var profileImageData: Data?

    init(name: String, email: String, gender: String, birthDate: Date? = nil, height: Int? = nil, startingWeight: Double? = nil, phoneNumber: String? = nil, notes: String? = nil, profileImageData: Data? = nil) {
        self.name = name
        self.email = email
        self.gender = gender
        self.birthDate = birthDate
        self.height = height
        self.startingWeight = startingWeight
        self.phoneNumber = phoneNumber
        self.notes = notes
        self.profileImageData = profileImageData
    }
}
