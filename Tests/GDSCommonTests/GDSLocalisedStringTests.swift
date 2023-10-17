@testable import GDSCommon
import XCTest

final class GDSLocalisedStringTests: XCTestCase {
    var sut: GDSLocalisedString!
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
}

extension GDSLocalisedStringTests {
    func test_stringLiteralInitialiser() throws {
        sut = .init(stringLiteral: "stringLiteralInitialiser")
        
        XCTAssertEqual(sut.value, "stringLiteralInitialiser")
    }
    
    func test_firstNonStringLiteralInitialiser() throws {
        sut = .init(stringKey: "firstNonStringLiteral", "one", "two", "three")
        
        XCTAssertEqual(sut.value, "firstNonStringLiteral")
    }
    
    func test_secondNonStringLiteralInitialiser() throws {
        sut = .init(stringKey: "secondNonStringLiteral", variableKeys: ["one", "two", "three"])
        
        XCTAssertEqual(sut.value, "secondNonStringLiteral")
    }
    
    func test_descriptionProperty() throws {
        sut = .init(stringLiteral: "stringLiteralInitialiser")
        
        XCTAssertEqual(sut.description, "stringLiteralInitialiser")
    }
    
    func test_attributedString() {
        sut = .init(stringLiteral:  "stringLiteralInitialiser",
                    attributes: [("Literal",[.font: UIFont.bodyBold])])
        XCTAssertNotNil(sut.attributedValue)
    }
    
    func test_attributedStringIsNil() {
        sut = .init(stringLiteral:  "stringLiteralInitialiser")
        XCTAssertNil(sut.attributedValue)
    }
    
    func test_attributedStringWithEmptyArray() {
        sut = .init(stringLiteral:  "stringLiteralInitialiser",
                    attributes: [])
        XCTAssertNil(sut.attributedValue)
    }
}
