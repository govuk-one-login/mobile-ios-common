import GDSCommon
import XCTest

final class WelcomeViewControllerTests: XCTestCase {
    var viewModel: WelcomeViewModel!
    var sut: WelcomeViewController!
    var didTapButton = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = TestViewModel() {
            self.didTapButton = true
        }
        sut = WelcomeViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestViewModel: WelcomeViewModel {
    var image: UIImage = UIImage()
    var title: GDSLocalisedString = "welcome screen title"
    var body: GDSLocalisedString = "welcome screen body"
    var welcomeButtonViewModel: ButtonViewModel
    
    init(action: @escaping () -> Void) {
        welcomeButtonViewModel = MockButtonViewModel(title: "welcome screen button title") {
            action()
        }
    }
    
    func didAppear() { }
}

extension WelcomeViewControllerTests {
    func test_labelContents() throws {
        try XCTAssertNotNil(sut.welcomeImage)
        try XCTAssertEqual(sut.titleLabel.text, "welcome screen title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        try XCTAssertEqual(sut.bodyLabel.text, "welcome screen body")
        XCTAssertFalse(try sut.bodyLabel.accessibilityTraits.contains(.header))
        try XCTAssertEqual(sut.welcomeButton.title(for: .normal), "welcome screen button title")
    }
    
    func test_buttonAction() throws {
        XCTAssertFalse(didTapButton)
        try sut.welcomeButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapButton)
    }
}

extension WelcomeViewController {
    var welcomeImage: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "welcome-image"])
        }
    }
    
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "welcome-title"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "welcome-body"])
        }
    }
    
    var welcomeButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "welcome-button"])
        }
    }
}
