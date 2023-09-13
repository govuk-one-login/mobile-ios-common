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
    func test_buttonAccessibilityBackground() throws {
        sut.accessibilityElementDidBecomeFocused()
        XCTAssertEqual(sut.backgroundColor, .gdsYellow)
        XCTAssertEqual(sut.currentTitleColor, .black)
        
        sut.accessibilityElementDidLoseFocus()
        XCTAssertEqual(sut.backgroundColor, .gdsGreen)
        XCTAssertEqual(sut.currentTitleColor, .white)
    }
    
    func test_initialLoadingState() throws {
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.isTitleHidden)
        XCTAssertTrue(sut.isEnabled)
    }
    
    func test_tappedLoadingState() throws {
        sut.isLoading = true
        XCTAssertTrue(sut.isLoading)
        XCTAssertTrue(sut.isTitleHidden)
        XCTAssertFalse(sut.isEnabled)
    }
    
    func test_tappedTwiceLoadingState() throws {
        sut.isLoading = true
        sut.isLoading = false
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.isTitleHidden)
        XCTAssertTrue(sut.isEnabled)
    }
}
