//  Copyright © 2017 Flinesoft. All rights reserved.

import UIKit

/// A class to be subclassed by flow controllers.
open class FlowController: NSObject {
    var subFlowControllers: [FlowController] = []
    weak var superFlowController: FlowController?

    /// Starts the flow from a given view controller.
    ///
    /// - Parameters:
    ///   - presentingViewController: The view controller to start the flow from.
    open func start(from presentingViewController: UIViewController) { /* for overriding purposes only */ }

    /// Adds a sub flow controller to the existing one.
    ///
    /// - Parameters:
    ///   - subFlowController: The sub flow controller to be added.
    public func add(subFlowController: FlowController) {
        subFlowControllers.append(subFlowController)
        subFlowController.superFlowController = self
    }

    /// Removes this flow controller from its super flow controller.
    public func removeFromSuperFlowController() {
        subFlowControllers.forEach { $0.removeFromSuperFlowController() }
        superFlowController!.subFlowControllers.removeAll { $0 == self }
        superFlowController = nil
    }
}
