import GDSAnalytics
import XCTest

final class ScreenViewTests: XCTestCase {
    func testInitialisation() {
        let view = ScreenView(screen: MockScreen.welcome,
                              titleKey: "Welcome to this app")
        
        XCTAssertEqual(view.screen, MockScreen.welcome)
        XCTAssertEqual(view.title, "Welcome to this app")
    }
    
    func testParameters() {
        let view = ScreenView(screen: MockScreen.welcome,
                              titleKey: "Welcome to this app")
        
        XCTAssertEqual(view.parameters, [
            "title": "welcome to this app"
        ])
    }
    
    func testParameterTruncation() {
        let view = ScreenView(screen: MockScreen.welcome,
                              titleKey: "Welcome to this app with a really really really really really really really really really really long name")
        
        XCTAssertEqual(view.parameters, [
            "title": "welcome to this app with a really really really really really really really really really really lon"
        ])
    }
}
