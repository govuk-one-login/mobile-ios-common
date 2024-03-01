import GDSCommon
import XCTest

final class ModalInfoButtonsViewControllerTests: XCTestCase {
    var viewModel: ModalInfoButtonsViewModel!
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

private struct TestViewModel: ModalInfoButtonsViewModel, BaseViewModel {
    var title: GDSLocalisedString = "Modal info buttons title"
    var body: GDSLocalisedString = "Modal info buttons body"
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

extension ModalInfoButtonsViewControllerTests {
    func test_labelContents() throws {
        XCTAssertEqual(try sut.titleLabel.text, "Modal info buttons title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "Modal info buttons body")
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
        XCTAssertEqual(view.text, "Modal info buttons title")
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
