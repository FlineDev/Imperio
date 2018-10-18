//
//  MainViewController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

protocol MainFlowDelegate: class {
    func tutorialStartButtonPressed()
    func imagePickerStartButtonPressed()
}

class MainViewController: UIViewController {
    weak var flowDelegate: MainFlowDelegate?
    var viewModel: MainViewModel?

    // MARK: - Stored Instance Properties
    @IBOutlet private var pickedImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = viewModel?.backgroundColor
        viewModel?.pickedImage.didSet(weak: self) { (self, pickedImage) in
            self.pickedImageView.image = pickedImage
        }
    }

    // MARK: - Action Methods
    @IBAction func tutorialStartButtonPressed() {
        flowDelegate?.tutorialStartButtonPressed()
    }

    @IBAction func imagePickerStartButtonPressed() {
        flowDelegate?.imagePickerStartButtonPressed()
    }
}
