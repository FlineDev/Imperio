//
//  FlowController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

/// A class to be subclassed by flow controllers.
open class FlowController: BaseFlowController {
    weak var superFlowController: BaseFlowController?

    /// Starts the flow from a given view controller.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to start the flow from.
    open func start(from viewController: UIViewController) {}

    /// Removes this flow controller from its super flow controller.
    public func removeFromSuperFlowController() {
        superFlowController?.subFlowController = nil
        superFlowController = nil
    }
}
