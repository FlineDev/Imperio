//  Copyright © 2017 Flinesoft. All rights reserved.

import UIKit
import Portus

/// A class to be subclassed by flow controllers.
open class FlowController: NSObject {
    var subFlowControllers: [FlowController] = []
    weak var superFlowController: FlowController?

    open class func make(info: Any?) -> Self {
        fatalError("Must be overridden by subclasses.")
    }

    /// Starts the flow from a given view controller.
    ///
    /// - Parameters:
    ///   - presentingViewController: The view controller to start the flow from.
    ///   - animated: Specifies if the starting process should be animated.
    ///   - completion: The closure to call when start completed, passing the current visible view controller.
    open func start(from presentingViewController: UIViewController, animated: Bool, completion: @escaping (UIViewController) -> Void) { /* needs to be overridden */ }

    /// Finishes the flow and calls completion once finished with success.
    ///
    ///
    /// - Paramters:
    ///   - animated: Specifies if the finishing process should be animated.
    ///   - completion: The closure to call when finish completed.
    open func finish(animated: Bool, completion: @escaping () -> Void) { /* needs to be overridden */ }

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

extension FlowController: PortKeyEnterable {
    public static func enter(from presentingViewController: UIViewController, info: Any?, animated: Bool, completion: @escaping (UIViewController) -> Void) {
        make(info: info).start(from: presentingViewController, animated: animated, completion: completion)
    }

    public func leave(animated: Bool, completion: @escaping () -> Void) {
        finish(animated: animated, completion: completion)
    }
}
