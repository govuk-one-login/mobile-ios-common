import XCTest

final class StringExtensionsDateFormatTests: XCTestCase {
    func test_successfulDateFormat() {
        let inputString = "990215"
        let targetString = "15.Feb.99"
        
        let result = inputString.formatDate()
        
        XCTAssertEqual(targetString, result)
    }
    
    func test_unsuccessfulDateFormat() {
        let inputString = "990230"
        let targetString = "-"
        
        let result = inputString.formatDate()
        
        XCTAssertEqual(targetString, result)
    }
}
