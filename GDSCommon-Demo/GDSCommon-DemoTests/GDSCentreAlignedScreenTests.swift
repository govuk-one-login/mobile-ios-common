@testable import GDSCommon
import XCTest

final class GDSCentreAlignedScreenTests: XCTestCase {
    var viewModel: GDSCentreAlignedViewModel!
    var sut: GDSCentreAlignedScreen!
    
    var primaryButtonViewModel: MockButtonViewModel!
    var secondaryButtonViewModel: MockButtonViewModel!
    var didTap_primaryButton = false
    var didTap_secondaryButton = false
    var viewDidAppear = false
    var viewDidDismiss = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        primaryButtonViewModel = MockButtonViewModel(title: "Primary button title") {
            self.didTap_primaryButton = true
        }
        
        secondaryButtonViewModel = MockButtonViewModel(title: "Secondary button title") {
            self.didTap_secondaryButton = true
        }
        
        viewModel = MockGDSCentreAlignedViewModel(primaryButtonViewModel: primaryButtonViewModel,
                                                  secondaryButtonViewModel: secondaryButtonViewModel) {
            self.viewDidAppear = true
        } dismissAction: {
            self.viewDidDismiss = true
        }
        sut = GDSCentreAlignedScreen(viewModel: viewModel)
    }
    
    override func tearDown() {
        primaryButtonViewModel = nil
        secondaryButtonViewModel = nil
        
        viewModel = nil
        sut = nil
        
        didTap_primaryButton = false
        didTap_secondaryButton = false
        viewDidAppear = false
        viewDidDismiss = false
        
        super.tearDown()
    }
}

@MainActor
extension GDSCentreAlignedScreenTests {
    func test_labelContents() throws {
        XCTAssertNotNil(try sut.image)
        XCTAssertEqual(try sut.image.tintColor, .gdsPrimary)
        XCTAssertEqual(try sut.titleLabel.text, "Centre aligned screen title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "Centre aligned screen body")
        XCTAssertFalse(try sut.bodyLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.footnoteLabel.text, "Centre aligned screen footnote")
        XCTAssertEqual(try sut.footnoteLabel.font, .footnote)
        XCTAssertFalse(try sut.footnoteLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Primary button title")
        XCTAssertEqual(try sut.primaryButton.accessibilityHint, "Centre aligned screen accessibility hint")
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "Secondary button title")
    }
    
    func test_footnoteMovesToScrollView() throws {
        sut.loadView()
        // When bottom stack height is half of the screen size
        try sut.bottomStack.frame.size.height = UIScreen.main.bounds.height / 2
        sut.viewDidLayoutSubviews()
        
        // Footnote is inside the scroll view
        XCTAssertTrue(sut.isFootnoteInScrollView)
    }
    
    func test_footnoteMovesToBackToStackView() throws {
        sut.loadView()
        // When bottom stack height is half of the screen size
        try sut.bottomStack.frame.size.height = UIScreen.main.bounds.height / 2
        sut.viewDidLayoutSubviews()
        
        XCTAssertTrue(sut.isFootnoteInScrollView)
        
        // When bottom stack is only a quarter of the screen size
        try sut.bottomStack.frame.size.height = UIScreen.main.bounds.height / 4
        sut.viewDidLayoutSubviews()
        
        // Footnote is not inside the scroll
        XCTAssertFalse(sut.isFootnoteInScrollView)
    }
    
    func test_primaryButtonNoIcon() throws {
        XCTAssertNil(try sut.primaryButton.icon)
    }

    func test_secondaryButtonNoIcon() throws {
        XCTAssertNil(try sut.secondaryButton.icon)
    }
    
    func test_secondaryButtonWithIcon() throws {
        secondaryButtonViewModel = MockButtonViewModel(title: "Secondary button with no icon",
                                                       icon: MockButtonIconViewModel()) {}
        
        viewModel = MockGDSCentreAlignedViewModel(primaryButtonViewModel: primaryButtonViewModel,
                                                  secondaryButtonViewModel: secondaryButtonViewModel) {
        } dismissAction: {
            
        }
        sut = GDSCentreAlignedScreen(viewModel: viewModel)
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "Secondary button with no icon")
        XCTAssertNotNil(try sut.secondaryButton.icon)
    }
    
