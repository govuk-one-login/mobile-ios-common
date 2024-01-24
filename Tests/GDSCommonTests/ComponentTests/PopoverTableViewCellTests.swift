@testable import GDSCommon
import XCTest

final class PopoverTableViewCellTests: XCTestCase {
    var sut: PopoverTableViewController!
    
    var didSelectItem: Bool = false
    
    override func setUp() {
        super.setUp()
        
        let item = MockPopoverItemViewModel(title: "Title", titleFont: .body, icon: "Icon", tint: .black) {
            
        }
        sut = PopoverTableViewController(items: [item])
        
        attachToWindow(viewController: sut)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
}

extension PopoverTableViewCellTests {
    func test_tableviewExists() {
        XCTAssertNotNil(try sut.tableView)
    }
    
    func test_rowIsCorrectCell() throws {
        let tableview = try sut.tableView
        
        let cell = tableview.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is PopoverTableViewCell)
    }
    
    func test_rowHasCorrectOutlets() throws {
        let tableview = try sut.tableView
        
        let cell = tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as? PopoverTableViewCell
        XCTAssertEqual(try cell?.titleLabel.text, "Title")
    }
}

extension PopoverTableViewController {
    internal var tableView: UITableView {
        get throws {
            try XCTUnwrap(view[child: "table-view"])
        }
    }
}

extension PopoverTableViewCell {
    internal var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(self[child: "title-label"])
        }
    }
    
    internal var iconView: UIImageView {
        get throws {
            try XCTUnwrap(self[child: "icon-view"])
        }
    }
}
