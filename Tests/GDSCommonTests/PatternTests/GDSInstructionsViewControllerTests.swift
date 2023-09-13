import GDSCommon
import XCTest


final class GDSInstructionsViewControllerTests: XCTestCase {
    var buttonViewModel: ButtonViewModel!
    var viewModel: GDSInstructionsViewModel!
    var sut: GDSInstructionsViewController!
    
    var screenDidAppear = false
    var didTapButton = false
    
    override func setUp() {
        super.setUp()
        
        let bullets = BulletView(title: "bullet title",
                                 text: ["bullet 1",
                                        "bullet 2",
                                        "bullet 3"])
        
        let buttonViewModel = MockButtonViewModel(title: GDSLocalisedString(stringLiteral: "button title")) {
            self.didTapButton = true
        }
        
        viewModel = MockGDSInstructionsViewModel(childView: bullets,
                                                 buttonViewModel: buttonViewModel) {
            self.screenDidAppear = true
        }
        
        sut = GDSInstructionsViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        buttonViewModel = nil
        viewModel = nil
        sut = nil
    
        super.tearDown()
    }
}

extension GDSInstructionsViewControllerTests {
    func test_backButton() {
        XCTAssertFalse(sut.navigationItem.hidesBackButton)
    }
    
    func test_labelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "test title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        
        XCTAssertEqual(try sut.bodyLabel.text, "test body"
        )
    }
    
    func test_bullets() throws {
        let bullets = try XCTUnwrap(sut.stackView.arrangedSubviews[2] as? BulletView)
        
        let bulletTitle: UILabel = try XCTUnwrap(bullets[child: "bullet-title"])
        let stack: UIStackView = try XCTUnwrap(bullets[child: "bullet-stack"])
        let bulletLabels: [UILabel] = try XCTUnwrap(stack.arrangedSubviews as? [UILabel])
        
        XCTAssertEqual(bulletTitle.text, "bullet title")
        XCTAssertEqual(bulletLabels[0].text, "\t●\tbullet 1")
        XCTAssertEqual(bulletLabels[1].text, "\t●\tbullet 2")
        XCTAssertEqual(bulletLabels[2].text, "\t●\tbullet 3")
    }
    
    func test_primaryButton() throws {
        XCTAssertNotNil(try sut.primaryButton)
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "button title")
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
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
