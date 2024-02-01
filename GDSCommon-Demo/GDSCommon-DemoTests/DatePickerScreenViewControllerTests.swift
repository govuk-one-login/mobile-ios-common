@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

@available(iOS 13.4, *)
final class DatePickerScreenViewControllerTests: XCTestCase {
    var sut: DatePickerScreenViewController!
    var viewModel: MockDatePickerScreenViewModel!
    var datePickerVM: ReusableDatePickerViewModel!
    
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
        
        datePickerVM = ReusableDatePickerViewModel(minDate: Date(),
                                                   maxDate: nil,
                                                   selectedDate: Date().shiftedBy(days: -10))
        

        viewModel = MockDatePickerScreenViewModel(title: "Date picker screen title",
                                                  datePickerViewModel: datePickerVM) { date in
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

@available(iOS 13.4, *)
extension DatePickerScreenViewControllerTests {
    func testScreenAppears() {
        XCTAssertFalse(screenDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(screenDidAppear)
        
        XCTAssertTrue(try sut.primaryButton.isEnabled)
        XCTAssertNotNil(sut.viewModel.datePickerViewModel.selectedDate)
        
        sut.viewModel.datePickerViewModel.selectedDate = nil
        XCTAssertNil(sut.viewModel.datePickerViewModel.selectedDate)
    }
    
    func testScreenAppears_ButtonDisabled() {
        datePickerVM = ReusableDatePickerViewModel(minDate: nil,
                                                   maxDate: nil)
        
        datePickerVM.selectedDate = nil
        
        viewModel.datePickerViewModel = datePickerVM
        
        sut = .init(viewModel: viewModel)
        
        XCTAssertFalse(screenDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(screenDidAppear)
        
        XCTAssertFalse(try sut.primaryButton.isEnabled)
    }
    
    func testVoiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "Date picker screen title")
    }
    
    func testLabelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "Date picker screen title")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        
        XCTAssertEqual(try sut.footerLabel.text, "Example date picker footer")
    }
    
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
    
    func testPrimaryButton() throws {
        datePickerVM = ReusableDatePickerViewModel(minDate: Date(),
                                                   maxDate: nil,
                                                   selectedDate: nil)
        

        viewModel = MockDatePickerScreenViewModel(title: "Date picker screen title",
                                                  datePickerViewModel: datePickerVM) { date in
            self.resultAction(date)
        } appearAction: {
            self.screenDidAppear = true
        } dismissAction: {
            self.didDismissScreen = true
        } buttonAction: {
            self.didTapButton = true
        }
        sut = .init(viewModel: viewModel)
        
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.textColor, .white)
        
        XCTAssertFalse(didTapButton)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertFalse(didTapButton)
    }
    
    func testPrimaryButton_ButtonActive() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.textColor, .white)
        
        XCTAssertFalse(didTapButton)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didTapButton)
    }
}

@available(iOS 13.4, *)
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
