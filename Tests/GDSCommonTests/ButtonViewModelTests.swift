@testable import GDSCommon
import XCTest

@MainActor
final class ButtonViewModelTests: XCTestCase {
    var sut: ButtonViewModel!
    
    var didTapButton = false
    
    override func setUp() {
        super.setUp()
        sut = MockButtonViewModel(title: "test title") {
            self.didTapButton = true
        }
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func test_voiceoverhint() {
        XCTAssertNil(sut.accessibilityHint)
        
        sut = TestButtonViewModel(title: "test title",
                                  action: { },
                                  accessibilityHint: "test voiceover hint")
        
        XCTAssertNotNil(sut.accessibilityHint)
        XCTAssertEqual(sut.accessibilityHint?.value, "test voiceover hint")
    }
}

struct TestButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString
    let icon: ButtonIconViewModel? = nil
    let shouldLoadOnTap: Bool = false
    let action: () -> Void
    let accessibilityHint: GDSLocalisedString?
}
