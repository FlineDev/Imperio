//
//  AppCoordinator
//  Cruciverber
//
//  Created by Cihat Gündüz on 12.03.16.
//  Copyright © 2016 Flinesoft. All rights reserved.
//

import UIKit

/// This class is a coordinator for screen flows starting on app start / using windows.
open class AppCoordinator: Coordinator {
    // MARK: - Stored Instance Properties

    public let window = UIWindow(frame: UIScreen.main.bounds)


    // MARK: - Initializers

    /// Initializes a new AppCoordinator object and creates a window.
    public init() {
        let pseudoViewController = UIViewController()
        super.init(presentingViewController: pseudoViewController)
    }

    override init(presentingViewController: UIViewController) {
        preconditionFailure("illegal init call – use init() instead")
    }


    // MARK: - Instance Methods

    /// Presents the initial view controllers as the windows root view.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to be presented.
    public func presentInitialViewController(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
