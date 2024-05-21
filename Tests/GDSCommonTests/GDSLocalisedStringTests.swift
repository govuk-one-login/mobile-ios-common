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

    func test_attributedString_stringLiteralInitialiser() {
        sut = .init(stringLiteral: "stringLiteralInitialiser",
                    attributes: [("Literal", [.font: UIFont.bodyBold])])
        XCTAssertNotNil(sut.attributedValue)
    }
    
    func test_attributedString_firstNonStringLiteralInitialiser() throws {
        sut = .init(stringKey: "firstNonStringLiteral", "one", "two", "three",
                    attributes: [("Literal", [.font: UIFont.bodyBold])])
        
        XCTAssertEqual(sut.value, "firstNonStringLiteral")
        XCTAssertNotNil(sut.attributedValue)
    }
    
    func test_attributedString_secondNonStringLiteralInitialiser() throws {
        sut = .init(stringKey: "secondNonStringLiteral",
                    variableKeys: ["one", "two", "three"],
                    attributes: [("Literal", [.font: UIFont.bodyBold])])
        
        XCTAssertEqual(sut.value, "secondNonStringLiteral")
        XCTAssertNotNil(sut.attributedValue)
    }

    func test_attributedString_isNil() {
        sut = .init(stringLiteral: "stringLiteralInitialiser")
        XCTAssertNil(sut.attributedValue)
    }
    
    func test_attributedString_withEmptyArray() {
        sut = .init(stringLiteral: "stringLiteralInitialiser",
                    attributes: [])
        XCTAssertNil(sut.attributedValue)
    }
}

extension GDSLocalisedStringTests {
    func test_equatable() {
        let stringOne = GDSLocalisedString(stringKey: "firstNonStringLiteral", "one", "two", "three")
        XCTAssertEqual(stringOne, stringOne)
        
        let stringTwo = GDSLocalisedString(stringKey: "secondNonStringLiteral", "one", "two", "three")
        let stringThree = GDSLocalisedString(stringKey: "firstNonStringLiteral", "one", "two", "three", "four")
        XCTAssertNotEqual(stringOne, stringTwo)
        XCTAssertNotEqual(stringOne, stringThree)
    }
}
