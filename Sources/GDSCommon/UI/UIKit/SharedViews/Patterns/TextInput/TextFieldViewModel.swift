import UIKit

public protocol TextFieldViewModel {
    var keyboardType: UIKeyboardType { get }
    var placeholder: String? { get }
    
    func validator(existingString: String?, range: NSRange, replacementString: String) -> Bool
}
