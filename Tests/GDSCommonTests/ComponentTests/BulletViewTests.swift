import GDSCommon
import XCTest

internal final class BulletViewTests: XCTestCase {
    var sut: BulletView!
    
    override func setUp() {
        super.setUp()

        sut = .init(title: "exampleTitle",
                    titleFont: .init(style: .title2, weight: .bold),
                    text: ["one", "two", "three"])
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
