//
//  FlowController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

/// A class to be subclassed by flow controllers.
open class FlowController: NSObject {
    var subFlowController: FlowController?
    weak var superFlowController: FlowController?

    /// Starts the flow from a given view controller.
    ///
    /// - Parameters:
    ///   - presentingViewController: The view controller to start the flow from.
    open func start(from presentingViewController: UIViewController) { }

    /// Adds a sub flow controller to the existing one.
    ///
    /// - Parameters:
    ///   - subFlowController: The sub flow controller to be added.
    public func add(subFlowController: FlowController) {
        // Clean up
        self.subFlowController?.removeFromSuperFlowController()
        subFlowController.removeFromSuperFlowController()

        // Store new
        self.subFlowController = subFlowController
        subFlowController.superFlowController = self
    }

    /// Removes this flow controller from its super flow controller.
    public func removeFromSuperFlowController() {
        subFlowController?.removeFromSuperFlowController()
        superFlowController?.subFlowController = nil
        superFlowController = nil
    }
}
