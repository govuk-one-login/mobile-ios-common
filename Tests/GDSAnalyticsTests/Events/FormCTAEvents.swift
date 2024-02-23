import GDSAnalytics
import XCTest

final class FormCTAEventTests: XCTestCase {
    func testInitialisation() {
        let event = FormCTAEvent(textKey: "Continue")
        
        XCTAssertEqual(event.name, .formResponse)
        XCTAssertEqual(event.type, .callToAction)
        XCTAssertEqual(event.text, "Continue")
    }
    
    func testParameters() {
        let event = FormCTAEvent(textKey: "Continue")
        
        XCTAssertEqual(event.parameters, [
            "text": "continue",
            "type": "call to action"
        ])
    }
}
