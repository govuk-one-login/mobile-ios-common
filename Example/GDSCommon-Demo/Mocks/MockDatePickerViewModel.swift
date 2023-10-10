import Foundation
@testable import GDSCommon

struct MockDatePickerViewModel: DatePickerViewModel {
    var selectedDate: Date?
    var minDate: Date?
    var maxDate: Date?
}
