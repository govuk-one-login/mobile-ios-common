import XCTest

final class UInt64Tests: XCTestCase {
    func testTwoSecondsFromNanoSeconds() {
        let expectation: UInt64 = .twoSeconds
        
        XCTAssertEqual(expectation, 2_000_000_000)
    }
}
