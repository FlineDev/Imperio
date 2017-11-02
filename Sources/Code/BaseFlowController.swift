//
//  BaseFlowController.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

/// An internal class to share code between subclasses. Don't subclass! Subclass FlowController instead.
open class BaseFlowController: NSObject {
    var subFlowController: FlowController?

    /// Adds a sub flow controller to the existing one.
    ///
    /// - Parameters:
    ///   - subFlowController: The sub flow controller to be added.
    public func add(subFlowController: FlowController) {
        self.subFlowController?.removeFromSuperFlowController()
        subFlowController.removeFromSuperFlowController()

        self.subFlowController = subFlowController
        subFlowController.superFlowController = self
    }
}
