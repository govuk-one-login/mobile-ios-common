import Foundation

/// Concrete implementation of `DatePickerViewModel`
struct ReusableDatePickerViewModel: DatePickerViewModel {
    let minDate: Date?
    let maxDate: Date?
    var selectedDate: Date? = Date()
}
