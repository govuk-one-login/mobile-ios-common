import GDSCommon
import XCTest

final class ModalInfoViewControllerTests: XCTestCase {
    var viewModel: ModalInfoViewModel!
    var sut: ModalInfoViewController!
    var primaryButton = false
    var secondaryButton = false
    var textButton = false
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        primaryButton = false
        secondaryButton = false
        textButton = false
        super.tearDown()
    }
}

extension ModalInfoViewControllerTests {
    func test_modalInfoView() throws {
        viewModel = MockModalInfoViewModel()
        sut = ModalInfoViewController(viewModel: viewModel)
        
        XCTAssertEqual(try sut.titleLabel.text, "This is the Modal view")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        XCTAssertEqual(try sut.bodyLabel.text, "We can use this if we want the user to complete an action")
        XCTAssertFalse(try sut.bodyLabel.accessibilityTraits.contains(.header))
        XCTAssertTrue(try sut.bodyLabel.textColor == .label)
        XCTAssertFalse(sut.isModalInPresentation)
    }
    
    func test_modalInfoViewButtons() throws {
        viewModel = MockModalInfoButtonsViewModel(primaryButtonViewModel: MockButtonViewModel(title: "Primary button",
                                                                                              action: { self.primaryButton = true }),
                                                  secondaryButtonViewModel: MockButtonViewModel(title: "Secondary button",
                                                                                                icon: MockButtonIconViewModel(),
                                                                                                action: { self.secondaryButton = true }),
                                                  textButtonViewModel: MockButtonViewModel(title: "Text button",
                                                                                           action: {self.textButton = true }))
        
        sut = ModalInfoViewController(viewModel: viewModel)
        
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Primary button")
        XCTAssertNil((try sut.primaryButton as? RoundedButton)?.icon)
        XCTAssertEqual(try sut.secondaryButton.title(for: .normal), "Secondary button")
        XCTAssertTrue(sut.isModalInPresentation)
        
        XCTAssertFalse(primaryButton)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(primaryButton)
        
        XCTAssertFalse(secondaryButton)
        try sut.secondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(secondaryButton)
        
        XCTAssertFalse(textButton)
        try sut.textButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(textButton)
    }
    
    func test_attributedModalInfoView() throws {
        viewModel = MockAttributedModalInfoViewModel()
        sut = ModalInfoViewController(viewModel: viewModel)
        
        XCTAssertEqual(try sut.bodyLabel.attributedText?.string, "We can use this attribubted text if we want the user to complete an action")
    }
    
    func test_primaryButtonIcon() throws {
        viewModel = MockModalInfoButtonsViewModel(primaryButtonViewModel: MockButtonViewModel(title: "Primary button",
                                                                                              icon: MockButtonIconViewModel(),
                                                                                              action: { self.primaryButton = true }),
                                                  secondaryButtonViewModel: MockButtonViewModel(title: "Secondary button",
                                                                                                icon: MockButtonIconViewModel(),
                                                                                                action: { self.secondaryButton = true }),
                                                  textButtonViewModel: MockButtonViewModel(title: "Text button",
                                                                                           action: {self.textButton = true }))
        
        sut = ModalInfoViewController(viewModel: viewModel)
        
        let button = try sut.primaryButton as? RoundedButton
        XCTAssertNotNil(button?.icon)
    }
}

extension ModalInfoViewController {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "titleLabel"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "bodyLabel"])
        }
    }
    
    var primaryButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "modal-info-primary-button"])
        }
    }
    
    var secondaryButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "modal-info-secondary-button"])
        }
    }
    
    var textButton: UIButton {
        get throws {
            try XCTUnwrap(view[child: "modal-info-text-button"])
        }
    }
}
