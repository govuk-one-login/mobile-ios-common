import GDSCommon
import XCTest

final class WelcomeViewControllerTests: XCTestCase {
    var viewModel: WelcomeViewModel!
    var sut: WelcomeViewController!
    var buttonAction = false
    var viewDidAppear = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = TestViewModel {
            self.buttonAction = true
        } appearAction: {
            self.viewDidAppear = true
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
    let image: UIImage = UIImage()
    let title: GDSLocalisedString = "welcome screen title"
    let body: GDSLocalisedString = "welcome screen body"
    let welcomeButtonViewModel: ButtonViewModel
    let appearAction: () -> Void
    
    init(buttonAction: @escaping () -> Void,
         appearAction: @escaping () -> Void) {
        welcomeButtonViewModel = MockButtonViewModel(title: "welcome screen button title") {
            buttonAction()
        }
        self.appearAction = appearAction
    }
    
    func didAppear() {
        appearAction()
    }
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
        XCTAssertFalse(buttonAction)
        sut.welcomeButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(buttonAction)
    }
    
    func test_viewDidAppear() throws {
        XCTAssertFalse(viewDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(viewDidAppear)
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
