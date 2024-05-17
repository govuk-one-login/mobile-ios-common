@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

final class GDSLoadingViewControllerTests: XCTestCase {
    
    var viewModel: MockGDSLoadingViewModel!
    var sut: GDSLoadingViewController!
    var didAppear: Bool!
    var didDismiss: Bool!

    override func setUp() {
        super.setUp()
        
        didAppear = false
        didDismiss = false
        
        viewModel = MockGDSLoadingViewModel(rightBarButtonTitle: "Cancel", loadingLabelKey: "Test key") {
            self.didAppear = true
        } dismissAction: {
            self.didDismiss = true
        }
        
        sut = .init(viewModel: viewModel)
    }

    override func tearDown() {
        viewModel = nil
        sut = nil
        didAppear = nil
        didDismiss = nil
        super.tearDown()
    }

    func testDidAppear() throws {
        XCTAssertFalse(didAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        sut.viewWillAppear(false)
        XCTAssertTrue(didAppear)
    }

    func test_didDismiss() {
        XCTAssertFalse(didAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(didAppear)
        
        XCTAssertFalse(didDismiss)
        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(didDismiss)
    }

    func test_loadingLabelIsSet() {
        XCTAssertEqual(try sut.loadingLabel.text, "Test key")
    }

}

extension GDSLoadingViewController {
    var loadingLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "loadingLabel"])
        }
    }
}
