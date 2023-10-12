@testable import GDSCommon
import UIKit

struct MockTextInputViewModel<InputType>: TextInputViewModel {
    typealias InputType = Bool
    var textFieldViewModel: any TextFieldViewModel = MockTextFieldViewModel<InputType>()
    
    let title: GDSLocalisedString = "Text input screen title"
    let textFieldFooter: String? = "This is an optional footer. It is configured on the view model. If `nil` the label is hidden."
    let buttonViewModel: ButtonViewModel = MockButtonViewModel(title: "Action button") {
        print("button was tapped")
    }
    let rightBarButtonTitle: GDSLocalisedString? = "Right bar button"
    let result: (Bool) -> Void
    
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }
}
