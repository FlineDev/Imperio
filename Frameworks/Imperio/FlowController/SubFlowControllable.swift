// Created by Cihat Gündüz on 27.12.18.

import Foundation

public protocol SubFlowControllable: class {
    /// Adds a sub flow controller to the existing one.
    ///
    /// - Parameters:
    ///   - subFlowController: The sub flow controller to be added.
    func add(subFlowController: SubFlowControllable)

    /// Removes this flow controller from its super flow controller.
    func removeFromSuperFlowController()
}

extension SubFlowControllable {
    /// Adds a sub flow controller to the existing one.
    ///
    /// - Parameters:
    ///   - subFlowController: The sub flow controller to be added.
    public func add(subFlowController: SubFlowControllable) {
        FlowHierarchy.shared.add(subFlowController: subFlowController, to: self)
    }

    /// Removes this flow controller from its super flow controller.
    public func removeFromSuperFlowController() {
        FlowHierarchy.shared.remove(subFlowController: self)
    }
}
