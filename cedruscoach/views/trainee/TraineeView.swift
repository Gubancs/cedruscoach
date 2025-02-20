import SwiftUI
import UIKit

struct TraineeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var viewModel = TraineeFormViewModel()
    @State private var profileImage: UIImage?
    @State private var showingImagePicker = false
    
    
    init(trainee: Trainee? = nil) {
        _viewModel = ObservedObject(wrappedValue: TraineeFormViewModel(trainee: trainee))
    }

    var body: some View {
        Form {
            profileSection()
            basicInfoSection()
            bodyDataSection()
            otherSection()
        }
        .navigationTitle(viewModel.id != nil ? "Ügyfél módosítása" : "Új Ügyfél")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Mégse") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Mentés") {
                    viewModel.validateForm()
                    if viewModel.isValid {
                        viewModel.saveTrainee(context: modelContext, profileImage: profileImage)
                        dismiss()
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func profileSection() -> some View {
        Section(header: Text("Profilkép")) {
            VStack(alignment: .center) { // Középre igazítás
                if let profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray) // Szürke szín
                    }

                Button {
                    showingImagePicker = true
                } label: {
                    HStack {
                        Text("Fotó készítése")
                        Image(systemName: "camera") // Kamera ikon
                    }
                }.sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $profileImage)
                }
            } // VStack vége
            .frame(maxWidth: .infinity, alignment: .center) // Szélesség kitöltése és középre igazítás
        }
    }

    @ViewBuilder
    private func basicInfoSection() -> some View {
        Section(header: Text("Alap adatok")) {
            Group {
                VStack(alignment: .leading) { // Név validáció
                    Text("Név").font(.caption)
                    TextField("Ügyfél teljes neve", text: $viewModel.name)
                    if viewModel.isNameInvalid {
                        Text("Név megadása kötelező")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                VStack(alignment: .leading) { // Email validáció
                    Text("Email").font(.caption)
                    TextField("Érvényes e-mail cím", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .overlay(alignment: .trailing) {  // Error icon
                            if viewModel.isEmailInvalid {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundColor(.red)
                                    .padding(.trailing, 5)
                            }
                        }
                    if viewModel.isEmailInvalid {
                        Text("Érvénytelen e-mail formátum")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            
                VStack(alignment: .leading) {
                    Text("Telefonszám").font(.caption)
                    TextField("+36330123456", text: $viewModel.phoneNumber)
                        .keyboardType(.phonePad)
                }

                VStack(alignment: .leading){
                    HStack(alignment: .center) { // Születési dátum validáció
                        Text("Születési dátum").font(.caption)
                        DatePicker(
                            "",
                            selection: $viewModel.birthDate,
                            in: Date().dateRange, // Dátum korlátozás
                            displayedComponents: .date
                        )
                    }
                    
                    if viewModel.isBirthDateInvalid {
                        Text("Születési dátum 5 és 100 év között kell legyen")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func bodyDataSection() -> some View {
        Section(header: Text("Testi adatok")) {
            Group {
                VStack(alignment: .leading) { // Magasság validáció
                    Text("Magasság").font(.caption)
                    TextField("Magasság (cm)", text: $viewModel.height)
                        .keyboardType(.decimalPad)
                    if viewModel.isHeightInvalid {
                        Text("A magasság 120 és 220 cm között kell legyen")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                VStack(alignment: .leading) { // Kezdő súly validáció
                    Text("Test súly").font(.caption)
                    TextField("Kezdő test súly (kg)", text: $viewModel.startingWeight)
                        .keyboardType(.decimalPad)
                    if viewModel.isWeightInvalid {
                        Text("A kezdő test súly 40 és 200 kg között kell legyen")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func otherSection() -> some View {
        Section(header: Text("Egyéb")) {
            Text("Jegyzetek:").font(.caption)
            TextEditor(text: $viewModel.notes)
                .frame(height: 100)
        }
    }

    
}

#Preview {
    TraineeView()
        .modelContainer(for: [Trainee.self], inMemory: true)
}

