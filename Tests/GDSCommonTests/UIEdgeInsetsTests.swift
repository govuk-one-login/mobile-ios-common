@testable import GDSCommon
import UIKit
import XCTest

final class UIEdgeInsetsTests: XCTestCase {
    func testEdgeInsets() {
        let edgeInsets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        
        XCTAssertEqual(edgeInsets.horizontal, 6)
        XCTAssertEqual(edgeInsets.vertical, 4)
    }
}
