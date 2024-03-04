import GDSAnalytics
import XCTest

final class IconEventTests: XCTestCase {
    func testInitialisation() {
        let event = IconEvent(textKey: "Continue")
        
        XCTAssertEqual(event.name, .navigation)
        XCTAssertEqual(event.type, .icon)
        XCTAssertEqual(event.text, "Continue")
    }
    
    func testParameters() {
        let event = IconEvent(textKey: "Continue")
        
        XCTAssertEqual(event.parameters, [
            "text": "continue",
            "type": "icon"
        ])
    }
}
