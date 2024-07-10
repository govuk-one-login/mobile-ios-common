import UIKit

/// `DatePickerViewModel` protocol. Create concrete implementations for initialising the
/// `DatePickerScreenViewModel`. This View Model encapsulates the main properties required for
/// Setting up a `UIDatePicker`such as the style, the selected date, min and max dates. Min and Max control
/// the earliest or latest dates selectable from the date picker.
/// Additionally, there is a `setSelectedDate` method for setting `selectedDate`
@available(iOS 13.4, *)
@MainActor
public protocol DatePickerViewModel {
    var pickerStyle: UIDatePickerStyle { get }
    var selectedDate: Date? { get set }
    var minDate: Date? { get }
    var maxDate: Date? { get }
    
    mutating func setSelectedDate(_ date: Date)
}

@available(iOS 13.4, *)
extension DatePickerViewModel {
    public var pickerStyle: UIDatePickerStyle {
        if #available(iOS 14, *) {
            return UIDatePickerStyle.inline
        } else {
            return UIDatePickerStyle.automatic
        }
    }
    
    public mutating func setSelectedDate(_ date: Date) {
        self.selectedDate = date
    }
}
