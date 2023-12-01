import GDSCommon
import XCTest

final class IntroViewControllerTests: XCTestCase {
    var viewModel: IntroViewModel!
    var sut: IntroViewController!
    var buttonAction = false
    var viewDidAppear = false
    var viewDidDismiss = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = TestViewModel {
            self.buttonAction = true
        } appearAction: {
            self.viewDidAppear = true
        } dismissAction: {
            self.viewDidDismiss = true
        }
        sut = IntroViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestViewModel: IntroViewModel, BaseViewModel {
    let image: UIImage = UIImage()
    let title: GDSLocalisedString = "Intro screen title"
    let body: GDSLocalisedString = "Intro screen body"
    let introButtonViewModel: ButtonViewModel
    var rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    var backButtonIsHidden: Bool = false
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    init(buttonAction: @escaping () -> Void,
         appearAction: @escaping () -> Void,
         dismissAction: @escaping () -> Void
    ) {
        introButtonViewModel = MockButtonViewModel(title: "Intro screen button title") {
            buttonAction()
        }
        self.appearAction = appearAction
        self.dismissAction = dismissAction
    }
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }
}

extension IntroViewControllerTests {
    func test_labelContents() throws {
        XCTAssertNotNil(try sut.introImage)
        XCTAssertEqual(try sut.titleLabel.text, "Intro screen title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "Intro screen body")
        XCTAssertFalse(try sut.bodyLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.introButton.title(for: .normal), "Intro screen button title")
    }
    
    func test_buttonAction() throws {
        XCTAssertFalse(buttonAction)
        try sut.introButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(buttonAction)
    }
    
    func test_viewDidAppear() throws {
        XCTAssertFalse(viewDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
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
