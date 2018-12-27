//  Copyright © 2017 Flinesoft. All rights reserved.

import UIKit

/// A class to be subclassed by the flow controller which is opened first from the app delegate.
open class InitialFlowController: NSObject, SubFlowControllable {
    var subFlowControllers: [SubFlowControllable] = []
    weak var superFlowController: SubFlowControllable?

    /// Starts a flow controller as initial flow from the given window.
    ///
    /// - Parameters:
    ///   - window: The window to present the flow from.
    open func start(from window: UIWindow) { /* override-only */ }
}
