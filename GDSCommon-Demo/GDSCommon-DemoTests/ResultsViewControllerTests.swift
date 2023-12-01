import GDSCommon
import XCTest

final class ResultsViewControllerTests: XCTestCase {
    var viewModel: ResultsViewModel!
    var sut: ResultsViewController!
    
    var screenDidAppear = false
    var screenDidDismiss = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = TestViewModel {
            self.screenDidAppear = true
        } dismissAction: {
            self.screenDidDismiss = true
        }
        
        sut = ResultsViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestViewModel: ResultsViewModel, BaseViewModel {
    let image: String = "checkmark.circle"
    let title: GDSLocalisedString = "Results title"
    let body: GDSLocalisedString? = "Results body"
    let resultsButtonViewModel: ButtonViewModel
    var rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    var backButtonIsHidden: Bool = true
    
    let dismissAction: () -> Void
    let appearAction: () -> Void
    
    init(appearAction: @escaping () -> Void,
         dismissAction: @escaping () -> Void) {
        resultsButtonViewModel = MockButtonViewModel(title: "Results button title") { }
        self.appearAction = appearAction
        self.dismissAction = dismissAction
    }
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }
}

extension ResultsViewControllerTests {
    func testDidAppear() {
        XCTAssertFalse(screenDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(screenDidAppear)
    }
    
    func test_labelContents() throws {
        XCTAssertEqual(sut.viewModel.image, "checkmark.circle")
        XCTAssertEqual(try sut.titleLabel.text, "Results title")
        XCTAssertEqual(try sut.bodyLabel.text, "Results body")
        XCTAssertEqual(try sut.resultsButton.title(for: .normal), "Results button title")
    }
    
    func test_buttonAction() throws {
        XCTAssertFalse(screenDidDismiss)
        try sut.resultsButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(screenDidDismiss)
    }
}

extension ResultsViewController {
    var imageView: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "results-image"])
        }
    }
    
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "results-title"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "results-body"])
        }
    }
    
    var resultsButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "results-button"])
        }
    }
}
