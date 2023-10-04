@testable import GDSCommon
import XCTest

final class DialogViewTests: XCTestCase {
    
    private var sut: DialogView<CheckmarkDialogAccessoryView>!
    private var viewController: UIViewController!
    private var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        sut = DialogView<CheckmarkDialogAccessoryView>(title: "Title", isLoading: false)
        viewController = .init()
        
        window = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    override func tearDown() {
        window = nil
        viewController = nil
        super.tearDown()
    }
    
    func test_viewsAreInstantiated() throws {
        let titleLabel: UILabel = try XCTUnwrap(sut[child: "titleLabel"])
        let contentView: UIView = try XCTUnwrap(sut[child: "contentView"])
        let accessoryView: UIView = try XCTUnwrap(sut[child: "accessoryView"])
        let accessoryViewContainer: UIView = try XCTUnwrap(sut[child: "accessoryViewContainer"])
        
        XCTAssertNotNil(contentView)
        XCTAssertNotNil(titleLabel)
        XCTAssertNotNil(accessoryViewContainer)
        XCTAssertNotNil(accessoryView)
    }
    
    func test_dialogViewPresentation() {
        let exp = expectation(description: "Removed from superview")
        sut.present(onView: viewController.view) {
            exp.fulfill()
        }
        XCTAssertEqual(sut.superview, viewController.view)
        XCTAssertNotNil(sut.completionHandler)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(sut.superview)
    }
    
    func test_dialogViewLabelValues() throws {
        let titleLabel: UILabel = try XCTUnwrap(sut[child: "titleLabel"])
        
        sut = DialogView<CheckmarkDialogAccessoryView>(title: "Title", isLoading: false)
        XCTAssertEqual(titleLabel.text, "Title")
    }
    
    func test_dialogView_compactStyle() throws {
        let titleLabel: UILabel = try XCTUnwrap(sut[child: "titleLabel"])
        
        sut = DialogView<CheckmarkDialogAccessoryView>(title: "Title", isLoading: false)
        XCTAssertEqual(titleLabel.textAlignment, .center)
    }
    
    func test_dialogView_asyncPresentation() {
        let exp = expectation(description: "Removed from superview")
        
        Task {
            await sut.present(onView: viewController.view)
            exp.fulfill()
        }
        
        waitForTruth(self.sut.superview == self.viewController.view,
                     timeout: 3)
        XCTAssertNotNil(sut.completionHandler)
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNil(sut.superview)
    }
    
    func test_dialogView_asdsfafgsyncPresentation() {
        let exp = expectation(description: "Removed from superview")
        
        Task {
            await sut.remove(view: viewController.view)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(sut.superview)
    }
    
//    func test_dialogView_asyncUpdateState() {
//        let exp = expectation(description: "Wait for update")
//        
//        Task {
//            await sut.updateState(isLoading: true,
//                                  newTitle: "Waiting for network",
//                                  view: viewController.view)
//            exp.fulfill()
//        }
//        
//        wait(for: [exp], timeout: 4)
//        XCTAssertTrue(sut.isLoading)
//    }
}