    func test_primaryButtonAction() throws {
        XCTAssertFalse(didTap_primaryButton)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTap_primaryButton)
    }
    
    func test_secondaryButtonAction() throws {
        XCTAssertFalse(didTap_secondaryButton)
        try sut.secondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTap_secondaryButton)
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
        XCTAssertEqual(view.text, "Centre aligned screen title")
    }
    
    func test_didDismiss() {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        XCTAssertFalse(viewDidDismiss)
        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(viewDidDismiss)
    }

    func test_optionalChildView() throws {
        let childView = try XCTUnwrap(sut.childView)
        let childViewBody: UILabel = try XCTUnwrap(childView[child: "body-text"])
        let bulletTitle: UILabel = try XCTUnwrap(childView[child: "bullet-title"])
        let stack: UIStackView = try XCTUnwrap(childView[child: "bullet-stack"])
        let bulletLabels: [UILabel] = try XCTUnwrap(stack.arrangedSubviews as? [UILabel])

        XCTAssertEqual(bulletTitle.text, "bullet title")
        XCTAssertEqual(bulletLabels[0].text, "\t●\tbullet 1")
        XCTAssertEqual(bulletLabels[1].text, "\t●\tbullet 2")
        XCTAssertEqual(bulletLabels[2].text, "\t●\tbullet 3")
        XCTAssertEqual(childViewBody.text, "More text")
    }
    
    func test_imageIsNotHidden() throws {
        XCTAssertFalse(try sut.image.isHidden)
    }
    
    func test_imageIsHidden() throws {
        viewModel = MockGDSCentreAlignedViewModelNoImage(primaryButtonViewModel: primaryButtonViewModel,
                                                         secondaryButtonViewModel: secondaryButtonViewModel,
                                                         appearAction: {},
                                                         dismissAction: {})
        
        sut = GDSCentreAlignedScreen(viewModel: viewModel)
        XCTAssertTrue(try sut.image.isHidden)
    }
}

// MARK: - GDSInformationVieWModelV2 Tests
@MainActor
extension GDSCentreAlignedScreenTests {
    func test_fullyConfiguredView_v2ViewModel() {
        let viewModel = MockGDSInformationViewModelV2(primaryButtonViewModel: primaryButtonViewModel,
                                                      secondaryButtonViewModel: secondaryButtonViewModel)
        sut = GDSInformationViewController(viewModel: viewModel)
        
        XCTAssertEqual(try sut.titleLabel.text, "V2 Information screen title")
        XCTAssertEqual(try sut.bodyLabel.text, "V2 Information screen body")
        XCTAssertEqual(try sut.footnoteLabel.text, "V2 Information screen footnote")
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Primary button title")
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "Secondary button title")
    }
    
    func test_partiallyConfiguredView() {
        sut = GDSInformationViewController(
            viewModel: MockGDSInformationViewModelV2(
                primaryButtonViewModel: nil,
                secondaryButtonViewModel: secondaryButtonViewModel
            )
        )
        XCTAssertTrue(try sut.primaryButton.isHidden)
    }
}

// MARK: GDSInformationViewModel Tests
@MainActor
extension GDSCentreAlignedScreenTests {
    func test_fullyConfiguredView_originalViewModel() {
        let viewModel = MockGDSInformationViewModel(primaryButtonViewModel: primaryButtonViewModel,
                                                    secondaryButtonViewModel: secondaryButtonViewModel)
        sut = GDSInformationViewController(viewModel: viewModel)
        
        XCTAssertEqual(try sut.titleLabel.text, "Information screen title")
        XCTAssertEqual(try sut.bodyLabel.text, "Information screen body")
        XCTAssertEqual(try sut.footnoteLabel.text, "Information screen footnote")
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Primary button title")
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "Secondary button title")
    }
}


struct MockButtonIconViewModel: ButtonIconViewModel {
    var iconName: String = "arrow.up.right"
    var symbolPosition: SymbolPosition = .afterTitle
}

extension GDSCentreAlignedScreen {
    var image: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "centre-aligned-screen-image"])
        }
    }
    
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "centre-aligned-screen-title"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "centre-aligned-screen-body"])
        }
    }
    
    var footnoteLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "centre-aligned-screen-footnote"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "centre-aligned-screen-primary-button"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "centre-aligned-screen-secondary-button"])
        }
    }

    var childView: UIStackView {
        get throws {
            try XCTUnwrap(view[child: "centre-aligned-screen-optional-stack-view"])
        }
    }
    
    var bottomStack: UIStackView {
        get throws {
            try XCTUnwrap(view[child: "centre-aligned-screen-bottom-stack-view"])
        }
    }
}
     
