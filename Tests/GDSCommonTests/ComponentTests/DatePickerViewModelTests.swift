@testable import GDSCommon
import XCTest

@available(iOS 13.4, *)
final class DatePickerViewModelTests: XCTestCase {
    var sut: DatePickerViewModel!
    var selectedDate: Date!
    
    override func setUp() {
        selectedDate = Date()
        
        sut = MockDatePickerViewModel(selectedDate: selectedDate,
                                      minDate: selectedDate.shiftedBy(days: -100),
                                      maxDate: nil)
    }
}

@available(iOS 13.4, *)
extension DatePickerViewModelTests {
    func testViewModel() throws {
        let selected = try XCTUnwrap(sut.selectedDate)
        XCTAssertTrue(Calendar.current.isDateInToday(selected))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        formatter.timeStyle = .none
        
        XCTAssertEqual(formatter.string(from: sut.minDate!), formatter.string(from: Calendar.current.date(byAdding: .day,
                                                                                                         value: -100, to: Date(),
                                                                                                         wrappingComponents: false)!))
        
    }
}
