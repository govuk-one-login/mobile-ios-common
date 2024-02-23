import GDSAnalytics
import XCTest

final class ActionMenuEventTests: XCTestCase {
    func testInitialisation() {
        let event = ActionMenuEvent(textKey: "Continue")
        
        XCTAssertEqual(event.name, .popup)
        XCTAssertEqual(event.type, .actionMenu)
        XCTAssertEqual(event.text, "Continue")
    }
    
    func testParameters() {
        let event = ActionMenuEvent(textKey: "Continue")
        
        XCTAssertEqual(event.parameters, [
            "text": "continue",
            "type": "action menu"
        ])
    }
}
