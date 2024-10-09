import GDSCommon
import XCTest

final class GDSInformationViewControllerTests: XCTestCase {
    var viewModel: GDSInformationViewModel!
    var sut: GDSInformationViewController!
    
    var primaryButtonViewModel: MockButtonViewModel!
    var secondaryButtonViewModel: MockButtonViewModel!
    
    var didTap_primaryButton = false
    var didTap_secondaryButton = false
    var viewDidAppear = false
    var viewDidDismiss = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        primaryButtonViewModel = MockButtonViewModel(title: "Information primary button title") {
            self.didTap_primaryButton = true
        }
        secondaryButtonViewModel = MockButtonViewModel(title: "Information secondary button title") {
            self.didTap_secondaryButton = true
        }
        
        viewModel = MockGDSInformationViewModel(primaryButtonViewModel: primaryButtonViewModel,
                                                secondaryButtonViewModel: secondaryButtonViewModel) {
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
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Information primary button title")
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "Information secondary button title")
    }
    
    @MainActor
    func test_primaryButtonNoIcon() throws {
        XCTAssertNil(try sut.primaryButton.icon)
    }

    @MainActor
    func test_secondaryButtonNoIcon() throws {
        XCTAssertNil(try sut.secondaryButton.icon)
    }
    
    @MainActor
    func test_secondaryButtonWithIcon() throws {
        secondaryButtonViewModel = MockButtonViewModel(title: "Information secondary button title",
                                                       icon: MockButtonIconViewModel()) {}
        
        viewModel = MockGDSInformationViewModel(primaryButtonViewModel: primaryButtonViewModel,
                                                secondaryButtonViewModel: secondaryButtonViewModel) { } dismissAction: { }
        sut = GDSInformationViewController(viewModel: viewModel)
        
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

    @MainActor
    func test_voiceOverFocusElement() throws {
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
}

struct MockButtonIconViewModel: ButtonIconViewModel {
    var iconName: String = "arrow.up.right"
    var symbolPosition: SymbolPosition = .afterTitle
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
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "information-primary-button"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "information-secondary-button"])
        }
    }

    var childView: UIStackView {
        get throws {
            try XCTUnwrap(view[child: "information-optional-stack-view"])
        }
    }
}
     
