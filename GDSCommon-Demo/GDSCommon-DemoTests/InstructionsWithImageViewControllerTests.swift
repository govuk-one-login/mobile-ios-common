@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

final class InstructionsWithImageViewControllerTests: XCTestCase {
    var buttonViewModel: ButtonViewModel!
    var warningButtonViewModel: ButtonViewModel!
    var viewModel: InstructionsWithImageViewModel!
    var sut: InstructionsWithImageViewController!
    
    var screenDidAppear = false
    var screenDidDismiss = false
    
    var didTapWarningButton = false
    var didTapPrimaryButton = false
    var didTapSecondaryButton = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        viewModel = MockInstructionsWithImageViewModel(
            warningButtonViewModel: MockButtonViewModel(
                title: "Warning Button",
                shouldLoadOnTap: false,
                action: {
                    self.didTapWarningButton = true
                }),
            primaryButtonViewModel: MockButtonViewModel(
                title: "Action Button",
                icon: MockButtonIconViewModel(iconName: "qrcode",
                                              symbolPosition: .beforeTitle),
                shouldLoadOnTap: false,
                action: {
                    self.didTapPrimaryButton = true
                }),
            secondaryButtonViewModel: MockButtonViewModel(
                title: "Secondary Button",
                icon: MockButtonIconViewModel(iconName: "qrcode",
                                              symbolPosition: .beforeTitle),
                shouldLoadOnTap: false,
                action: {
                    self.didTapSecondaryButton = true
                }),
            rightBarButtonTitle: "close",
            screenView: {
                self.screenDidAppear = true
            },
            dismissAction: {
                self.screenDidDismiss = true
            })
        
        sut = InstructionsWithImageViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        buttonViewModel = nil
        warningButtonViewModel = nil
        viewModel = nil
        sut = nil
        
        screenDidAppear = false
        screenDidDismiss = false
        
        didTapWarningButton = false
        didTapPrimaryButton = false
        didTapSecondaryButton = false
        
        super.tearDown()
    }
}

extension InstructionsWithImageViewControllerTests {
    @MainActor
    func testDidAppear() {
        XCTAssertFalse(screenDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(screenDidAppear)
    }
    
    @MainActor
    func testVoiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "This is the Instructions with image view")
    }
    
    @MainActor
    func testTitleBar() {
        XCTAssertEqual(sut.navigationItem.hidesBackButton, false)
        sut.navigationItem.hidesBackButton = true
        XCTAssertEqual(sut.navigationItem.hidesBackButton, true)
        
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "close")
        
        XCTAssertFalse(screenDidDismiss)
        
        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(screenDidDismiss)
    }
    
    @MainActor
    func test_backButton() {
        XCTAssertFalse(sut.navigationItem.hidesBackButton)
    }
    
    @MainActor
    func test_labelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "This is the Instructions with image view")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "We can use this body to provide details or context as to what we want the users to do")
        XCTAssertEqual(try sut.bodyLabel.textColor, .gdsGrey)
    }
    
    @MainActor
    func test_imageView() throws {
        XCTAssertNotNil(try sut.imageView)
    }
    
    @MainActor
    func test_primaryButton() throws {
        XCTAssertNotNil(try sut.primaryButton)
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Action Button")
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        XCTAssertEqual(try sut.primaryButton.icon, viewModel.primaryButtonViewModel.icon?.iconName)
        XCTAssertEqual(try sut.primaryButton.symbolPosition, viewModel.primaryButtonViewModel.icon?.symbolPosition)
        
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapPrimaryButton)
    }
    
    @MainActor
    func test_secondaryButton() throws {
        XCTAssertNotNil(try sut.secondaryButton)
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "Secondary Button")
        XCTAssertEqual(try sut.secondaryButton.backgroundColor, nil)
        XCTAssertEqual(try sut.secondaryButton.icon, viewModel.secondaryButtonViewModel?.icon?.iconName)
        XCTAssertEqual(try sut.secondaryButton.symbolPosition, viewModel.secondaryButtonViewModel?.icon?.symbolPosition)
        
        try sut.secondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapSecondaryButton)
    }
    
    @MainActor
    func test_warningButton() throws {
        XCTAssertNotNil(try sut.warningButton)
        XCTAssertEqual(try sut.warningButton.title(for: .normal), "Warning Button")
        XCTAssertEqual(try sut.warningButton.backgroundColor, nil)
        
        try sut.warningButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapWarningButton)
    }
}

extension InstructionsWithImageViewController {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "titleLabel"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "bodyLabel"])
        }
    }
    
    var imageView: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "imageView"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "primaryButton"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "secondaryButton"])
        }
    }
    
    var warningButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "warningButton"])
        }
    }
}
