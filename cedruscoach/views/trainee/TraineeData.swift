import SwiftUI
import UIKit

struct TraineeData {
    var fullName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var gender: String = Gender.male.rawValue // Default Gender
    var address: String = ""
    var birthDate: Date = Date() // Nem opcionális
    var height: String = ""
    var startingWeight: String = ""
}
