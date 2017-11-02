//
//  Page1ViewController.swift
//  Imperio-Demo
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

protocol Page1FlowDelegate: class {
    func nextToPage2ButtonPressed()
}

class Page1ViewController: UIViewController, Flowable {
    typealias FlowDelegate = Page1FlowDelegate

    weak var flowDelegate: Page1FlowDelegate?

    @IBAction func nextButtonPressed() {
        flowDelegate?.nextToPage2ButtonPressed()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Page 1"
    }
}
