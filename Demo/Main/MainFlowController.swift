//
//  MainFlowController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

class MainFlowController: InitialFlowController {
    var mainViewController: MainViewController?

    override func start(from window: UIWindow) {
        mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? MainViewController
        mainViewController?.flowDelegate = self
        window.rootViewController = mainViewController
    }
}

extension MainFlowController: MainFlowableDelegate {
    func tutorialStartButtonPressed() {
        let tutorialFlowCtrl = TutorialFlowController()
        add(subFlowController: tutorialFlowCtrl)
        tutorialFlowCtrl.start(from: mainViewController!)
    }

    func imagePickerStartButtonPressed() {
        let imagePickerFlowCtrl = ImagePickerFlowController { [unowned self] pickedImage in
            self.mainViewController?.pickedImageView.image = pickedImage
        }

        add(subFlowController: imagePickerFlowCtrl)
        imagePickerFlowCtrl.start(from: mainViewController!)
    }
}
