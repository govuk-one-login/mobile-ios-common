import Foundation
@testable import GDSCommon

@available(iOS 13.4, *)
struct MockDatePickerScreenViewModel: DatePickerScreenViewModel, BaseViewModel {
    var title: GDSLocalisedString
    var datePickerViewModel: DatePickerViewModel
    var datePickerFooter: String? = "Example date picker footer"
    var buttonViewModel: ButtonViewModel
    var rightBarButtonTitle: GDSLocalisedString? = "Right bar button"
    var backButtonIsHidden: Bool = false
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
         buttonViewModel: ButtonViewModel? = nil,
         result: ((Date) -> Void)? = nil,
         appearAction: (() -> Void)? = nil,
         dismissAction: (() -> Void)? = nil,
         buttonAction: (() -> Void)? = nil) {
        self.title = title
        self.datePickerViewModel = datePickerViewModel
        self.result = result ?? { _ in }
        self.appearAction = appearAction ?? {}
        self.dismissAction = dismissAction ?? {}
        if let buttonViewModel {
            self.buttonViewModel = buttonViewModel
        } else {
            self.buttonViewModel = MockButtonViewModel(title: "button title",
                                                       icon: nil,
                                                       shouldLoadOnTap: false,
                                                       action: buttonAction ?? {})
        }
    }
}
