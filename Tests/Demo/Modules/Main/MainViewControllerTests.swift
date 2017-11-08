//
//  MainViewControllerTests.swift
//  Imperio
//
//  Created by Cihat Gündüz on 08.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Bond
import FBSnapshotTestCase
@testable import Imperio_Demo
import UIKit

class MainViewControllerTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testWhiteBackgroundWithEmptyImage() {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? MainViewController
        mainViewController?.viewModel = MainViewModel(backgroundColor: .white, pickedImage: Observable(nil))
        FBSnapshotVerifyView(mainViewController!.view)
    }

    func testRedBackgroundWithHogwartsImage() {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? MainViewController
        mainViewController?.viewModel = MainViewModel(backgroundColor: .red, pickedImage: Observable(#imageLiteral(resourceName: "hogwarts")))
        FBSnapshotVerifyView(mainViewController!.view)
    }
}
