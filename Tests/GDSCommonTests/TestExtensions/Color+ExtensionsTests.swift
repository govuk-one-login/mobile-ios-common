@testable import GDSCommon
import SwiftUI
import UIKit
import XCTest

final class ColorExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

extension ColorExtensionsTests {
    func test_colors() throws {
        for color in UIColor.GDSColours.allCases {
            XCTAssertNotNil(Color(color))
            
            // These tests compare SwiftUI `Color` against the UIKit color via RGBA
            // components. The idea being to ensure that the two do not deviate.
            if #available(iOS 14.0, *) {
                colourTest(swiftUIColor: Color(color), assetColor: color.rawValue)
            }
        }
    }
    
    @available(iOS 14.0, *)
    fileprivate func colourTest(swiftUIColor: Color, assetColor: String) {
        for i in 0..<4 {
            XCTAssertEqual(Float(UIColor(swiftUIColor).cgColor.components?[i] ?? 0),
                           Float(UIColor(named: assetColor, in: .module, compatibleWith: .none)?.cgColor.components?[i] ?? 0),
                           accuracy: 0.0001,
                           "\(RGBAnames(rawValue: i)?.rawValue ?? "") failed to match SwiftUI Color \(swiftUIColor) with asset colour: \"\(assetColor),\"")
        }
    }
    
    enum RGBAnames: String {
        case red = "RED component: "
        case green = "GREEN component: "
        case blue = "BLUE component: "
        case alpha = "ALPHA component: "
        
        init?(rawValue: Int) {
            switch rawValue {
            case 0:
                self = .red
            case 1:
                self = .green
            case 2:
                self = .blue
            case 3:
                self = .alpha
            default:
                return nil
            }
        }
    }
}
