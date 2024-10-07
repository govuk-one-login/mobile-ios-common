import SwiftUI
import ViewInspector
import XCTest

final class TextExtensionsTests: XCTestCase {}

extension TextExtensionsTests {
    func test_titleStyle() throws {
        XCTAssertEqual(try Text("").title().inspect().text().attributes().font(), Font.largeTitle.weight(.bold))
        XCTAssertEqual(try Text("").title().inspect().multilineTextAlignment(), .center)
        XCTAssertEqual(try Text("").title().inspect().fixedSize().horizontal, false)
        XCTAssertEqual(try Text("").title().inspect().fixedSize().vertical, true)
    }
    
    func test_subtitleStyle() throws {
        if #available(iOS 14.0, *) {
            XCTAssertEqual(try Text("").subtitle().inspect().text().attributes().font(), Font.title3.weight(.bold))
        } else {
            XCTAssertEqual(try Text("").subtitle().inspect().text().attributes().font(), Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
            XCTAssertEqual(try Text("").subtitle().inspect().text().attributes().fontWeight(), Font.Weight.bold)
        }
    }
    
    func test_bodyCentreAlignedTextStyle() throws {
        XCTAssertEqual(try Text("").bodyCentreAligned().inspect().text().attributes().font(), Font.body)
        XCTAssertEqual(try Text("").bodyCentreAligned().inspect().multilineTextAlignment(), .center)
        XCTAssertEqual(try Text("").bodyCentreAligned().inspect().flexFrame().maxWidth, .infinity)
    }
    
    func test_bodyHeaderTextStyle() throws {
        XCTAssertEqual(try Text("").bodyHeader().inspect().text().attributes().isBold(), true)
        XCTAssertEqual(try Text("").bodyHeader().inspect().fixedSize().horizontal, false)
        XCTAssertEqual(try Text("").bodyHeader().inspect().fixedSize().vertical, true)
    }
    
    func test_calloutBoldTextStyle() throws {
        XCTAssertEqual(try Text("").calloutBold().inspect().text().attributes().isBold(), true)
        XCTAssertEqual(try Text("").calloutBold().inspect().fixedSize().horizontal, false)
        XCTAssertEqual(try Text("").calloutBold().inspect().fixedSize().vertical, true)
        XCTAssertEqual(try Text("").calloutBold().inspect().text().attributes().font(), .callout)
    }
}
