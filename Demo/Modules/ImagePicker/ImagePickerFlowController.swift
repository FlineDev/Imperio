//
//  ImagePickerFlowController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

// NOTE: In this flow controller example the entire flow is handled right within the flow controller without creating any additional class.
// The reason for this is that UIImagePickerController and UIAlertController both already encapsulate the logic for rendering, animating etc.
// Therefore there is no need to create additional types like view controllers or view models to handle this flow.

class ImagePickerFlowController: FlowController {
    let resultCompletion: SafeResultClosure<UIImage>

    init(resultCompletion: SafeResultClosure<UIImage>) {
        self.resultCompletion = resultCompletion
        super.init()
    }

    override func start(from presentingViewController: UIViewController) {
        presentingViewController.present(instantiateSourceChooser(from: presentingViewController), animated: true)
    }

    func instantiateSourceChooser(from viewController: UIViewController) -> UIAlertController {
        let alertCtrl = UIAlertController(title: "Choose source.", message: "How do you want to choose your image?", preferredStyle: .actionSheet)

        alertCtrl.addAction(UIAlertAction(title: "Camera", style: .default) { [unowned self] _ in
            self.startCamera(from: viewController)
        })

        alertCtrl.addAction(UIAlertAction(title: "Albums", style: .default) { [unowned self] _ in
            self.startImagePicker(from: viewController)
        })

        alertCtrl.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [unowned self] _ in
            self.removeFromSuperFlowController()
        })

        return alertCtrl
    }

    func startCamera(from viewController: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera

        imagePicker.delegate = self
        viewController.present(imagePicker, animated: true)
    }

    func startImagePicker(from viewController: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum

        imagePicker.delegate = self
        viewController.present(imagePicker, animated: true)
    }
}

extension ImagePickerFlowController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.removeFromSuperFlowController()
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            resultCompletion.reportResult(result: pickedImage)
            picker.dismiss(animated: true) {
                self.removeFromSuperFlowController()
            }
        }
    }
}
