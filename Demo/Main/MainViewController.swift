//
//  MainViewController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

protocol MainFlowableDelegate: class {
    func tutorialStartButtonPressed()
    func imagePickerStartButtonPressed()
}

class MainViewController: UIViewController, Flowable {
    // MARK: - Flowable Protocol Implementation
    typealias FlowDelegate = MainFlowableDelegate
    weak var flowDelegate: MainFlowableDelegate?

    // MARK: - Stored Instance Properties
    @IBOutlet var pickedImageView: UIImageView!

    // MARK: - Action Methods
    @IBAction func tutorialStartButtonPressed() {
        flowDelegate?.tutorialStartButtonPressed()
    }

    @IBAction func imagePickerStartButtonPressed() {
        flowDelegate?.imagePickerStartButtonPressed()
    }
}
