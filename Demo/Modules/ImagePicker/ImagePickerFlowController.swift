//
//  ImagePickerFlowController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

class ImagePickerFlowController: FlowController {
    typealias ResultClosure = (UIImage) -> Void

    let resultCompletion: ResultClosure

    init(resultCompletion: @escaping ResultClosure) {
        self.resultCompletion = resultCompletion
        super.init()
    }

    override func start(from viewController: UIViewController) {
        viewController.present(instantiateSourceChooser(from: viewController), animated: true, completion: nil)
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
        viewController.present(imagePicker, animated: true, completion: nil)
    }

    func startImagePicker(from viewController: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum

        imagePicker.delegate = self
        viewController.present(imagePicker, animated: true, completion: nil)
    }
}

extension ImagePickerFlowController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.removeFromSuperFlowController()
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            resultCompletion(pickedImage)
            picker.dismiss(animated: true) {
                self.removeFromSuperFlowController()
            }
        }
    }
}
