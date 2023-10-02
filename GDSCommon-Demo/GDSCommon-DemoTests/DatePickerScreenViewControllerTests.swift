import GDSCommon
@testable import GOV_UK
import XCTest

final class DatePickerScreenViewControllerTests: XCTestCase {
    var sut: DatePickerScreenViewController!
    var viewModel: DatePickerScreenViewModel!
    
    var resultAction: ((Date) -> Void)!
    var gdsLocalisedString: GDSLocalisedString!
    
    var didSetDate: Date?
    var screenDidAppear: Bool = false
    var didTapButton = false
    var didDismissScreen = false
    
    override func setUp() {
        super.setUp()
        gdsLocalisedString = "exampleString"
        screenDidAppear = false
        
        resultAction = { date in
            self.didSetDate = date
        }
        
        viewModel = EmploymentStartDatePickerViewModel { date in
            self.resultAction(date)
        } appearAction: {
            self.screenDidAppear = true
        } dismissAction: {
            self.didDismissScreen = true
        } buttonAction: {
            self.didTapButton = true
        }
        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        gdsLocalisedString = nil
        resultAction = nil
        viewModel = nil
        sut = nil
        didSetDate = nil
        
        super.tearDown()
    }
}

extension DatePickerScreenViewControllerTests {
    func testScreenAppears() {
        XCTAssertFalse(screenDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(screenDidAppear)
    }
    
    func testLabelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "What was the employment start date?")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        
        XCTAssertTrue(try sut.footerLabel.isHidden)
    }
    
    func testTitleBar() {
        XCTAssertEqual(sut.navigationItem.hidesBackButton, false)
        sut.navigationItem.hidesBackButton = true
        XCTAssertEqual(sut.navigationItem.hidesBackButton, true)
        
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "Cancel")
    }
    
    func testPrimaryButton() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.textColor, .white)
        
        XCTAssertFalse(try sut.primaryButton.isEnabled)
        
        XCTAssertFalse(didTapButton)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertFalse(didTapButton)
        
        try sut.datePicker.setDate(Date(), animated: true)
        
//        XCTAssertFalse(didTapButton)
//        try sut.primaryButton.sendActions(for: .touchUpInside)
//        XCTAssertTrue(didTapButton)
    }
}

extension DatePickerScreenViewController {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "titleLabel"])
        }
    }
    
    var datePicker: UIDatePicker {
        get throws {
            try XCTUnwrap(view[child: "datePicker"])
        }
    }
    
    var footerLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "datePickerFooter"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "primaryButton"])
        }
    }
}
