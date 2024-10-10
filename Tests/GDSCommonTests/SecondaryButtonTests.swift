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
    
    func test_buttonAccessibilityLabel() {
        XCTAssertEqual(sut.accessibilityLabel, "title")
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
    
    @MainActor
    func test_fallBackButton() {
        let fallBackButton = FallBackButtonViewModel.primary
        XCTAssertEqual(fallBackButton.title.value, "Action bxutton")
        XCTAssertNil(fallBackButton.icon)
        XCTAssertFalse(fallBackButton.shouldLoadOnTap)
        fallBackButton.action()
    }
}
