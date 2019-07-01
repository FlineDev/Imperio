//  Copyright © 2017 Flinesoft. All rights reserved.

import UIKit

/// A class to be subclassed by the flow controller which is opened first from the app delegate.
open class InitialFlowController: FlowController {
    /// Starts a flow controller as initial flow from the given window.
    ///
    /// - Paramters:
    ///   - window: The window to present the flow from.
    open func start(from window: UIWindow) { /* needs to be overridden */ }

    @available(*, unavailable, message: "InitialFlowController can only be started from a UIWindow!")
    override open func start(from presentingViewController: UIViewController) {
        fatalError("InitialFlowController can only be started from a UIWindow!")
    }
}
