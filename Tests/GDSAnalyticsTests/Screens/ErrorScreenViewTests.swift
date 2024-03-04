import GDSAnalytics
import XCTest

final class ErrorScreenViewTests: XCTestCase {
    func testInitialisation() {
        let view = ErrorScreenView(screen: MockScreen.error,
                                   titleKey: "Something went wrong")
        
        XCTAssertEqual(view.screen, MockScreen.error)
        XCTAssertEqual(view.title, "Something went wrong")
    }
    
    func testEmptyParametersAreRemoved() {
        let uuid = UUID().uuidString.lowercased()

        let view = ErrorScreenView(id: uuid,
                                   screen: MockScreen.error,
                                   titleKey: "Something went wrong")
        
        XCTAssertEqual(view.parameters, [
            "title": "something went wrong",
            "screen_id": uuid
        ])
    }
    
    struct MockError: LoggableError {
        let reason: String? = "server"
        let endpoint: String? = "fetchBiometricToken"
        let hash: String? = "83766358f64858b51afb745bbdde91bb"
        let statusCode: String? = "429"
    }
    
    func testParametersForError() {
        let uuid = UUID().uuidString.lowercased()
        let view = ErrorScreenView(id: uuid,
                                   screen: MockScreen.error,
                                   titleKey: "Something went wrong",
                                   error: MockError())
        XCTAssertEqual(view.parameters, [
            "title": "something went wrong",
            "screen_id": uuid,
            "hash": "83766358f64858b51afb745bbdde91bb",
            "reason": "server",
            "endpoint": "fetchbiometrictoken",
            "status": "429"])
    }
    
    func testParametersForValues() {
        let uuid = UUID().uuidString.lowercased()

        let view = ErrorScreenView(id: uuid,
                                   screen: MockScreen.error,
                                   titleKey: "Something went wrong",
                                   reason: "network",
                                   endpoint: "appInfo",
                                   statusCode: "401",
                                   hash: "83766358f64858b51afb745bbdde91bb"
        )
        
        XCTAssertEqual(view.parameters, [
            "title": "something went wrong",
            "screen_id": uuid,
            "reason": "network",
            "endpoint": "appinfo",
            "status": "401",
            "hash": "83766358f64858b51afb745bbdde91bb"
        ])
    }
}
