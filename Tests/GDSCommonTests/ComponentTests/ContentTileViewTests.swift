import GDSCommon
import XCTest

internal final class ContentTileViewTests: XCTestCase {
    var sut: ContentTileView!
    var viewModel: ContentTile!
    
    var didTapPrimaryButton: Bool = false
    var didTapSecondaryButton: Bool = false
    var didTapCloseButton: Bool = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        viewModel = MockContentTileViewModel(secondaryButtonViewModel: MockButtonViewModel(title: "test secondary button",
                                                                                           action: {
            self.didTapSecondaryButton = true
        }),
                                             primaryButtonViewModel: MockButtonViewModel(title: "test primary button", 
                                                                                         action: {
            self.didTapPrimaryButton = true
        }),
                                             closeButton: MockButtonViewModel(title: "test close button",
                                                                              action: {
            self.didTapCloseButton = true
        }))
        
        sut = .init(frame: .zero, viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
}

@MainActor
extension ContentTileViewTests {
    func test_closeContents() throws {
        let font = UIFont(style: .body, weight: .regular)
        let config = UIImage.SymbolConfiguration(font: font, scale: .default)
        
        XCTAssertEqual(try sut.closeButton.image(for: .normal), UIImage(systemName: "xmark", withConfiguration: config))
        XCTAssertEqual(try sut.closeButton.tintColor, .gdsGreen)
    }
    
    func test_captionContents() {
        XCTAssertEqual(try sut.captionLabel.text, viewModel.caption.value)
        XCTAssertEqual(try sut.captionLabel.font, UIFont(style: .subheadline))
    }
    
    func test_titleContents() {
        XCTAssertEqual(try sut.titleLabel.text, viewModel.title.value)
        XCTAssertEqual(try sut.titleLabel.font, UIFont(style: .body, weight: .bold))
    }
    
    func test_bodyContents() {
        XCTAssertEqual(try sut.bodyLabel.text, viewModel.body.value)
        XCTAssertEqual(try sut.bodyLabel.font, UIFont(style: .body))
    }
    
    func test_separatorView() {
        XCTAssertNotNil(try sut.divider)
    }
    
    func test_primaryButton() throws {
        XCTAssertEqual(try sut.primaryButton.titleLabel?.text, viewModel.primaryButtonViewModel.title.value)
        
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapPrimaryButton)
    }
    
    func test_secondaryButton() throws {
        XCTAssertEqual(try sut.secondaryButton.titleLabel?.text, viewModel.secondaryButtonViewModel.title.value)
        XCTAssertEqual(try sut.secondaryButton.titleLabel?.textColor, UIColor.gdsGreen)
        XCTAssertEqual(try sut.secondaryButton.icon, "arrow.up.right")
        
        try sut.secondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapSecondaryButton)
    }

}

extension ContentTileView {
    var image: UIImageView {
        get throws {
            try XCTUnwrap(self[child: "content-tile-image"])
        }
    }
    
    var captionLabel: UILabel {
        get throws {
            try XCTUnwrap(self[child: "content-tile-caption"])
        }
    }
    
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(self[child: "content-tile-title"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(self[child: "content-tile-body"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(self[child: "content-secondary-button"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(self[child: "content-primary-button"])
        }
    }
    
    var closeButton: UIButton {
        get throws {
            try XCTUnwrap(self[child: "content-close-button"])
        }
    }
    
    var divider: UIStackView {
        get throws {
            try XCTUnwrap(self[child: "content-tile-separator"])
        }
    }
}
