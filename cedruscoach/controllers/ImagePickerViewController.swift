//
//  ImagePickerViewController.swift
//  cedruscoach
//
//  Created by Gabor Kokeny on 16/02/2025.
//

import UIKit
import SwiftUI

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var completionHandler: ((UIImage?) -> Void)? // Completion handler a kép visszaadásához
    private let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.sourceType = .camera // Kamera használata
        picker.allowsEditing = true  // Opcionális: Engedélyezi a kép szerkesztését
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {  // Szerkesztett kép
            completionHandler?(image)
        } else if let image = info[.originalImage] as? UIImage { // Eredeti kép
            completionHandler?(image)
        }
        picker.dismiss(animated: true)
        dismiss(animated: true) // Bezárja a SwiftUI sheet-et
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        dismiss(animated: true) // Bezárja a SwiftUI sheet-et
        completionHandler?(nil) // Completion handler meghívása nil értékkel
    }
}
