import GDSCommon
import GDSCommon_Demo
import XCTest

final class IconOptionsViewControllerTests: XCTestCase {
    var viewModel: IconOptionsViewModel!
    var sut: IconOptionsViewController!
    
    override func setUp() {
        super.setUp()
        
        viewModel = MockIconOptionsViewModel()
        sut = IconOptionsViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
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
