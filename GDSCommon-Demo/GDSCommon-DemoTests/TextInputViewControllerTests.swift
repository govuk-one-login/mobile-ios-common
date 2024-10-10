@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

final class TextInputViewControllerTests: XCTestCase {
    typealias InputType = Bool
    var sut: TextInputViewController<InputType>!
    var viewModel: (any TextInputViewModel)?
    
    var resultAction: ((Bool) -> Void)!
    
    var didSetResult: [Bool] = [false]
    var screenDidAppear: Bool = false
    var didTapButton = false
    var didDismissScreen = false
    
    @MainActor
    override func setUp() {
        super.setUp()

        screenDidAppear = false
        
        resultAction = { bool in
            self.didSetResult.append(bool)
        }
        
        let viewModel = MockTextInputViewModel<InputType> { result in
            self.didSetResult = [result]
        } appearAction: {
            self.screenDidAppear = true
        } dismissAction: {
            self.didDismissScreen = true
        }

        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        resultAction = nil
        viewModel = nil
        sut = nil
        didSetResult = []
        didTapButton = false
        didDismissScreen = false
        screenDidAppear = false
        
        super.tearDown()
    }
}

extension TextInputViewControllerTests {
    @MainActor
    func testDidAppear() {
        XCTAssertFalse(screenDidAppear)
        sut.beginAppearanceTransition(false, animated: false)
        sut.endAppearanceTransition()
        sut.viewDidAppear(false)
        XCTAssertTrue(screenDidAppear)
    }
    
    @MainActor
    func testVoiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "Text input screen title")
    }
    
    @MainActor
    func testLabels() {
        XCTAssertEqual(try sut.titleLabel.text, "Text input screen title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
    }
    
    @MainActor
    func testTextField() throws {
        try XCTAssertEqual(sut.textField.text, "")
        
        try sut.textField.text = "abc"
        try sut.textField.delegate?.textFieldDidEndEditing?(sut.textField)
        try XCTAssertFalse(sut.primaryButton.isEnabled)
        
        try XCTAssertEqual(sut.textField.text, "")
        
        try sut.textField.text = "3.5"
        try sut.textField.delegate?.textFieldDidEndEditing?(sut.textField)
        try XCTAssertTrue(sut.primaryButton.isEnabled)
        
        try XCTAssertEqual(sut.textField.font, .body)
        try XCTAssertEqual(sut.textField.textColor, .label)
        
        try XCTAssertEqual(sut.textField.placeholder, "Placeholder")
        
        try XCTAssertEqual(sut.textField.keyboardType, .default)
    }
    
    @MainActor
    func testTitleBar() {
        XCTAssertEqual(sut.navigationItem.hidesBackButton, false)
        sut.navigationItem.hidesBackButton = true
        XCTAssertEqual(sut.navigationItem.hidesBackButton, true)
        
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "Right bar button")
        
        XCTAssertFalse(didDismissScreen)

        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(didDismissScreen)
    }
    
    @MainActor
    func testTextFieldFooter() throws {
        try XCTAssertEqual(sut.textFieldFooter.text, "This is an optional footer. It is configured on the view model. If `nil` the label is hidden.")
        try XCTAssertEqual(sut.textFieldFooter.font, .footnote)
        try XCTAssertEqual(sut.textFieldFooter.textColor, .secondaryLabel)
    }
    
    @MainActor
    func testPrimaryButton() throws {
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.textColor, .white)
        
        try XCTAssertFalse(sut.primaryButton.isEnabled)
        XCTAssertFalse(didTapButton)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertFalse(didTapButton)
        
        try sut.textField.text = "1.0"
        try sut.textField.delegate?.textFieldDidEndEditing?(sut.textField)
        
        try XCTAssertTrue(sut.primaryButton.isEnabled)
    }
}

extension TextInputViewController {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "titleLabel"])
        }
    }
    
    var textField: UITextField {
        get throws {
            try XCTUnwrap(view[child: "textField"])
        }
    }
    
    var textFieldFooter: UILabel {
        get throws {
            try XCTUnwrap(view[child: "textFieldFooter"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "primaryButton"])
        }
    }
}
