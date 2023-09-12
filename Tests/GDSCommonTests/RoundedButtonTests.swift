@testable import GDSCommon
import UIKit
import XCTest

final class GDSButtonTests: XCTestCase {
    var sut: RoundedButton!
    
    override func setUp() {
        super.setUp()
        
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
}

extension GDSButtonTests {
    func test_buttonAccessibilityBackground() {
        sut.accessibilityElementDidBecomeFocused()
        XCTAssertEqual(sut.backgroundColor, .gdsYellow)
        XCTAssertEqual(sut.currentTitleColor, .black)
        
        sut.accessibilityElementDidLoseFocus()
        XCTAssertEqual(sut.backgroundColor, .gdsGreen)
        XCTAssertEqual(sut.currentTitleColor, .white)
    }
}
