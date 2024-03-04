import GDSAnalytics
import XCTest

final class ScreenViewTests: XCTestCase {
    func testInitialisation() {
        let view = ScreenView(screen: MockScreen.welcome,
                              titleKey: "Welcome to this app")
        
        XCTAssertEqual(view.screen, MockScreen.welcome)
        XCTAssertEqual(view.title, "welcome to this app")
    }
    
    func testParameters() {
        let uuid = UUID().uuidString.lowercased()

        let view = ScreenView(id: uuid,
                              screen: MockScreen.welcome,
                              titleKey: "welcome to this app")
        
        XCTAssertEqual(view.parameters, [
            "title": "welcome to this app",
            "screen_id": uuid
        ])
    }
    
    
    func testParameterTruncation() {
        let view = ScreenView(screen: MockScreen.welcome,
                              titleKey: "Welcome to this app with a really really really really really really really really really really long name")

        XCTAssertEqual(view.title, "welcome to this app with a really really really really really really really really really really lon")
        
        XCTAssertEqual(view.parameters, [ "title": "welcome to this app with a really really really really really really really really really really lon"])
    }
}
