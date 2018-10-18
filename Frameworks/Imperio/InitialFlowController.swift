//
//  InitialFlowController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

/// A class to be subclassed by the flow controller which is opened first from the app delegate.
open class InitialFlowController: FlowController {
    /// Starts a flow controller as initial flow from the given window.
    ///
    /// - Paramters:
    ///   - window: The window to present the flow from.
    open func start(from window: UIWindow) { /* needs to be overridden */ }
}
