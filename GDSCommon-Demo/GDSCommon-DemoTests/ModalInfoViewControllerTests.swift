import GDSCommon
import XCTest

final class ModalInfoViewControllerTests: XCTestCase {
    var viewModel: ModalInfoViewModel!
    var sut: ModalInfoViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = TestViewModel()
        sut = ModalInfoViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestViewModel: ModalInfoViewModel, BaseViewModel {
    var title: GDSLocalisedString = "permissions screen title"
    var body: GDSLocalisedString = "permissions screen body"
    var rightBarButtonTitle: GDSLocalisedString? = "Done"
    var backButtonIsHidden: Bool = false
    
    func didAppear() { }
    
    func didDismiss() { }
}

extension ModalInfoViewControllerTests {
    func test_labelContents() throws {
        XCTAssertEqual(try sut.titleLabel.text, "permissions screen title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "permissions screen body")
        XCTAssertFalse(try sut.bodyLabel.accessibilityTraits.contains(.header))
        XCTAssert(try sut.bodyLabel.textColor == .gdsGrey)
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        XCTAssertEqual(try sut.rightBarButtonItem.title, "Done")
    }
    
    func testVoiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "permissions screen title")
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
}
