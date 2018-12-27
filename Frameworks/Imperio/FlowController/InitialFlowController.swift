// Created by Cihat Gündüz on 18.10.18.

import UIKit

/// A class to be subclassed by the flow controller which is opened first from the app delegate.
public protocol InitialFlowController: SubFlowControllable {
    /// Starts a flow controller as initial flow from the given window.
    ///
    /// - Parameters:
    ///   - window: The window to present the flow from.
    func start(from window: UIWindow)
}
