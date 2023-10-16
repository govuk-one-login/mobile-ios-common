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

private struct TestViewModel: ModalInfoViewModel {
    var title: GDSLocalisedString = "permissions screen title"
    var body: GDSLocalisedString? = "permissions screen body"
    var attributedBody: GDSAttributedString? = GDSAttributedString(localisedString: "permissions screen body",
                                                                   attributes: [.font: UIFont.bodyBold],
                                                                   stringToAttribute: "permissions")
    var rightBarButtonTitle: GDSLocalisedString = "Done"
    
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
        sut.endAppearanceTransition()
        XCTAssertEqual(try sut.rightBarButtonItem.title, "Done")
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
