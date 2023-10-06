@testable import GDSCommon
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
    
    override func setUp() {
        super.setUp()

        screenDidAppear = false
        
        resultAction = { bool in
            self.didSetResult.append(bool)
        }
        
        let textFieldViewModel = MockTextFieldViewModel<InputType>()
        
        let viewModel = MockTextInputViewModel<InputType>(textFieldViewModel: textFieldViewModel) { _ in
            
        } appearAction: {
            
        } dismissAction: {
            
        }

        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        resultAction = nil
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

extension TextInputViewControllerTests {
    func testLabels() {
        XCTAssertEqual(try sut.titleLabel.text, "title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
    }
    
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
    
    func testTitleBar() {
        XCTAssertEqual(sut.navigationItem.hidesBackButton, false)
        sut.navigationItem.hidesBackButton = true
        XCTAssertEqual(sut.navigationItem.hidesBackButton, true)
        
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "Cancel")
    }
    
    func testTextFieldFooter() throws {
        try XCTAssertEqual(sut.textFieldFooter.text, "this is a long footer to check that dynamic type is working correctly")
        try XCTAssertEqual(sut.textFieldFooter.font, .footnote)
        try XCTAssertEqual(sut.textFieldFooter.textColor, .secondaryLabel)
    }
    
    func testPrimaryButton() throws {
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.textColor, .white)
        
        XCTAssertFalse(try sut.primaryButton.isEnabled)
        
        try XCTAssertFalse(sut.primaryButton.isEnabled)
        XCTAssertFalse(didTapButton)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertFalse(didTapButton)
        
        try sut.textField.text = "1.0"
        try sut.textField.delegate?.textFieldDidEndEditing?(sut.textField)
        
        try XCTAssertTrue(sut.primaryButton.isEnabled)
        
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertFalse(didTapButton)
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