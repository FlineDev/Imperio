//  Copyright © 2017 Flinesoft. All rights reserved.

import UIKit

/// A class to be subclassed by flow controllers.
open class FlowController: NSObject {
    private var subFlowController: FlowController?

    private(set) weak var parent: FlowController?
    private(set) var children: [FlowController] = []

    /// Starts the flow from a given view controller.
    ///
    /// - Parameters:
    ///   - presentingViewController: The view controller to start the flow from.
    open func start(from presentingViewController: UIViewController) { /* for overriding purposes only */ }

    /// Override this to perform logic before the flow controller will change its parent.
    open func willMove(toParent: FlowController?) { /* for overriding purposes only */ }

    /// Override this to perform logic after the flow controller did change its parent.
    open func didMove(toParent: FlowController?) { /* for overriding purposes only */ }

    /// Adds a flow controller to the children of this flow controller
    ///
    /// - Parameters:
    ///     - child: The flow controller to be added as child.
    public func addChild(_ child: FlowController) {
        precondition(child.parent == nil)

        child.willMove(toParent: self)
        child.parent = self
        children.append(child)
        child.didMove(toParent: self)
    }

    /// Moves the flow controller from its current parent to the new parent.
    ///
    /// - Parameters:
    ///     - toParent: The parent the flow controller will be moved to.
    public func move(toParent: FlowController) {
        removeFromParent()
        toParent.addChild(self)
    }

    /// Removes the flow controller from its parent.
    public func removeFromParent() {
        parent?.removeChildren(in: [self])
    }

    /// Remove all child flow controllers.
    public func removeAllChildren() {
        removeChildren(in: children)
    }

    /// Removes all child flow controllers in `childrenToRemove`.
    ///
    /// - Parameters:
    ///     - childrenToRemove: The children which will be removed from the flow controller.
    public func removeChildren(in childrenToRemove: [FlowController]) {
        childrenToRemove.forEach(removeChild(_:))
    }

    /// Removes the given `child` from the flow controller.
    ///
    /// - Parameters:
    ///     - child: The child which will be removed from the flow controller.
    public func removeChild(_ child: FlowController) {
        precondition(child.parent == self)

        child.willMove(toParent: nil)
        child.parent = nil
        children.removeAll { $0 === child }
        child.didMove(toParent: nil)
    }

    /// Adds a sub flow controller to the existing one.
    ///
    /// - Parameters:
    ///   - subFlowController: The sub flow controller to be added.
    @available(*, deprecated, message: "`add(subFlowController:)` is deprecated use `addChild(_:)` instead!")
    public func add(subFlowController: FlowController) {
        addChild(subFlowController)
    }

    /// Removes this flow controller from its super flow controller.
    @available(*, deprecated, message: "`removeFromSuperFlowController` is deprecated use `removeFromParent` instead!")
    public func removeFromSuperFlowController() {
        removeFromParent()
    }
}
