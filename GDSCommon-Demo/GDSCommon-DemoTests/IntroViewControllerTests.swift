import GDSCommon
import XCTest

final class IntroViewControllerTests: XCTestCase {
    var viewModel: IntroViewModel!
    var sut: IntroViewController!
    var buttonAction = false
    var viewDidAppear = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = TestViewModel {
            self.buttonAction = true
        } appearAction: {
            self.viewDidAppear = true
        }
        sut = IntroViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestViewModel: IntroViewModel {
    let image: UIImage = UIImage()
    let title: GDSLocalisedString = "Intro screen title"
    let body: GDSLocalisedString = "Intro screen body"
    let introButtonViewModel: ButtonViewModel
    let appearAction: () -> Void
    
    init(buttonAction: @escaping () -> Void,
         appearAction: @escaping () -> Void) {
        introButtonViewModel = MockButtonViewModel(title: "Intro screen button title") {
            buttonAction()
        }
        self.appearAction = appearAction
    }
    
    func didAppear() {
        appearAction()
    }
}

extension IntroViewControllerTests {
    func test_labelContents() throws {
        try XCTAssertNotNil(sut.introImage)
        try XCTAssertEqual(sut.titleLabel.text, "Intro screen title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        try XCTAssertEqual(sut.bodyLabel.text, "Intro screen body")
        XCTAssertFalse(try sut.bodyLabel.accessibilityTraits.contains(.header))
        try XCTAssertEqual(sut.introButton.title(for: .normal), "Intro screen button title")
    }
    
    func test_buttonAction() throws {
        XCTAssertFalse(buttonAction)
        try sut.introButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(buttonAction)
    }
    
    func test_viewDidAppear() throws {
        XCTAssertFalse(viewDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(viewDidAppear)
    }
}

extension IntroViewController {
    var introImage: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "intro-image"])
        }
    }
    
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "intro-title"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "intro-body"])
        }
    }
    
    var introButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "intro-button"])
        }
    }
}
