@testable import GDSCommon
import XCTest

@available(iOS 13.4, *)
final class DatePickerViewModelTests: XCTestCase {
    var sut: DatePickerViewModel!
    var selectedDate: Date!
    
    override func setUp() {
        super.setUp()
        selectedDate = Date()
        
        sut = ReusableDatePickerViewModel( minDate: selectedDate.shiftedBy(days: -100),
                                           maxDate: nil,
                                           selectedDate: selectedDate)
    }
    
    override func tearDown() {
        selectedDate = nil
        sut = nil
        super.tearDown()
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
        
        sut.setSelectedDate(selected.shiftedBy(days: 10) ?? Date())
        let newSelected = sut.selectedDate
        
        XCTAssertEqual(formatter.string(from: newSelected!), formatter.string(from: Calendar.current.date(byAdding: .day,
                                                                                                         value: 10, to: Date(),
                                                                                                         wrappingComponents: false)!))
        
        if #available(iOS 14.0, *) {
            XCTAssertEqual(sut.pickerStyle, .inline)
        } else {
            XCTAssertEqual(sut.pickerStyle, .automatic)
        }
    }
}
