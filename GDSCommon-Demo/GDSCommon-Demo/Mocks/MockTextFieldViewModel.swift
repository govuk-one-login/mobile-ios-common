@testable import GDSCommon
import UIKit

struct MockTextFieldViewModel<InputType>: TextFieldViewModel {
    typealias InputType = Bool
    var keyboardType: UIKeyboardType = .default
    var placeholder: String? = "Placeholder"
    var keyboardDoneButton: String? = "done button"
    
    var shouldValidate = true
    var result = false
    
    func validator(existingString: String?, range: NSRange, replacementString: String) -> Bool {
        shouldValidate
    }
    
    func resultFormatter(string: String) -> Bool? {
        result
    }
}
