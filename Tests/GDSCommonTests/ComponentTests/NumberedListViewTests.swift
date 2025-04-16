import GDSCommon
import XCTest

@MainActor
final class NumberedListViewTests: XCTestCase {
    var viewModel: NumberedListViewModel!
    var sut: NumberedListView!
    
    override func setUp() {
        super.setUp()
        
        viewModel = MockNumberedListViewModel()
        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

extension NumberedListViewTests {
    func test_numberedListViewTitle() throws {
        XCTAssertEqual(try sut.titleLabel.text, "numbered list test title")
    }
    
    func test_numberedListViewRowOneNumber() throws {
        let rowNumber = try sut.listRow(index: 0).arrangedSubviews[0] as? UILabel
        XCTAssertEqual(rowNumber?.text, "1.")
        XCTAssertEqual(rowNumber?.font, .body)
        XCTAssertEqual(rowNumber?.textAlignment, .right)
        XCTAssertEqual(rowNumber?.adjustsFontForContentSizeCategory, true)
    }
    
    func test_numberedListViewRowOneLabel() throws {
        let rowLabel = try sut.listRow(index: 0).arrangedSubviews[1] as? UILabel
        XCTAssertEqual(rowLabel?.text, "test numbered list element 1")
        XCTAssertEqual(rowLabel?.font, .body)
        XCTAssertEqual(rowLabel?.textAlignment, .left)
        XCTAssertEqual(rowLabel?.adjustsFontForContentSizeCategory, true)
        XCTAssertEqual(rowLabel?.numberOfLines, 0)
    }
    
    func test_numberedListViewRowTwoNumber() throws {
        let rowNumber = try sut.listRow(index: 1).arrangedSubviews[0] as? UILabel
        XCTAssertEqual(rowNumber?.text, "2.")
        XCTAssertEqual(rowNumber?.font, .body)
        XCTAssertEqual(rowNumber?.textAlignment, .right)
        XCTAssertEqual(rowNumber?.adjustsFontForContentSizeCategory, true)
    }
    
    func test_numberedListViewRowTwoLabel() throws {
        let rowLabel = try sut.listRow(index: 1).arrangedSubviews[1] as? UILabel
        XCTAssertEqual(rowLabel?.text, "test numbered list element 2")
        XCTAssertEqual(rowLabel?.font, .body)
        XCTAssertEqual(rowLabel?.textAlignment, .left)
        XCTAssertEqual(rowLabel?.adjustsFontForContentSizeCategory, true)
        XCTAssertEqual(rowLabel?.numberOfLines, 0)
    }
    
    func test_numberedListViewRowThreeNumber() throws {
        let rowNumber = try sut.listRow(index: 2).arrangedSubviews[0] as? UILabel
        XCTAssertEqual(rowNumber?.text, "3.")
        XCTAssertEqual(rowNumber?.font, .body)
        XCTAssertEqual(rowNumber?.textAlignment, .right)
        XCTAssertEqual(rowNumber?.adjustsFontForContentSizeCategory, true)
    }
    
    func test_numberedListViewRowThreeLabel() throws {
        let rowLabel = try sut.listRow(index: 2).arrangedSubviews[1] as? UILabel
        XCTAssertEqual(rowLabel?.text, "test numbered list element 3")
        XCTAssertEqual(rowLabel?.font, .body)
        XCTAssertEqual(rowLabel?.textAlignment, .left)
        XCTAssertEqual(rowLabel?.adjustsFontForContentSizeCategory, true)
        XCTAssertEqual(rowLabel?.numberOfLines, 0)
    }
}

extension NumberedListView {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(self[child: "numbered-list-title"])
        }
    }
    
    func listRow(index: Int) throws -> UIStackView {
        return try XCTUnwrap(
            self[child: "numbered-list-row-stack-view-\(index)"] as? UIStackView
        )
    }
}
