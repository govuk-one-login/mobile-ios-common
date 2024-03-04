import GDSAnalytics
import XCTest

final class FormActionMenuEventTests: XCTestCase {
    func testInitialisation() {
        let event = FormActionMenuEvent(textKey: "Continue")
        
        XCTAssertEqual(event.name, .formResponse)
        XCTAssertEqual(event.type, .actionMenu)
        XCTAssertEqual(event.text, "Continue")
    }
    
    func testParameters() {
        let event = FormActionMenuEvent(textKey: "Continue")
        
        XCTAssertEqual(event.parameters, [
            "text": "continue",
            "type": "action menu"
        ])
    }
}
