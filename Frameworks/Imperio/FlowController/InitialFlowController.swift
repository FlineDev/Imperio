//  Copyright © 2017 Flinesoft. All rights reserved.

import UIKit

/// A class to be subclassed by the flow controller which is opened first from the app delegate.
open class InitialFlowController: FlowController {
    /// Starts a flow controller as initial flow from the given window.
    ///
    /// - Parameters:
    ///   - window: The window to present the flow from.
    ///   - animated: Specifies if the starting process should be animated.
    ///   - completion: The closure to call when start completed, passing the current visible view controller.
    open func start(from window: UIWindow, animated: Bool, completion: @escaping (UIViewController) -> Void) { /* needs to be overridden */ }

    open override func finish(animated: Bool, completion: @escaping () -> Void) {
        fatalError("Can't finish an initial flow controller.")
    }
}
