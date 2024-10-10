import GDSCommon
import XCTest

final class GDSInstructionsViewControllerTests: XCTestCase {
    var buttonViewModel: ButtonViewModel!
    var viewModel: GDSInstructionsViewModel!
    var sut: GDSInstructionsViewController!
    var bulletView: BulletView!
    
    var screenDidAppear = false
    var didTapButton = false
    var didDismiss = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        bulletView = BulletView(title: "bullet title",
                                text: ["bullet 1",
                                       "bullet 2",
                                       "bullet 3"],
                                titleFont: .init(style: .largeTitle))
        
        let buttonViewModel = MockButtonViewModel(title: GDSLocalisedString(stringLiteral: "button title")) {
            self.didTapButton = true
        }
        
        viewModel = MockGDSInstructionsViewModel(childView: bulletView,
                                                 buttonViewModel: buttonViewModel,
                                                 secondaryButtonViewModel: buttonViewModel) {
            self.screenDidAppear = true
        } dismissAction: {
            self.didDismiss = true
        }
        
        sut = GDSInstructionsViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        buttonViewModel = nil
        bulletView = nil
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

extension GDSInstructionsViewControllerTests {
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
        XCTAssertEqual(view.text, "test title")
    }
    
    @MainActor
    func test_backButton() {
        XCTAssertFalse(sut.navigationItem.hidesBackButton)
    }
    
    @MainActor
    func test_labelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "test title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        
        XCTAssertEqual(try sut.bodyLabel.text, "test body"
        )
    }
    
    @MainActor
    func testTitleBar() {
        XCTAssertEqual(sut.navigationItem.hidesBackButton, false)
        sut.navigationItem.hidesBackButton = true
        XCTAssertEqual(sut.navigationItem.hidesBackButton, true)
        
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "right bar button")
        
        XCTAssertFalse(didDismiss)
        
        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(didDismiss)
    }
    
    @MainActor
    func test_bullets() throws {
        let bullets = try XCTUnwrap(sut.stackView.arrangedSubviews[2] as? BulletView)
        
        let bulletTitle: UILabel = try XCTUnwrap(bullets[child: "bullet-title"])
        let stack: UIStackView = try XCTUnwrap(bullets[child: "bullet-stack"])
        let bulletLabels: [UILabel] = try XCTUnwrap(stack.arrangedSubviews as? [UILabel])
        
        XCTAssertEqual(bulletTitle.font, UIFont.init(style: .largeTitle))
        XCTAssertEqual(bulletTitle.text, "bullet title")
        XCTAssertEqual(bulletLabels[0].text, "\t●\tbullet 1")
        XCTAssertEqual(bulletLabels[1].text, "\t●\tbullet 2")
        XCTAssertEqual(bulletLabels[2].text, "\t●\tbullet 3")
    }
    
    @MainActor
    func test_primaryButton() throws {
        XCTAssertNotNil(try sut.primaryButton)
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "button title")
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
    }
    
    @MainActor
    func test_coloredButton() throws {
        let coloredButton = MockColoredButtonViewModel(title: "Test", action: { }, backgroundColor: .gdsRed)
        viewModel = MockGDSInstructionsViewModel(childView: bulletView, buttonViewModel: coloredButton, secondaryButtonViewModel: nil, screenView: { }) {
            self.didTapButton = true
        }
        sut = GDSInstructionsViewController(viewModel: viewModel)
        XCTAssertNotNil(try sut.primaryButton)
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Test")
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsRed)
    }
    
    @MainActor
    func testSecondaryButton() throws {
        XCTAssertNotNil(try sut.secondaryButton)
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "button title")
        XCTAssertNotEqual(try sut.secondaryButton.backgroundColor, .gdsGreen)
    }
}


extension GDSInstructionsViewController {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "instructions-title"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "instructions-body"])
        }
    }
    
    var stackView: UIStackView {
        get throws {
            try XCTUnwrap(view[child: "instructions-stackView"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "instructions-button"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "instructions-secondary-button"])
        }
    }
}

struct MockButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString
    let icon: ButtonIconViewModel?
    let shouldLoadOnTap: Bool
    let action: () -> Void
    
    init(title: GDSLocalisedString, icon: ButtonIconViewModel? = nil, shouldLoadOnTap: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.shouldLoadOnTap = shouldLoadOnTap
        self.action = action
    }
}

struct MockColoredButtonViewModel: ColoredButtonViewModel {
    let title: GDSLocalisedString
    let icon: ButtonIconViewModel?
    let shouldLoadOnTap: Bool
    let action: () -> Void
    let backgroundColor: UIColor
    
    init(title: GDSLocalisedString, icon: ButtonIconViewModel? = nil, shouldLoadOnTap: Bool = false, action: @escaping () -> Void, backgroundColor: UIColor) {
        self.title = title
        self.icon = icon
        self.shouldLoadOnTap = shouldLoadOnTap
        self.action = action
        self.backgroundColor = backgroundColor
    }
}
