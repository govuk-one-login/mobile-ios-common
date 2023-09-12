import GDSAnalytics
import XCTest

final class ButtonEventTests: XCTestCase {
    func testInitialisation() {
        let event = ButtonEvent(textKey: "Continue")
        
        XCTAssertEqual(event.name, .navigation)
        XCTAssertEqual(event.type, .submitForm)
        XCTAssertEqual(event.text, "Continue")
    }
    
    func testParameters() {
        let event = ButtonEvent(textKey: "Continue")
        
        XCTAssertEqual(event.parameters, [
            "text": "continue",
            "type": "submit form"
        ])
    }
}
