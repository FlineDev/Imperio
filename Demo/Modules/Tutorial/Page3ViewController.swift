//
//  Page3ViewController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

protocol Page3FlowDelegate: class {
    func completeButtonPressed()
}

class Page3ViewController: UIViewController {
    weak var flowDelegate: Page3FlowDelegate?

    @IBAction func completeButtonPressed() {
        flowDelegate?.completeButtonPressed()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Page 3"
    }
}
