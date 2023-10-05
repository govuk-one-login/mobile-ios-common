import Foundation
import GDSCommon

struct MockDatePickerScreenViewModel: DatePickerScreenViewModel {
    var title: GDSLocalisedString
    var datePickerViewModel: DatePickerViewModel
    var datePickerFooter: String?
    var buttonViewModel: ButtonViewModel
    var rightBarButtonTitle: GDSLocalisedString?
    var result: (Date) -> Void
    
    func didAppear() {
        
    }
    
    func didDismiss() {
        
    }
}
