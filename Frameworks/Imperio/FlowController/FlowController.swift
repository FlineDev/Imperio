// Created by Cihat Gündüz on 18.10.18.

import UIKit

/// A class to be subclassed by flow controllers.
public protocol FlowController: SubFlowControllable {
    /// Starts the flow from a given view controller.
    ///
    /// - Parameters:
    ///   - presentingViewController: The view controller to start the flow from.
    func start(from presentingViewController: UIViewController)
}
