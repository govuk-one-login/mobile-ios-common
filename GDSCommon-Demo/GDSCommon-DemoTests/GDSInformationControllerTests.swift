import GDSCommon
import XCTest

final class GDSInformationViewControllerTests: XCTestCase {
    var viewModel: GDSInformationViewModel!
    var sut: GDSInformationViewController!
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
        sut = GDSInformationViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestViewModel: GDSInformationViewModel, BaseViewModel {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = .semibold
    let imageColour: UIColor? = .gdsPrimary
    let imageHeightConstraint: CGFloat? = 55
    let title: GDSLocalisedString = "Information screen title"
    let body: GDSLocalisedString? = "Information screen body"
    let footnote: GDSLocalisedString? = "Information screen footnote"
    let primaryButtonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let backButtonIsHidden: Bool = false
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    init(primaryButtonAction: @escaping () -> Void,
         secondaryButtonAction: @escaping () -> Void,
         appearAction: @escaping () -> Void,
         dismissAction: @escaping () -> Void) {
        primaryButtonViewModel = MockButtonViewModel(title: "Information primary button title") {
            primaryButtonAction()
        }
        secondaryButtonViewModel = MockButtonViewModel(title: "Information secondary button title") {
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

extension GDSInformationViewControllerTests {
    func test_labelContents() throws {
        XCTAssertNotNil(try sut.informationImage)
        XCTAssertEqual(try sut.informationImage.tintColor, .gdsPrimary)
        XCTAssertEqual(try sut.informationTitleLabel.text, "Information screen title")
        XCTAssertEqual(try sut.informationTitleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.informationTitleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.informationBodyLabel.text, "Information screen body")
        XCTAssertFalse(try sut.informationBodyLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.informationFootnoteLabel.text, "Information screen footnote")
        XCTAssertEqual(try sut.informationFootnoteLabel.font, .footnote)
        XCTAssertEqual(try sut.informationFootnoteLabel.maximumContentSizeCategory, .accessibilityMedium)
        XCTAssertFalse(try sut.informationFootnoteLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.informationPrimaryButton.title(for: .normal), "Information primary button title")
        XCTAssertEqual(try sut.informationSecondaryButton.title(for: .normal), "Information secondary button title")
    }
    
    func test_primaryButtonAction() throws {
        XCTAssertFalse(primaryButton)
        try sut.informationPrimaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(primaryButton)
    }
    
    func test_secondaryButtonAction() throws {
        XCTAssertFalse(secondaryButton)
        try sut.informationSecondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(secondaryButton)
    }
    
    func test_didAppear() throws {
        XCTAssertFalse(viewDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(viewDidAppear)
    }
    
    func testVoiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "Information screen title")
    }
    
    func test_didDismiss() {
        XCTAssertFalse(viewDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(viewDidAppear)
        
        XCTAssertFalse(viewDidDismiss)
        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(viewDidDismiss)
    }
}

extension GDSInformationViewController {
    var informationImage: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "information-image"])
        }
    }
    
    var informationTitleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "information-title"])
        }
    }
    
    var informationBodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "information-body"])
        }
    }
    
    var informationFootnoteLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "information-footnote"])
        }
    }
    
    var informationPrimaryButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "information-primary-button"])
        }
    }
    
    var informationSecondaryButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "information-secondary-button"])
        }
    }
}
     
