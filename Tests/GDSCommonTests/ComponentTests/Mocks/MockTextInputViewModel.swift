@testable import GDSCommon
import UIKit

struct MockTextInputViewModel<InputType>: TextInputViewModel {
    typealias InputType = Bool
    var textFieldViewModel: any TextFieldViewModel = MockTextFieldViewModel<InputType>()
    
    let title: GDSLocalisedString = "title"
    let textFieldFooter: String? = "this is a long footer to check that dynamic type is working correctly"
    let buttonViewModel: ButtonViewModel = MockButtonViewModel(title: "button title") {
        print("button was tapped")
    }
    let rightBarButtonTitle: GDSLocalisedString? = "Cancel"
    var backButtonIsHidden: Bool = false
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
