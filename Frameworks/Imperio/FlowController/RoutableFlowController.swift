// Created by Cihat Gündüz on 27.12.18.

import Portus
import UIKit

/// A class to be subclassed by routable flow controllers.
open class RoutableFlowController: NSObject, SubFlowControllable {
    var subFlowControllers: [SubFlowControllable] = []
    weak var superFlowController: SubFlowControllable?

    /// Creates a flow controller object using data in info object.
    ///
    /// - Parameters:
    ///   - info: The object including all data required to initialize a flow controller of this type.
    open class func make(info: Any?) -> Self {
        fatalError("Must be overridden by subclasses.")
    }

    /// Starts the flow from a given view controller.
    ///
    /// - Parameters:
    ///   - presentingViewController: The view controller to start the flow from.
    ///   - animated: Specifies if the starting process should be animated.
    ///   - completion: The closure to call when start completed, passing the current visible view controller.
    open func start(from presentingViewController: UIViewController, animated: Bool, completion: @escaping (UIViewController) -> Void) { /* override-only */ }

    /// Finishes the flow and calls completion once finished with success.
    ///
    ///
    /// - Paramters:
    ///   - animated: Specifies if the finishing process should be animated.
    ///   - completion: The closure to call when finish completed.
    open func finish(animated: Bool, completion: @escaping () -> Void) { /* override-only */ }
}

extension RoutableFlowController: PortKeyEnterable {
    public static func enter(from presentingViewController: UIViewController, info: Any?, animated: Bool, completion: @escaping (UIViewController) -> Void) {
        make(info: info).start(from: presentingViewController, animated: animated, completion: completion)
    }

    public func leave(animated: Bool, completion: @escaping () -> Void) {
        finish(animated: animated, completion: completion)
    }
}
