// Created by Cihat Gündüz on 27.12.18.

import Portus
import UIKit

/// A class to be subclassed by the routable flow controller which is opened first from the app delegate.
public protocol RoutableInitialFlowController: SubFlowControllable, PortKeyEnterable {
    /// Creates a flow controller object using data in info object.
    ///
    /// - Parameters:
    ///   - info: The object including all data required to initialize a flow controller of this type.
    static func make(info: Any?) -> Self

    /// Starts a flow controller as initial flow from the given window.
    ///
    /// - Parameters:
    ///   - window: The window to present the flow from.
    ///   - animated: Specifies if the starting process should be animated.
    ///   - completion: The closure to call when start completed, passing the current visible view controller.
    func start(from window: UIWindow, animated: Bool, completion: @escaping (UIViewController) -> Void)
}

extension RoutableInitialFlowController { // swiftlint:disable missing_docs
    public static func enter(from presentingViewController: UIViewController, info: Any?, animated: Bool, completion: @escaping (UIViewController) -> Void) {
        make(info: info).start(from: UIApplication.shared.keyWindow!, animated: animated, completion: completion)
    }

    public func leave(animated: Bool, completion: @escaping () -> Void) {
        // no-op – the new initial flow controller is responsible for transitioning from one root view controller to other
        completion()
    }
} // swiftlint:enable missing_docs
