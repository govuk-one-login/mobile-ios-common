@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

final class GDSErrorScreenTests: XCTestCase {
    var viewModel: GDSErrorViewModelV3!
    var sut: GDSErrorScreen!
    
    var buttonViewModels: [MockButtonViewModel] = []
    var secondaryButtonViewModel: MockButtonViewModel!
    var didTap_primaryButton = false
    var didTap_secondaryButton = false
    var didTap_tertiaryButton = false
    var viewDidAppear = false
    var viewDidDismiss = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        sut = createSUT()
    }
    
    // swiftlint: disable function_body_length
    @MainActor
    private func createSUT(
        image: ErrorScreenImage = .error,
        buttonsToAdd: Int = 3
    ) -> GDSErrorScreen {
        let primaryButtonViewModel = MockButtonViewModel(
            title: "Primary Action",
            icon: nil,
            shouldLoadOnTap: true,
            accessibilityHint: "Button hint",
            action: {
                self.didTap_primaryButton = true
            }
        )
        let secondaryButtonViewModel = MockButtonViewModel(
            title: "Secondary Action",
            icon: MockButtonIconViewModel(),
            shouldLoadOnTap: false,
            accessibilityHint: "Button hint",
            action: {
                self.didTap_secondaryButton = true
            }
        )
        
        let tertiaryButtonViewModel = MockButtonViewModel(
            title: "Tertiary Action",
            icon: MockButtonIconViewModel(),
            shouldLoadOnTap: false,
            accessibilityHint: "Button hint",
            action: {
                self.didTap_tertiaryButton = true
            }
        )
        
        switch buttonsToAdd {
        case 1:
            self.buttonViewModels = [
                primaryButtonViewModel
            ]
        case 2:
            self.buttonViewModels = [
                primaryButtonViewModel,
                secondaryButtonViewModel
            ]
        case 3:
            self.buttonViewModels = [
                primaryButtonViewModel,
                secondaryButtonViewModel,
                tertiaryButtonViewModel
            ]
            
        default:
            self.buttonViewModels = []
        }
        
        let viewModel = MockErrorViewModelV3(
            buttonViewModels: buttonViewModels,
            image: image,
            bodyContent: [
                singleLineRegular,
                singleParagraph,
                MockButtonViewModel(
                    title: "Button",
                    action: {}
                )
            ],
            appearAction: {
                self.viewDidAppear = true
            },
            dismissAction: {
                self.viewDidDismiss = true
            }
        )
        
        self.viewModel = viewModel
        return GDSErrorScreen(viewModel: viewModel)
        
    }
    // swiftlint: enable function_body_length
    
    override func tearDown() {
        buttonViewModels = []
        viewModel = nil
        sut = nil
        
        didTap_primaryButton = false
        didTap_secondaryButton = false
        didTap_tertiaryButton = false
        viewDidAppear = false
        viewDidDismiss = false
        
        super.tearDown()
    }
}

@MainActor
extension GDSErrorScreenTests {
    func test_viewContents_asExpected() throws {
        // Icon Image
        XCTAssertNotNil(try sut.image)
        XCTAssertEqual(try sut.image.tintColor, .gdsPrimary)
        
        // Labels
        XCTAssertEqual(try sut.titleLabel.text, "This is an Error View title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.icontTitleStack.accessibilityTraits.contains(.header))
       
        // Buttons
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Primary Action")
        XCTAssertEqual(try sut.primaryButton.accessibilityHint, "Button hint")
        XCTAssertEqual(try sut.primaryButton.titleLabel?.textAlignment, .center)
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "Secondary Action")
        XCTAssertEqual(try sut.secondaryButton.accessibilityHint, "Button hint")
        XCTAssertEqual(try sut.secondaryButton.titleLabel?.textAlignment, .center)
        XCTAssertEqual(try sut.tertiaryButton.title(for: .normal), "Tertiary Action")
        XCTAssertEqual(try sut.tertiaryButton.accessibilityHint, "Button hint")
        XCTAssertEqual(try sut.tertiaryButton.titleLabel?.textAlignment, .center)
    }

    func test_primaryButtonNoIcon() throws {
        XCTAssertNil(try sut.primaryButton.icon)
    }

    func test_secondaryButtonHasIcon() throws {
        XCTAssertEqual(try sut.secondaryButton.icon, "arrow.up.right")
    }
    
    func test_tertiaryButtonHasIcon() throws {
        XCTAssertEqual(try sut.tertiaryButton.icon, "arrow.up.right")
    }
    
    func test_primaryButtonAction() throws {
        XCTAssertFalse(didTap_primaryButton)
        XCTAssertFalse(try sut.primaryButton.isLoading)
        XCTAssertTrue(try sut.primaryButton.isEnabled)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(try sut.primaryButton.isLoading)
        XCTAssertFalse(try sut.primaryButton.isEnabled)
        XCTAssertTrue(didTap_primaryButton)
    }
    
