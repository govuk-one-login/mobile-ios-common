import GDSCommon
import XCTest

final class GDSContentTileViewTests: XCTestCase {
    var sut: GDSContentTileView!
    var viewModel: ExpandedContentTileViewModel!
    
    var didTapPrimaryButton: Bool = false
    var didTapSecondaryButton: Bool = false
    var didTapCloseButton: Bool = false
    var didTapCard: Bool = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        viewModel = FullContentTileTestViewModel {
            self.didTapPrimaryButton = true
        } secondaryButtonAction: {
            self.didTapSecondaryButton = true
        } closeButtonAction: {
            self.didTapCloseButton = true
        } cardTappedAction: {
            self.didTapCard = true
        }
                
        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        
        didTapPrimaryButton = false
        didTapSecondaryButton = false
        didTapCloseButton = false
        didTapCard = false
        
        super.tearDown()
    }
}

private struct FullContentTileTestViewModel: ExpandedContentTileViewModel {
    var image: UIImage = UIImage(named: "placeholder") ?? UIImage()
    var caption: GDSLocalisedString = "test caption"
    var title: GDSLocalisedString = "test title"
    var body: GDSLocalisedString = "test body"
    var showSeparatorLine: Bool = true
    var backgroundColour: UIColor? = .systemBackground
    var primaryButtonViewModel: ButtonViewModel
    var secondaryButtonViewModel: ButtonViewModel

    var closeButtonAction: () -> Void
    var cardTappedAction: () -> Void

    init(
        primaryButtonAction: @escaping () -> Void,
        secondaryButtonAction: @escaping () -> Void,
        closeButtonAction: @escaping () -> Void,
        cardTappedAction: @escaping () -> Void
    ) {
        primaryButtonViewModel = MockButtonViewModel(title: "Primary Button") {
            primaryButtonAction()
        }
        secondaryButtonViewModel = MockButtonViewModel(title: "Secondary Button") {
            secondaryButtonAction()
        }
        self.closeButtonAction = closeButtonAction
        self.cardTappedAction = cardTappedAction
    }
}

struct PartialContentTileViewModel: GDSContentTileViewModel {
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
        XCTAssertEqual(try sut.titleLabel.font, .bodySemiBold)
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
