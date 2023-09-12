import GDSAnalytics
import XCTest

final class PopupEventTests: XCTestCase {
    func testInitialisation() {
        let event = PopupEvent(textKey: "Continue")
        
        XCTAssertEqual(event.name, .popup)
        XCTAssertEqual(event.type, .callToAction)
        XCTAssertEqual(event.text, "Continue")
    }
    
    func testParameters() {
        let event = PopupEvent(textKey: "Continue")
        
        XCTAssertEqual(event.parameters, [
            "text": "continue",
            "type": "call to action"
        ])
    }
}
