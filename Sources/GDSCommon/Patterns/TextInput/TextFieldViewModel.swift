import UIKit

/// `TextFieldViewModel` use to configure `UITextField`. Create a concrete implementation
/// is required in order to initialise a`TextInputViewModel`
/// The `validator` method can be used to validate the text field input each time the text changes.
@MainActor
public protocol TextFieldViewModel {
    var keyboardType: UIKeyboardType { get }
    var placeholder: String? { get }
    var keyboardDoneButton: String? { get }
    
    func validator(existingString: String?, range: NSRange, replacementString: String) -> Bool
}