    func test_secondaryButtonAction() throws {
        XCTAssertFalse(didTap_secondaryButton)
        try sut.secondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTap_secondaryButton)
    }
        
    func test_tertiaryButtonAction() throws {
        XCTAssertFalse(didTap_tertiaryButton)
        try sut.tertiaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTap_tertiaryButton)
    }
    
    func test_didAppear() throws {
        XCTAssertFalse(viewDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(viewDidAppear)
    }
    
    func test_voiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "This is an Error View title")
    }
    
    func test_didDismiss() {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        XCTAssertFalse(viewDidDismiss)
        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(viewDidDismiss)
    }
    
    func test_imageIsNotHidden() throws {
        XCTAssertFalse(try sut.image.isHidden)
    }
    
    func test_errorScreenWithNoButtons() throws {
        // GIVEN we setup the SUT with no buttons
        sut = createSUT(buttonsToAdd: 0)
        
        // THEN all buttons should be nil
        XCTAssertEqual(try sut.buttonStack.arrangedSubviews.count, 0)
        XCTAssertNil(sut.view[child: "error-screen-button-0"]) // Primary
        XCTAssertNil(sut.view[child: "error-screen-button-1"]) // Secondary
        XCTAssertNil(sut.view[child: "error-screen-button-2"]) // Tertiary
    }
    
    func test_errorScreenWithOneButton() throws {
        // GIVEN we setup the SUT with 1 button
        sut = createSUT(buttonsToAdd: 1)
        
        // THEN primary should not be nil, but secondary and tertiary should be nil
        XCTAssertEqual(try sut.buttonStack.arrangedSubviews.count, 1)
        XCTAssertNotNil(sut.view[child: "error-screen-button-0"]) // Primary
        XCTAssertNil(sut.view[child: "error-screen-button-1"]) // Secondary
        XCTAssertNil(sut.view[child: "error-screen-button-2"]) // Tertiary
    }
    
    func test_errorScreenWithTwoButtons() throws {
        // GIVEN we setup the SUT with 2 buttons
        sut = createSUT(buttonsToAdd: 2)
                
        // THEN primary and secondary should not be nil, but tertiary should be nil
        XCTAssertEqual(try sut.buttonStack.arrangedSubviews.count, 2)
        XCTAssertNotNil(sut.view[child: "error-screen-button-0"]) // Primary
        XCTAssertNotNil(sut.view[child: "error-screen-button-1"]) // Secondary
        XCTAssertNil(sut.view[child: "error-screen-button-2"]) // Tertiary
    }
    
    func test_errorScreenWithThreeButtons() throws {
        // GIVEN we setup the SUT with 3 buttons
        sut = createSUT(buttonsToAdd: 3)
        
        // THEN all buttons should be not be nil
        XCTAssertEqual(try sut.buttonStack.arrangedSubviews.count, 3)
        XCTAssertNotNil(sut.view[child: "error-screen-button-0"]) // Primary
        XCTAssertNotNil(sut.view[child: "error-screen-button-1"]) // Secondary
        XCTAssertNotNil(sut.view[child: "error-screen-button-2"]) // Tertiary
    }
    
    func test_errorContentItems() throws {
        sut = createSUT()
        
        XCTAssertEqual(try sut.bodyContentView.arrangedSubviews.count, 3)
        let label = try XCTUnwrap(sut.bodyContentView.arrangedSubviews[0] as? UILabel)
        XCTAssertEqual(label.text, "Body single line (regular)")
        
        let paragraphLabel = try XCTUnwrap(sut.bodyContentView.arrangedSubviews[1] as? UILabel)
        XCTAssertEqual(
            paragraphLabel.text,
            """
            Body single paragraph - Lorem ipsum dolor sit amet consectetur. Purus aliquam mattis vitae enim mauris vestibulum massa tellus.
            """
        )
        
        let button = try XCTUnwrap(sut.bodyContentView.arrangedSubviews[2] as? SecondaryButton)
        XCTAssertEqual(button.titleLabel?.text, "Button")
    }
    
}

extension GDSErrorScreen {
    var image: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "error-screen-image"])
        }
    }
    
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "error-screen-title"])
        }
    }
    
    var icontTitleStack: UIStackView {
        get throws {
            try XCTUnwrap(view[child: "error-screen-icon-title-stack-view"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "error-screen-button-0"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "error-screen-button-1"])
        }
    }
    
    var tertiaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "error-screen-button-2"])
        }
    }
    
    var bodyContentView: UIStackView {
        get throws {
            try XCTUnwrap(view[child: "error-screen-body-content-stack-view"])
        }
    }
    
    var buttonStack: UIStackView {
        get throws {
            try XCTUnwrap(view[child: "error-screen-button-stack-view"])
        }
    }
}
