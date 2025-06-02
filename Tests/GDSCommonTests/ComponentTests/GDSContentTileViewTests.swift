import GDSCommon
import XCTest

final class GDSContentTileViewTests: XCTestCase {
    var sut: GDSContentTileView!
    var viewModel: ExpandedContentTileViewModel!
    
    var didTapPrimaryButton: Bool = false
    var didTapSecondaryButton: Bool = false
    var didTapCloseButton: Bool = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        viewModel = FullContentTileTestViewModel(
            primaryButtonViewModel: MockButtonViewModel(
                title: "Primary Button Title",
                action: {
                    self.didTapPrimaryButton = true
                }
            ),
            secondaryButtonViewModel: MockButtonViewModel(
                title: "Secondary Button Title",
                action: {
                    self.didTapSecondaryButton = true
                }
            )
        ) {
            self.didTapCloseButton = true
        }
        
        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        
        super.tearDown()
    }
}

private struct FullContentTileTestViewModel: ExpandedContentTileViewModel {
    var image: UIImage
    var caption: GDSLocalisedString
    var title: GDSLocalisedString
    var body: GDSLocalisedString
    var primaryButtonViewModel: any ButtonViewModel
    var secondaryButtonViewModel: any ButtonViewModel
    var showSeparatorLine: Bool = true
    var backgroundColour: UIColor? = .systemBackground
    var closeButtonAction: () -> Void
    
    init(
        image: UIImage = UIImage(named: "placeholder") ?? UIImage(),
        caption: GDSLocalisedString = "Test Caption",
        title: GDSLocalisedString = "Test Title",
        body: GDSLocalisedString = "Test Body",
        primaryButtonViewModel: any ButtonViewModel,
        secondaryButtonViewModel: any ButtonViewModel,
        showSeparatorLine: Bool = true,
        backgroundColour: UIColor? = .systemBackground,
        closeButtonAction: @escaping () -> Void
    ) {
        self.image = image
        self.caption = caption
        self.title = title
        self.body = body
        self.primaryButtonViewModel = primaryButtonViewModel
        self.secondaryButtonViewModel = secondaryButtonViewModel
        self.showSeparatorLine = showSeparatorLine
        self.backgroundColour = backgroundColour
        self.closeButtonAction = closeButtonAction
    }
}

private struct PartialContentTileViewModel: GDSContentTileViewModel {
    var title: GDSLocalisedString
    var showSeparatorLine: Bool
    var backgroundColour: UIColor?
}

@MainActor
extension GDSContentTileViewTests {
    func test_imageContents() throws {
        XCTAssertNotNil(try sut.image)
    }
    
    func test_hiddenContents() throws {
        let viewModel = PartialContentTileViewModel(title: "Test Title",
                                                    showSeparatorLine: false)
        sut = GDSContentTileView(viewModel: viewModel)
        
        XCTAssertTrue(try sut.image.isHidden)
        XCTAssertTrue(try sut.captionLabel.isHidden)
        XCTAssertTrue(try sut.bodyLabel.isHidden)
        XCTAssertTrue(try sut.separator.isHidden)
        XCTAssertTrue(try sut.closeButton.isHidden)
    }
    
    func test_closeButton() throws {
        XCTAssertFalse(didTapCloseButton)
        viewModel.closeButtonAction()
        XCTAssertTrue(didTapCloseButton)
    }
    
    func test_captionContents() {
        XCTAssertEqual(try sut.captionLabel.text, viewModel.caption.value)
        XCTAssertEqual(try sut.captionLabel.font, UIFont(style: .subheadline))
    }
    
    func test_titleContents() {
        XCTAssertEqual(try sut.titleLabel.text, viewModel.title.value)
        XCTAssertEqual(try sut.titleLabel.font, .title2Bold)
        XCTAssertEqual(try sut.titleLabel.accessibilityLabel, "Test Title Card")
    }
    
    func test_bodyContents() {
        XCTAssertEqual(try sut.bodyLabel.text, viewModel.body.value)
        XCTAssertEqual(try sut.bodyLabel.font, UIFont(style: .body))
    }
    
    func test_separatorView() {
        XCTAssertNotNil(try sut.separator)
    }
    
    func test_primaryButton() throws {
        XCTAssertEqual(try sut.primaryButton.titleLabel?.text, viewModel.primaryButtonViewModel.title.value)
        
        XCTAssertFalse(didTapPrimaryButton)
        viewModel.primaryButtonViewModel.action()
        XCTAssertTrue(didTapPrimaryButton)
    }
    
    func test_secondaryButton() throws {
        XCTAssertEqual(try sut.secondaryButton.titleLabel?.text, viewModel.secondaryButtonViewModel.title.value)
        XCTAssertEqual(try sut.secondaryButton.currentTitleColor, UIColor.gdsGreen)
        XCTAssertNil(try sut.secondaryButton.icon)
        
        XCTAssertFalse(didTapSecondaryButton)
        viewModel.secondaryButtonViewModel.action()
        XCTAssertTrue(didTapSecondaryButton)
    }
}

extension GDSContentTileView {
    var image: UIImageView {
        get throws {
            try XCTUnwrap(view?[child: "content-tile-image"])
        }
    }
    
    var captionLabel: UILabel {
        get throws {
            try XCTUnwrap(view?[child: "content-tile-caption"])
        }
    }
    
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view?[child: "content-tile-title"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view?[child: "content-tile-body"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view?[child: "content-secondary-button"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view?[child: "content-primary-button"])
        }
    }
    
    var closeButton: UIButton {
        get throws {
            try XCTUnwrap(view?[child: "content-close-button"])
        }
    }
    
    var separator: UIView {
        get throws {
            try XCTUnwrap(view?[child: "content-tile-separator"])
        }
    }
}
