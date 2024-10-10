@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

final class GDSLoadingViewControllerTests: XCTestCase {
    var viewModel: MockGDSLoadingViewModel!
    var sut: GDSLoadingViewController!
    
    var didAppear = false
    var didDismiss = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
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
        
        didAppear = false
        didDismiss = false
        
        super.tearDown()
    }
    
    @MainActor
    func testDidAppear() throws {
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
