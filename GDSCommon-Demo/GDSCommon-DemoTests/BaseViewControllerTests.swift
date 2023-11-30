@testable import GDSCommon
import GDSCommon_Demo
import XCTest

final class BaseViewControllerTests: XCTestCase {
    var viewModel: BaseViewModel!
    var sut: BaseViewController!
    var didAppear: Bool!
    var didDismiss: Bool!
    
    override func setUp() {
        super.setUp()
        didAppear = false
        didDismiss = false
        viewModel = MockBaseViewModel {
            self.didAppear = true
        } dismissAction: {
            self.didDismiss = true
        }
        sut = BaseViewController(viewModel: viewModel, nibName: "MockBase", bundle: .init(for: BaseViewControllerTests.self))
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

extension BaseViewControllerTests {
    func test_labelContents() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        let rightBarButton: UIBarButtonItem = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(rightBarButton.title, "right bar button")
    }
    
    func test_didAppear() {
        XCTAssertFalse(didAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        XCTAssertTrue(didAppear)
    }
    
    func test_didDismiss() {
        XCTAssertFalse(didAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        XCTAssertTrue(didAppear)
        
        XCTAssertFalse(didDismiss)
        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(didDismiss)
    }
}
