@testable import GDSCommon
import SwiftUI
import UIKit
import XCTest

/// This test ensures each colour object that is added to the `GDSColours` enum is not null
final class UIColorTests: XCTestCase {
    func test_gdsColoursUIColors() {
        UIColor.GDSColours.allCases.forEach {
            XCTAssertNotNil(UIColor(named: $0.rawValue, in: .module, compatibleWith: nil), "failed on color: \($0)")
        }
    }
    
    func test_gdsColoursSwiftUIColors() {
        UIColor.GDSColours.allCases.forEach {
            XCTAssertNotNil(Color($0.rawValue, bundle: .module), "failed on color: \($0)")
        }
    }
}
