@testable import GDSCommon
import UIKit

struct MockTextFieldViewModel<InputType>: TextFieldViewModel {
    typealias InputType = Bool
    let keyboardType: UIKeyboardType = .default
    let placeholder: String? = "Placeholder"
    let keyboardDoneButton: String? = "done button"
    
    let shouldValidate = true
    let result = false
    
    func validator(existingString: String?, range: NSRange, replacementString: String) -> Bool {
        shouldValidate
    }
    
    func resultFormatter(string: String) -> Bool? {
        result
    }
}
