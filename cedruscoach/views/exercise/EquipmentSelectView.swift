import SwiftUI

struct EquipmentSelectView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedEquipment: Equipment

    var body: some View {
        NavigationView {
            List {
                ForEach(Equipment.allCases) { equipment in
                    Button {
                        selectedEquipment = equipment
                        dismiss() // Visszatérés az előző nézetbe
                    } label: {
                        HStack {
                            Text(equipment.rawValue)
                            Spacer()
                            if selectedEquipment == equipment {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .foregroundColor(.primary) // Szöveg színének beállítása
                }
            }
            .navigationTitle("Válassz eszközt")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Mégse") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct EquipmentSelectView_Preview: View {
    @State var selectedEquipment: Equipment = .gym // Kezdeti érték

    var body: some View {
        EquipmentSelectView(selectedEquipment: $selectedEquipment)
    }
}

#Preview {
    EquipmentSelectView_Preview()
}
