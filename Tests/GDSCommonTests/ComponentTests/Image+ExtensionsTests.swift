import SwiftUI
import ViewInspector
import XCTest

final class ImageExtensionsTests: XCTestCase {
    func test_iconImage() throws {
        let sut = Image(systemName: "sun.min")
        XCTAssertEqual(
            try sut.iconImage().inspect().implicitAnyView().image().font(),
            Font.body.weight(.light)
        )
        XCTAssertEqual(try sut.iconImage().inspect().implicitAnyView().image().isScaledToFit(), true)
        XCTAssertEqual(try sut.iconImage().inspect().implicitAnyView().image().imageScale(), .large)
    }
}
