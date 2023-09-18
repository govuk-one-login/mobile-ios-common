@testable import GDSCommon
import XCTest

final class ListOptionsViewControllerTests: XCTestCase {
    var sut: ListOptionsViewController!
    var viewModel: ListOptionsViewModel!
    var resultAction: ((GDSLocalisedString) -> Void)!
    var gdsLocalisedString: GDSLocalisedString!
    
    var didSetStringKey: String?
    var screenDidAppear: Bool = false
    
    override func setUp() {
        super.setUp()
        gdsLocalisedString = "exampleString"
        screenDidAppear = false
        
        resultAction = { gdsString in
            self.didSetStringKey = gdsString.stringKey
        }
        
        viewModel = MockListViewModel() { localisedString in
            self.didSetStringKey = localisedString.stringKey
        } screenView: {
            self.screenDidAppear = true
        }
        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        gdsLocalisedString = nil
        resultAction = nil
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

extension ListOptionsViewControllerTests {
    func testLabelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "Title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        
        XCTAssertEqual(try sut.bodyLabel.text, "Body")
        XCTAssertEqual(try sut.bodyLabel.font, .body)
    }
    
    func testTitleBar() {
        XCTAssertEqual(sut.navigationItem.hidesBackButton, false)
        sut.navigationItem.hidesBackButton = true
        XCTAssertEqual(sut.navigationItem.hidesBackButton, true)
        
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "right bar button")
    }
    
    func testPrimaryButton() {
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.textColor, .white)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.font, .bodySemiBold)
    }
}

extension ListOptionsViewController {
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
    
    var tableViewList: UITableView {
        get throws {
            try XCTUnwrap(view[child: "tableViewList"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "primaryButton"])
        }
    }
}
