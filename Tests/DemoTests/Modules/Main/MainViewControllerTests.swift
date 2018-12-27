// Created by Cihat Gündüz on 08.11.17.

import FBSnapshotTestCase
import Imperio
@testable import Imperio_Demo
import UIKit

class MainViewControllerTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testWhiteBackgroundWithEmptyImage() {
        let mainViewCtrl = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? MainViewController
        mainViewCtrl?.viewModel = MainViewModel(backgroundColor: .white, pickedImage: ObservableProperty(nil))
        FBSnapshotVerifyView(mainViewCtrl!.view)
    }

    func testRedBackgroundWithHogwartsImage() {
        let mainViewCtrl = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? MainViewController
        let pickedImage = UIImage(named: "hogwarts", in: Bundle(for: MainViewControllerTests.self), compatibleWith: nil)!
        mainViewCtrl?.viewModel = MainViewModel(backgroundColor: .red, pickedImage: ObservableProperty(pickedImage))
        FBSnapshotVerifyView(mainViewCtrl!.view)
    }
}
