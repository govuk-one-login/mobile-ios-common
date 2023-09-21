import GDSCommon
import XCTest

final class InstructionsWithImageViewControllerTests: XCTestCase {
    var buttonViewModel: ButtonViewModel!
    var warningButtonViewModel: ButtonViewModel!
    var viewModel: InstructionsWithImageViewModel!
    var sut: InstructionsWithImageViewController!
    
    var screenDidAppear = false
    var didTapButton = false
    var didTapWarningButton = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = MockInstructionsWithImageViewController {
            self.screenDidAppear = true
        } buttonAction: {
            self.didTapButton = true
        } warningButtonAction: {
            self.didTapWarningButton = true
        }
        
        sut = InstructionsWithImageViewController(viewModel: viewModel)
        
        attachToWindow(viewController: sut)
    }
    
    override func tearDown() {
        buttonViewModel = nil
        warningButtonViewModel = nil
        viewModel = nil
        sut = nil
    
        super.tearDown()
    }
}

internal struct MockInstructionsWithImageViewController: InstructionsWithImageViewModel {
    let title: GDSLocalisedString = "test title"
    let body: NSAttributedString = NSAttributedString(string: "test body")
    let image: UIImage = UIImage(systemName: "photo")!
    let warningButtonViewModel: ButtonViewModel?
    let primaryButtonViewModel: ButtonViewModel
    let screenView: () -> Void
    
    func didAppear() {
        screenView()
    }
    
    init(screenView: @escaping () -> Void,
         buttonAction: @escaping () -> Void,
         warningButtonAction: @escaping () -> Void) {
        self.screenView = screenView
        
        self.warningButtonViewModel = MockButtonViewModel(title: GDSLocalisedString(stringLiteral: "button title")) {
            warningButtonAction()
        }
        
        self.primaryButtonViewModel = MockButtonViewModel(title: GDSLocalisedString(stringLiteral: "button title")) {
            buttonAction()
        }
    }
}

extension InstructionsWithImageViewControllerTests {
    func test_backButton() {
        XCTAssertFalse(sut.navigationItem.hidesBackButton)
    }
    
    func test_labelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "test title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "test body")
        XCTAssertEqual(try sut.bodyLabel.textColor, .gdsGrey)
    }
    
    func test_imageView() throws {
        XCTAssertNotNil(try sut.imageView)
    }
    
    func test_primaryButton() throws {
        XCTAssertNotNil(try sut.primaryButton)
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "button title")
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapButton)
    }
    
    func test_warningButton() throws {
        XCTAssertNotNil(try sut.warningButton)
        XCTAssertEqual(try sut.warningButton.title(for: .normal), "button title")
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
    
    var warningButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "warningButton"])
        }
    }
}
