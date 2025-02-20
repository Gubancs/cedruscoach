import SwiftUI
import Combine
import SwiftData

class TraineeFormViewModel: ObservableObject {
    @Published var id: UUID? = nil // Új ID
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var birthDate: Date = Date()
    @Published var notes: String = ""
    @Published var height: String = ""
    @Published var startingWeight: String = ""
    @Published var selectedGender: Gender = .male

    @Published var isNameInvalid: Bool = false
    @Published var isEmailInvalid: Bool = false
    @Published var isHeightInvalid: Bool = false
    @Published var isWeightInvalid: Bool = false
    @Published var isBirthDateInvalid: Bool = false
    @Published var isGenderInvalid: Bool = false

    init(trainee: Trainee? = nil) {
        if let trainee = trainee {
            self.id = trainee.id // Beállítjuk az ID-t
            self.name = trainee.name
            self.email = trainee.email
            self.phoneNumber = trainee.phoneNumber ?? ""
            self.birthDate = trainee.birthDate ?? Date()
            self.notes = trainee.notes ?? ""
            self.height = String(trainee.height ?? 0)
            self.startingWeight = String(trainee.startingWeight ?? 0)
            self.selectedGender = Gender(rawValue: trainee.gender) ?? .male
        }
    }
    
    var isValid: Bool {
        return !isNameInvalid && !isEmailInvalid && !isHeightInvalid && !isWeightInvalid && !isBirthDateInvalid && !isGenderInvalid
    }

    func validateForm() {
        isNameInvalid = name.isEmpty
        isEmailInvalid = !isValidEmail(email)
        isHeightInvalid = !isValidHeight(height) && !height.isEmpty
        isWeightInvalid = !isValidWeight(startingWeight) && !startingWeight.isEmpty
        isBirthDateInvalid = !birthDate.isWithinAgeRange(minYears: 5, maxYears: 100)
        isGenderInvalid = selectedGender == .other
    }

    // Validációs függvények
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidHeight(_ height: String) -> Bool {
        guard let heightValue = Double(height) else { return false }
        return heightValue >= 120 && heightValue <= 220
    }

    func isValidWeight(_ weight: String) -> Bool {
        guard let weightValue = Double(weight) else { return false }
        return weightValue >= 40 && weightValue <= 200
    }
    
// Adatbázis művelet
    func saveTrainee(context: ModelContext, profileImage: UIImage?) {
        let heightValue = Int(height) ?? 0
        let weightValue = Double(startingWeight) ?? 0

        var imageData: Data? = nil
        if let profileImage = profileImage {
            imageData = profileImage.jpegData(compressionQuality: 0.8)
        }

        if let traineeId = id {
            // Meglévő Trainee frissítése
            do {
                let existingTrainee = try context.fetch(FetchDescriptor<Trainee>(predicate: #Predicate { $0.id == traineeId })).first!
                existingTrainee.name = name
                existingTrainee.email = email
                existingTrainee.gender = selectedGender.rawValue
                existingTrainee.birthDate = birthDate
                existingTrainee.height = heightValue
                existingTrainee.startingWeight = weightValue
                existingTrainee.phoneNumber = phoneNumber.isEmpty ? nil : phoneNumber
                existingTrainee.notes = notes.isEmpty ? nil : notes
                existingTrainee.profileImageData = imageData
                
                try context.save()
                print("Trainee sikeresen frissítve!")

            } catch {
                print("Hiba a Trainee frissítésekor: \(error)")
            }
        } else {
            // Új Trainee létrehozása
            let newTrainee = Trainee(
                name: name,
                email: email,
                gender: selectedGender.rawValue,
                birthDate: birthDate,
                height: heightValue,
                startingWeight: weightValue,
                phoneNumber: phoneNumber.isEmpty ? nil : phoneNumber,
                notes: notes.isEmpty ? nil : notes,
                profileImageData: imageData
            )
            context.insert(newTrainee)
            do {
                try context.save()
                print("Trainee sikeresen mentve!")
            } catch {
                print("Hiba a Trainee mentésekor: \(error)")
            }
        }
    }
}
