// Created by Cihat Gündüz on 27.12.18.

import Foundation

/// An object storing references to the releated flow controllers.
final class FlowHierarchy {
    class Node {
        let flowController: SubFlowControllable

        let parent: Node?
        var children: [Node] = []

        init(flowController: SubFlowControllable, parent: Node?) {
            self.flowController = flowController
            self.parent = parent
        }
    }

    static let shared = FlowHierarchy()

    var rootNode: Node?
    var lastAddedNode: Node?

    func add(subFlowController: SubFlowControllable, to parentFlowController: SubFlowControllable) {
        if rootNode == nil {
            rootNode = Node(flowController: parentFlowController, parent: nil)
        }

        if let node = findNode(flowController: parentFlowController) {
            let child = Node(flowController: subFlowController, parent: node)
            node.children.append(child)

            lastAddedNode = child
        }
    }

    func remove(subFlowController: SubFlowControllable) {
        if let node = findNode(flowController: subFlowController) {
            node.parent?.children.removeAll { $0 === node }

            lastAddedNode = node.parent

            if rootNode === node {
                rootNode = nil
            }
        }
    }

    private func findNode(flowController: SubFlowControllable) -> Node? {
        guard let rootNode = rootNode else { return nil }
        guard lastAddedNode?.flowController !== flowController else { return lastAddedNode }
        guard lastAddedNode?.parent?.flowController !== flowController else { return lastAddedNode!.parent }
        guard rootNode.flowController !== flowController else { return rootNode }

        return find(flowController: flowController, in: rootNode.children)
    }

    private func find(flowController: SubFlowControllable, in subNodes: [Node]) -> Node? {
        for node in subNodes {
            if node.flowController === flowController {
                return node
            }

            if let foundNode = find(flowController: flowController, in: node.children) {
                return foundNode
            }
        }

        return nil
    }
}
