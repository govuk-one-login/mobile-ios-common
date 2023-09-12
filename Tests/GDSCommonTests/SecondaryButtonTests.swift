@testable import GDSCommon
import UIKit
import XCTest

final class SecondaryButtonTests: XCTestCase {
    var sut: SecondaryButton!
    
    override func setUp() {
        super.setUp()
    
        sut = .init()
        sut.setTitle("title", for: .normal)
        sut.icon = "arrow.up.right"
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
}

extension SecondaryButtonTests {
    
    func test_buttonAccessibilityLabel() {
        XCTAssertEqual(sut.accessibilityLabel, "title")
    }
}
