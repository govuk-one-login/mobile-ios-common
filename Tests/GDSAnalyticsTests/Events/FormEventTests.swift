import GDSAnalytics
import XCTest

final class FormEventTests: XCTestCase {
    func testInitialisation() {
        let event = FormEvent(textKey: "Did you start on a computer or tablet?",
                              responseKey: "Yes, I started on a computer or tablet")
        
        XCTAssertEqual(event.name, .formResponse)
        XCTAssertEqual(event.type, .simpleSmartAnswer)
        XCTAssertEqual(event.text, "Did you start on a computer or tablet?")
        XCTAssertEqual(event.response, "Yes, I started on a computer or tablet")
    }
    
    func testParameters() {
        let event = FormEvent(textKey: "Did you start on a computer or tablet?",
                              responseKey: "Yes, I started on a computer or tablet")
        
        XCTAssertEqual(event.parameters, [
            "type": "simple smart answer",
            "text": "did you start on a computer or tablet?",
            "response": "yes, i started on a computer or tablet"
        ])
    }
}
