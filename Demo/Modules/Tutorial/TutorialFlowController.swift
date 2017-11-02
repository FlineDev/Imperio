//
//  TutorialFlowController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

class TutorialFlowController: FlowController {
    var navigationCtrl: UINavigationController?

    override func start(from viewController: UIViewController) {
        let page1ViewCtrl = Page1ViewController()
        navigationCtrl = UINavigationController(rootViewController: page1ViewCtrl)

        page1ViewCtrl.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(doneButtonPressed))
        page1ViewCtrl.flowDelegate = self

        viewController.present(navigationCtrl!, animated: true, completion: nil)
    }

    @objc
    func doneButtonPressed() {
        navigationCtrl?.dismiss(animated: true, completion: nil)
    }
}

extension TutorialFlowController: Page1FlowDelegate {
    func nextToPage2ButtonPressed() {
        let page2ViewCtrl = Page2ViewController()
        page2ViewCtrl.flowDelegate = self

        navigationCtrl?.pushViewController(page2ViewCtrl, animated: true)
    }
}

extension TutorialFlowController: Page2FlowDelegate {
    func nextToPage3ButtonPressed() {
        let page3ViewCtrl = Page3ViewController()
        page3ViewCtrl.flowDelegate = self

        navigationCtrl?.pushViewController(page3ViewCtrl, animated: true)
    }
}

extension TutorialFlowController: Page3FlowDelegate {
    func completeButtonPressed() {
        navigationCtrl?.dismiss(animated: true) {
            self.removeFromSuperFlowController()
        }
    }
}
