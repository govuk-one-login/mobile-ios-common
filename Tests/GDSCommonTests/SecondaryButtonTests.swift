@testable import GDSCommon
import UIKit
import XCTest

final class SecondaryButtonTests: XCTestCase {
    var sut: SecondaryButton!
    var didTapButton: Bool!

    override func setUp() {
        super.setUp()
    
        sut = .init()
        sut.setTitle("title", for: .normal)
        sut.icon = "arrow.up.right"
        didTapButton = false
    }
    
    override func tearDown() {
        sut = nil
        didTapButton = nil

        super.tearDown()
    }
}

extension SecondaryButtonTests {
    
    func test_buttonDefaultState() {
        XCTAssertEqual(sut.titleLabel?.font, UIFont(style: .body, weight: .regular))
    }
    
    func test_buttonAccessibilityLabel() {
        XCTAssertEqual(sut.accessibilityLabel, "title")
    }
    
    func test_buttonBackground_withKeyboardFocus() throws {
        sut.handleFocus(isFocused: true)
        XCTAssertEqual(sut.backgroundColor, .gdsYellow)
        XCTAssertEqual(sut.currentTitleColor, .black)
        XCTAssertEqual(sut.layer.cornerRadius, 4)
        
        sut.handleFocus(isFocused: false)
        XCTAssertEqual(sut.backgroundColor, .none)
        XCTAssertEqual(sut.currentTitleColor, .accent)
    }

    @available(iOS 14, *)
    func test_buttonUIAction() {
        let action = UIAction { _ in
            self.didTapButton = true
        }

        sut = SecondaryButton(action: action)

        XCTAssertFalse(didTapButton)
        sut.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapButton)
    }
}
