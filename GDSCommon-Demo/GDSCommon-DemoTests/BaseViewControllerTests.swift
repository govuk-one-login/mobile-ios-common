@testable import GDSCommon
import GDSCommon_Demo
import XCTest

final class BaseViewControllerTests: XCTestCase {
    var viewModel: BaseViewModel!
    var sut: BaseViewController!
    var didAppear: Bool!
    var didDismiss: Bool!
    
    @MainActor
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
        didAppear = nil
        didDismiss = nil
        
        super.tearDown()
    }
}

extension BaseViewControllerTests {
    @MainActor
    func test_labelContents() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        let rightBarButton: UIBarButtonItem = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(rightBarButton.title, "right bar button")
    }
    
    @MainActor
    func test_didAppear() {
        XCTAssertFalse(didAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(didAppear)
    }
    
    @MainActor
    func test_didDismiss() {
        XCTAssertFalse(didAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(didAppear)
        
        XCTAssertFalse(didDismiss)
        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(didDismiss)
    }
    
    @MainActor
    func test_rightBarButtonSetsAccessbilityIDOnViewLoad() {
        XCTAssertNil(sut.navigationItem.rightBarButtonItem?.accessibilityIdentifier)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.accessibilityIdentifier, "right-bar-button")
    }
}
