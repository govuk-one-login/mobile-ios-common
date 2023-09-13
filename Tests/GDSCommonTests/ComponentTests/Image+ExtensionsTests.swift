import SwiftUI
import ViewInspector
import XCTest

final class ImageExtensionsTests: XCTestCase {
    func test_iconImage() throws {
        let sut = Image(systemName: "sun.min")
        XCTAssertEqual(try sut.iconImage().inspect().font(), Font.body.weight(.light))
        XCTAssertEqual(try sut.iconImage().inspect().isScaledToFit(), true)
        XCTAssertEqual(try sut.iconImage().inspect().imageScale(), .large)
    }
}
