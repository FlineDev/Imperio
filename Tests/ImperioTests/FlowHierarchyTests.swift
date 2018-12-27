// Created by Cihat Gündüz on 27.12.18.

@testable import Imperio
import XCTest

// swiftlint:disable all
class TestFlowController: FlowController { func start(from presentingViewController: UIViewController) {} }
class TestInitialFlowController: InitialFlowController { func start(from window: UIWindow) {} }
// swiftlint:enable all

class FlowHierarchyTests: XCTestCase {
    func testComplexHierarchy() { // swiftlint:disable empty_count
        XCTAssertNil(FlowHierarchy.shared.rootNode)
        XCTAssertNil(FlowHierarchy.shared.lastAddedNode)

        let flowCtrl0 = TestInitialFlowController()
        let flowCtrl1A = TestFlowController()
        FlowHierarchy.shared.add(subFlowController: flowCtrl1A, to: flowCtrl0)

        XCTAssertTrue(FlowHierarchy.shared.rootNode?.flowController === flowCtrl0)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.flowController === flowCtrl1A)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.parent?.flowController === flowCtrl0)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children.count == 1)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].flowController === flowCtrl1A)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].children.count == 0)

        let flowCtrl1B = TestFlowController()
        FlowHierarchy.shared.add(subFlowController: flowCtrl1B, to: flowCtrl0)

        XCTAssertTrue(FlowHierarchy.shared.rootNode?.flowController === flowCtrl0)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.flowController === flowCtrl1B)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.parent?.flowController === flowCtrl0)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children.count == 2)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].flowController === flowCtrl1A)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].children.count == 0)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[1].flowController === flowCtrl1B)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[1].children.count == 0)

        let flowCtrl2A = TestFlowController()
        FlowHierarchy.shared.add(subFlowController: flowCtrl2A, to: flowCtrl1A)

        XCTAssertTrue(FlowHierarchy.shared.rootNode?.flowController === flowCtrl0)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.flowController === flowCtrl2A)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.parent?.flowController === flowCtrl1A)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children.count == 2)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].flowController === flowCtrl1A)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].children.count == 1)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].children[0].flowController === flowCtrl2A)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[1].flowController === flowCtrl1B)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[1].children.count == 0)

        FlowHierarchy.shared.remove(subFlowController: flowCtrl2A)

        XCTAssertTrue(FlowHierarchy.shared.rootNode?.flowController === flowCtrl0)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.flowController === flowCtrl1A)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.parent?.flowController === flowCtrl0)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children.count == 2)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].flowController === flowCtrl1A)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].children.count == 0)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[1].flowController === flowCtrl1B)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[1].children.count == 0)

        FlowHierarchy.shared.add(subFlowController: flowCtrl2A, to: flowCtrl1A)

        XCTAssertTrue(FlowHierarchy.shared.rootNode?.flowController === flowCtrl0)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.flowController === flowCtrl2A)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.parent?.flowController === flowCtrl1A)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children.count == 2)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].flowController === flowCtrl1A)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].children.count == 1)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].children[0].flowController === flowCtrl2A)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[1].flowController === flowCtrl1B)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[1].children.count == 0)

        FlowHierarchy.shared.remove(subFlowController: flowCtrl1A)

        XCTAssertTrue(FlowHierarchy.shared.rootNode?.flowController === flowCtrl0)
        XCTAssertTrue(FlowHierarchy.shared.lastAddedNode?.flowController === flowCtrl0)
        XCTAssertNil(FlowHierarchy.shared.lastAddedNode?.parent)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children.count == 1)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].flowController === flowCtrl1B)
        XCTAssertTrue(FlowHierarchy.shared.rootNode?.children[0].children.count == 0)

        FlowHierarchy.shared.remove(subFlowController: flowCtrl0)

        XCTAssertNil(FlowHierarchy.shared.rootNode)
        XCTAssertNil(FlowHierarchy.shared.lastAddedNode)
    } // swiftlint:enable empty_count
}
