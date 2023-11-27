import GDSCommon
import XCTest

final class ResultsViewControllerTests: XCTestCase {
    var viewModel: ResultsViewModel!
    var sut: ResultsViewController!
    
    var dismissAction = false
    var viewDidAppear = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = TestViewModel {
            self.dismissAction = true
        }
        sut = ResultsViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestViewModel: ResultsViewModel {
    let image: String = "checkmark.circle"
    let title: GDSLocalisedString = "Results title"
    let body: GDSLocalisedString? = "Results body"
    let resultsButtonViewModel: ButtonViewModel
    let dismissAction: () -> Void
    
    init(dismissAction: @escaping () -> Void) {
        resultsButtonViewModel = MockButtonViewModel(title: "Results button title") {
            dismissAction()
        }
        self.dismissAction = dismissAction
    }
    
    func didAppear() { }
    
    func didDismiss() {
        dismissAction()
    }
}

extension ResultsViewControllerTests {
    func test_labelContents() throws {
        XCTAssertEqual(sut.viewModel.image, "checkmark.circle")
        XCTAssertEqual(try sut.titleLabel.text, "Results title")
        XCTAssertEqual(try sut.bodyLabel.text, "Results body")
        XCTAssertEqual(try sut.resultsButton.title(for: .normal), "Results button title")
    }
    
    func test_buttonAction() throws {
        XCTAssertFalse(dismissAction)
        try sut.resultsButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(dismissAction)
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
