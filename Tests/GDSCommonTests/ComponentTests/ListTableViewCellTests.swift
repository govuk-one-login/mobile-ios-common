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

    private func accessibilitySetup() {
        sut = .init(gdsLocalisedString: gdsString, accessibilityLabel: gdsString.value, accessibilityHint: "option 1", accessibilityTraits: .button)
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

    func testCellAccessibilityElements() {
        accessibilitySetup()
        XCTAssertEqual(sut.gdsLocalisedString.value, "test string")
        XCTAssertEqual(sut.accessibilityLabel, "test string")
        XCTAssertEqual(sut.accessibilityHint, "option 1")
        XCTAssertEqual(sut.accessibilityTraits, .button)
    }
}
