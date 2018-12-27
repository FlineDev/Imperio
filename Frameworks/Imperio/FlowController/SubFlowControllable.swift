// Created by Cihat Gündüz on 27.12.18.

import Foundation

protocol SubFlowControllable: class {
    var subFlowControllers: [SubFlowControllable] { get set }
    var superFlowController: SubFlowControllable? { get set }

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
        subFlowControllers.append(subFlowController)
        subFlowController.superFlowController = self
    }

    /// Removes this flow controller from its super flow controller.
    public func removeFromSuperFlowController() {
        subFlowControllers.forEach { $0.removeFromSuperFlowController() }
        superFlowController!.subFlowControllers.removeAll { $0 === self }
        superFlowController = nil
    }
}
