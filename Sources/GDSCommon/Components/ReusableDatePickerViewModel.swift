import Foundation

/// Concrete implementation of `DatePickerViewModel`
@MainActor
struct ReusableDatePickerViewModel: DatePickerViewModel {
    let minDate: Date?
    let maxDate: Date?
    var selectedDate: Date? = Date()
}
