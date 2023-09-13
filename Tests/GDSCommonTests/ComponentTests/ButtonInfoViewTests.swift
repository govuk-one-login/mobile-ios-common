import GDSCommon
import SwiftUI
import ViewInspector
import XCTest

final class ButtonInfoViewTests: XCTestCase {
    var sut: ButtonInfoView!

    override func setUp() {
        super.setUp()

        sut = .init(viewModel: PreviewButtonInfoViewModel())
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }
}

extension ButtonInfoViewTests {
    func test_textFixedSize() throws {
        let textViews = try sut.body.inspect()
            .findAll(Text.self)

        XCTAssertEqual(textViews.count, 3)
        XCTAssertEqual(try textViews[1].fixedSize().horizontal, false)
        XCTAssertEqual(try textViews[1].fixedSize().vertical, true)
    }
}
