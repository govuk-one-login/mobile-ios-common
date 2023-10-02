@testable import GDSCommon
import XCTest

final class ListTableViewCellTests: XCTestCase {
    var sut: ListTableViewCell!
    var gdsString: GDSLocalisedString!
    
    override func setUp() {
        super.setUp()
        
        gdsString = .init(stringLiteral: "test string")
        sut = .init(ListTableViewCell(gdsLocalisedString: gdsString))
    }
    
    override func tearDown() {
        gdsString = nil
        sut = nil
        
        super.tearDown()
    }
}

extension ListTableViewCellTests {
    func testSettingLabel() {
        XCTAssertEqual(sut.gdsLocalisedString.value, "test string")
        XCTAssertEqual(sut.textLabel?.text, "test string")
        
        sut.gdsLocalisedString = GDSLocalisedString(stringLiteral: "new string")
        XCTAssertEqual(sut.textLabel?.text, "new string")
    }
    
    func testSetSelected() {
        XCTAssertEqual(sut.accessoryType, .none)
        sut.setSelected(true, animated: false)
        XCTAssertEqual(sut.accessoryType, .checkmark)
        sut.setSelected(false, animated: false)
        XCTAssertEqual(sut.accessoryType, .none)
    }
}
