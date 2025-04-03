import GDSCommon
import XCTest

internal final class BulletViewTests: XCTestCase {
    var sut: BulletView!
    
    override func setUp() {
        super.setUp()

        sut = .init(title: "exampleTitle",
                    text: ["one", "two", "three"],
                    titleFont: .init(style: .title2, weight: .bold))
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
}

extension BulletViewTests {
    func test_bulletContents() throws {
        try XCTAssertEqual("\t●\tone", sut.bulletLabels[0].text)
        try XCTAssertEqual("\t●\ttwo", sut.bulletLabels[1].text)
        try XCTAssertEqual("\t●\tthree", sut.bulletLabels[2].text)
    }
    
    func test_titleContents() throws {
        try XCTAssertEqual(sut.titleLabel.attributedText?.string, "exampleTitle")
        try XCTAssertTrue(sut.titleLabel.accessibilityTraits.contains(.header))
    }
    
    @MainActor
    func test_initWithViewModel() {
        struct MockBulletViewModel: BulletViewModel {
            let title: String? = nil
            let titleFont: UIFont? = .init(style: .title2, weight: .bold)
            let text = ["bullet 1",
                       "bullet 2",
                       "bullet 3",
                       "bullet 4"]
        }
        let mockVM = MockBulletViewModel()
        sut = BulletView(viewModel: mockVM)
        
        try XCTAssertNil(sut.titleLabel.text)
        try XCTAssertTrue(sut.titleLabel.isHidden)
        
        try XCTAssertEqual("\t●\tbullet 1", sut.bulletLabels[0].text)
        try XCTAssertEqual("\t●\tbullet 2", sut.bulletLabels[1].text)
        try XCTAssertEqual("\t●\tbullet 3", sut.bulletLabels[2].text)
        try XCTAssertEqual("\t●\tbullet 4", sut.bulletLabels[3].text)
    }
    
    func test_initWithDefaultTitleFont() {
        sut = BulletView(title: "Title", text: ["bullet 1", "bullet 2", "bullet 3", "bullet 4"])
        try XCTAssertEqual(sut.titleLabel.text, "Title")
        try XCTAssertEqual(sut.titleLabel.font, .init(style: .title3, weight: .semibold))
    }
    
    @MainActor
    func test_viewModelIsScreenBodyItem() async throws {
        let viewModel = MockBulletViewModel(title: "title", text: ["item 1", "item 2", "item 3"])
        XCTAssert(viewModel.uiView is BulletView)
        let view = try XCTUnwrap(viewModel.uiView as? BulletView)
    }
}

extension BulletView {
    internal var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(self[child: "bullet-title"])
        }
    }
    
    internal var bulletLabels: [UILabel] {
        get throws {
            let stack = try XCTUnwrap(self[child: "bullet-stack"]) as UIStackView
            return try XCTUnwrap(stack.arrangedSubviews as? [UILabel])
        }
    }
}
