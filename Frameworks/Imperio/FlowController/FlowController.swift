//  Copyright © 2017 Flinesoft. All rights reserved.

import UIKit

/// A class to be subclassed by flow controllers.
open class FlowController: NSObject, SubFlowControllable {
    var subFlowControllers: [SubFlowControllable] = []
    weak var superFlowController: SubFlowControllable?

    /// Starts the flow from a given view controller.
    ///
    /// - Parameters:
    ///   - presentingViewController: The view controller to start the flow from.
    open func start(from presentingViewController: UIViewController) { /* override-only */ }
}
