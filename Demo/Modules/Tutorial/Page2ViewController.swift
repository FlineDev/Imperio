//
//  Page2ViewController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

protocol Page2FlowDelegate: class {
    func nextToPage3ButtonPressed()
}

class Page2ViewController: UIViewController, Flowable {
    typealias FlowDelegate = Page2FlowDelegate

    weak var flowDelegate: Page2FlowDelegate?

    @IBAction func nextButtonPressed() {
        flowDelegate?.nextToPage3ButtonPressed()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Page 2"
    }
}
