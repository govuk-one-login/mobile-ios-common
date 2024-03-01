import GDSCommon
import XCTest

final class ModalInfoViewControllerTests: XCTestCase {
    var viewModel: ModalInfoViewModel!
    var sut: ModalInfoViewController!
    var primaryButton = false
    var secondaryButton = false
    var viewDidAppear = false
    var viewDidDismiss = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = TestViewModel {
            self.primaryButton = true
        } secondaryButtonAction: {
            self.secondaryButton = true
        } appearAction: {
            self.viewDidAppear = true
        } dismissAction: {
            self.viewDidDismiss = true
        }
        sut = ModalInfoViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestViewModel: ModalInfoViewModel, BaseViewModel {
    var title: GDSLocalisedString = "Modal info title"
    var body: GDSLocalisedString = "Modal info body"
    var rightBarButtonTitle: GDSLocalisedString? = "Done"
    var backButtonIsHidden: Bool = false
    
    var bodyTextColour: UIColor?
    var primaryButtonViewModel: ButtonViewModel?
    var secondaryButtonViewModel: ButtonViewModel?
    var preventModalDismiss: Bool?
    
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    init(primaryButtonAction: @escaping () -> Void,
         secondaryButtonAction: @escaping () -> Void,
         appearAction: @escaping () -> Void,
         dismissAction: @escaping () -> Void) {
        primaryButtonViewModel = MockButtonViewModel(title: "Primary button") {
            primaryButtonAction()
        }
        secondaryButtonViewModel = MockButtonViewModel(title: "Secondary button") {
            secondaryButtonAction()
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

extension ModalInfoViewControllerTests {
    func test_labelContents() throws {
        XCTAssertEqual(try sut.titleLabel.text, "Modal info title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "Modal info body")
        XCTAssertFalse(try sut.bodyLabel.accessibilityTraits.contains(.header))
        XCTAssert(try sut.bodyLabel.textColor == .gdsGrey)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertEqual(try sut.rightBarButtonItem.title, "Done")
    }
    
    func test_primaryButtonAction() throws {
        XCTAssertFalse(primaryButton)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(primaryButton)
    }
    
    func test_secondaryButtonAction() throws {
        XCTAssertFalse(secondaryButton)
        try sut.secondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(secondaryButton)
    }
    
    func test_didAppear() throws {
        XCTAssertFalse(viewDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(viewDidAppear)
    }
    
    func test_VoiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "Modal info title")
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
}

extension ModalInfoViewController {
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
    
    var rightBarButtonItem: UIBarButtonItem {
        get throws {
            try XCTUnwrap(navigationItem.rightBarButtonItem)
        }
    }
    
    var primaryButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "modal-info-primary-button"])
        }
    }
    
    var secondaryButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "modal-info-secondary-button"])
        }
    }
}
