import GDSCommon
import XCTest

final class IconOptionsViewControllerTests: XCTestCase {
    var viewModel: IconOptionsViewModel!
    var sut: IconOptionsViewController!
    var didCallButtonAction = false
    
    override func setUp() {
        super.setUp()
        
        viewModel = TestIconOptionsViewModel {
            self.didCallButtonAction = true
        }
        sut = IconOptionsViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

private struct TestIconOptionsViewModel: IconOptionsViewModel {
    let imageName: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "Example title text"
    let body: GDSLocalisedString = "Example subtitle text string for testing purposes"
    let contentViews: [UIView]
    
    init(buttonAction: @escaping () -> Void) {
        let optionViewModel = TestOptionViewModel1(buttonAction: buttonAction)
        let optionView = OptionView(viewModel: optionViewModel)
        contentViews = [optionView]
    }
}

private struct TestOptionViewModel1: OptionViewModel {
    let title: GDSLocalisedString = "Example title text 1"
    let subtitle: GDSLocalisedString = "Example subtitle text 1"
    let buttonViewModel: ButtonViewModel
    
    init(buttonAction: @escaping () -> Void) {
        buttonViewModel = TestOptionButtonViewModel {
            buttonAction()
        }
    }
}

private struct TestOptionButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString = "Example button text"
    let icon: String? = nil
    let shouldLoadOnTap: Bool = true
    let action: () -> Void
}

extension IconOptionsViewControllerTests {
    func test_optionsLableContents() throws {
        XCTAssertNotNil(try sut.iconImage)
        XCTAssertEqual(try sut.titleLabel.text, "Example title text")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "Example subtitle text string for testing purposes")
        XCTAssertFalse(try sut.bodyLabel.accessibilityTraits.contains(.header))
    }
    
    func test_optionLableContents() throws {
        XCTAssertEqual(try sut.optionTitleLabel.text, "Example title text 1")
        XCTAssertTrue(try sut.optionTitleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.optionSubtitleLabel.text, "Example subtitle text 1")
        XCTAssertFalse(try sut.optionSubtitleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.optionSubtitleLabel.textColor, .gdsGrey)
        XCTAssertEqual(try sut.optionButton.title(for: .normal), "Example button text")
        XCTAssertTrue(try sut.optionButton is SecondaryButton)
        try sut.optionButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didCallButtonAction)
    }
}

extension IconOptionsViewController {
    var iconImage: UIImageView {
        get throws {
            try XCTUnwrap(view[child: "options-image"])
        }
    }
    
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "options-title"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "options-body"])
        }
    }
    
    var optionTitleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "option-title"])
        }
    }
    
    var optionSubtitleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "option-subtitle"])
        }
    }
    
    var optionButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "option-button"])
        }
    }
}
