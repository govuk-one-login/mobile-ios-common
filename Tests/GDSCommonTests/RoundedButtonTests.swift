@testable import GDSCommon
import UIKit
import XCTest

final class GDSButtonTests: XCTestCase {
    var sut: RoundedButton!
    var didTapButton: Bool!

    override func setUp() {
        super.setUp()
        didTapButton = false
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
        didTapButton = nil

        super.tearDown()
    }
}

extension GDSButtonTests {
    func test_buttonAccessibilityBackground() throws {
        sut.handleFocus(isFocused: true)
        XCTAssertEqual(sut.backgroundColor, .gdsYellow)
        XCTAssertEqual(sut.currentTitleColor, .black)
        
        sut.handleFocus(isFocused: false)
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

    @available(iOS 14, *)
    func test_buttonUIAction() {
        let action = UIAction { _ in
            self.didTapButton = true
        }

        sut = RoundedButton(action: action)

        XCTAssertFalse(didTapButton)
        sut.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapButton)
    }
}
