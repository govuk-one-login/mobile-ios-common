import Foundation
@testable import GDSCommon

@available(iOS 13.4, *)
struct MockDatePickerScreenViewModel: DatePickerScreenViewModel {
    var title: GDSLocalisedString
    var datePickerViewModel: DatePickerViewModel
    var datePickerFooter: String? = "example date picker footer"
    var buttonViewModel: ButtonViewModel
    var rightBarButtonTitle: GDSLocalisedString? = "Right bar button"
    var result: (Date) -> Void
    
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }
    
    init(title: GDSLocalisedString, 
         datePickerViewModel: DatePickerViewModel,
         result: @escaping (Date) -> Void,
         appearAction: @escaping () -> Void,
         dismissAction: @escaping () -> Void,
         buttonAction: @escaping () -> Void) {
        self.title = title
        self.datePickerViewModel = datePickerViewModel
        self.result = result
        self.appearAction = appearAction
        self.dismissAction = dismissAction
        
        self.buttonViewModel = MockButtonViewModel(title: "button title",
                                              action: buttonAction)
    }
}
