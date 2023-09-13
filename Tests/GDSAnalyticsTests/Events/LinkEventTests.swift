import GDSAnalytics
import XCTest

final class LinkEventTests: XCTestCase {
    func testInitialisation() {
        let event = LinkEvent(textKey: "Open GOV.UK",
                              linkDomain: "https://www.gov.uk",
                              external: .true)
        
        XCTAssertEqual(event.name, .navigation)
        XCTAssertEqual(event.type, .genericLink)
        XCTAssertEqual(event.text, "Open GOV.UK")
        XCTAssertEqual(event.external, .true)
        XCTAssertEqual(event.linkDomain, "https://www.gov.uk")
    }
    
    func testParameters() {
        let event = LinkEvent(textKey: "Open GOV.UK",
                              linkDomain: "https://www.gov.uk",
                              external: .true)
        
        XCTAssertEqual(event.parameters, [
            "link_domain": "https://www.gov.uk",
            "external": "true",
            "text": "open gov.uk",
            "type": "generic link"
        ])
    }
}
