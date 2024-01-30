import GDSCommon
import XCTest

final class GDSErrorViewControllerTests: XCTestCase {
    var viewModel: GDSErrorViewModel!
    var sut: GDSErrorViewController!
    var primaryButton = false
    var secondaryButton = false
    var viewDidAppear = false
    var viewDidDismiss = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = TestViewModel {
            self.primaryButton = true
        } secondaryButtonAction: {
            self.secondaryButton = true
        } appearAction: {
            self.viewDidAppear = true
        } dismissAction: {
            self.viewDidDismiss = true
        }
        sut = GDSErrorViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestViewModel: GDSErrorViewModel, BaseViewModel {
    let image: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "Error screen title"
    let body: GDSLocalisedString = "Error screen body"
    let primaryButtonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?

    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let backButtonIsHidden: Bool = false
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    init(primaryButtonAction: @escaping () -> Void,
         secondaryButtonAction: @escaping () -> Void,
         appearAction: @escaping () -> Void,
         dismissAction: @escaping () -> Void
    ) {
        primaryButtonViewModel = MockButtonViewModel(title: "Error primary button title") {
            primaryButtonAction()
        }
        secondaryButtonViewModel = MockButtonViewModel(title: "Error secondary button title") {
            secondaryButtonAction()
        }
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

extension GDSErrorViewControllerTests {
    func test_labelContents() throws {
        XCTAssertNotNil(try sut.errorImage)
        XCTAssertEqual(try sut.errorTitleLabel.text, "Error screen title")
        XCTAssertEqual(try sut.errorTitleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.errorTitleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.errorBodyLabel.text, "Error screen body")
        XCTAssertFalse(try sut.errorBodyLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.errorPrimaryButton.title(for: .normal), "Error primary button title")
        XCTAssertEqual(try sut.errorSecondaryButton.title(for: .normal), "Error secondary button title")
    }
    
    func test_primaryButtonAction() throws {
        XCTAssertFalse(primaryButton)
        try sut.errorPrimaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(primaryButton)
    }
    
    func test_secondaryButtonAction() throws {
        XCTAssertFalse(secondaryButton)
        try sut.errorSecondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(secondaryButton)
    }
    
    func test_didAppear() throws {
        XCTAssertFalse(viewDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        XCTAssertTrue(viewDidAppear)
    }
    
    func test_voiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "Error screen title")
    }
    
    func test_didDismiss() {
        XCTAssertFalse(viewDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        XCTAssertTrue(viewDidAppear)
        
        XCTAssertFalse(viewDidDismiss)
        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(viewDidDismiss)
    }
}

extension GDSErrorViewController {
    var errorImage: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "error-image"])
        }
    }
    
    var errorTitleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "error-title"])
        }
    }
    
    var errorBodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "error-body"])
        }
    }
    
    var errorPrimaryButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "error-primary-button"])
        }
    }
    
    var errorSecondaryButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "error-secondary-button"])
        }
    }
}
