//
//  ImagePicker.swift
//  cedruscoach
//
//  Created by Gabor Kokeny on 16/02/2025.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = ImagePickerViewController

    @Binding var image: UIImage?
    @Environment(\.dismiss) var dismiss // Sheet bezárásához

    func makeUIViewController(context: Context) -> ImagePickerViewController {
        let viewController = ImagePickerViewController()
        viewController.completionHandler = { selectedImage in
            image = selectedImage // Kép átadása a binding változónak
            dismiss()  // Sheet bezárása
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: ImagePickerViewController, context: Context) {
        // Nem szükséges implementálni ebben az esetben
    }
}
