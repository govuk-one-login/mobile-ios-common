@testable import GDSCommon
import XCTest

final class ListOptionsViewControllerTests: XCTestCase {
    var sut: ListOptionsViewController!
    var viewModel: ListOptionsViewModel!
    var resultAction: ((GDSLocalisedString) -> Void)!
    var gdsLocalisedString: GDSLocalisedString!
    
    var didSetStringKey: String?
    
    override func setUp() {
        super.setUp()
        gdsLocalisedString = "exampleString"
        
        resultAction = { gdsString in
            self.didSetStringKey = gdsString.stringKey
        }
        
        viewModel = MockListViewModel() { localisedString in
            self.didSetStringKey = localisedString.stringKey
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
    
    func testResultAction() throws {
        XCTAssertNil(didSetStringKey)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        resultAction(gdsLocalisedString)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(didSetStringKey, "exampleString")
    }
    
    func testSelectRow() throws {
        XCTAssertNil(didSetStringKey)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        try sut.tableViewList.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: .none)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        
        let cell = try XCTUnwrap(sut.tableViewList.cellForRow(at: IndexPath(row: 1, section: 0)) as? ListTableViewCell)
        let gdsString = cell.gdsLocalisedString
        
        viewModel.resultAction(gdsString)
        XCTAssertEqual(didSetStringKey, "two")
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
