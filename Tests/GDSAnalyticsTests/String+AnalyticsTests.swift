@testable import GDSAnalytics
import XCTest

final class StringExtensionTests: XCTestCase {
    func testParameterFormattingConvertsToLowercases() {
        let test = "TEST String XYZ"
        XCTAssertEqual(test.formattedAsParameter,
                       "test string xyz")
    }
    
    func testParameterFormattingTruncatesTo100Characters() {
        let test = "this is a string that is more than 100 characters. this is a string that is more than 100 characters."
        XCTAssertEqual(test.formattedAsParameter,
                       "this is a string that is more than 100 characters. this is a string that is more than 100 characters")
    }
    
    func testEnglishString_findsBundle() {
        let test = "GDSCommonTestString"
        let englishString = test.englishString(bundle: .module)
        XCTAssertEqual(englishString, "Test")
    }
    
    func testEnglishString_doesntFindBundle() {
        let test = "GDSCommonTestString"
        let englishString = test.englishString(bundle: .main)
        XCTAssertNotEqual(englishString, "Test")
    }

}
