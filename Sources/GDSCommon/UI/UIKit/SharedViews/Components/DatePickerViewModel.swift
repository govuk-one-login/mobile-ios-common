import UIKit

@available(iOS 13.4, *)
public protocol DatePickerViewModel {
    var pickerStyle: UIDatePickerStyle { get }
    var selectedDate: Date? { get set }
    var minDate: Date? { get }
    var maxDate: Date? { get }
    
    mutating func setSelectedDate(_ date: Date)
}

@available(iOS 13.4, *)
extension DatePickerViewModel {
    var pickerStyle: UIDatePickerStyle {
        if #available(iOS 14, *) {
            .inline
        } else {
            .automatic
        }
    }
    
    mutating func setSelectedDate(_ date: Date) {
        self.selectedDate = date
    }
}


struct ReusableDatePickerViewModel: DatePickerViewModel {
    let minDate: Date?
    let maxDate: Date?
    var selectedDate: Date? = Date()
}
