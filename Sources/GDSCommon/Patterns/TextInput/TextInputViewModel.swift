import Foundation
import UIKit

/// `TextInputViewModel` protocol to be used with `TextInputViewController`
public protocol TextInputViewModel {
    associatedtype InputType: LosslessStringConvertible
    
    var title: GDSLocalisedString { get }
    var textFieldFooter: String? { get }
    var buttonViewModel: ButtonViewModel { get }
    var textFieldViewModel: TextFieldViewModel { get }
    
    var result: (InputType) -> Void { get }
}

extension TextInputViewModel {
    func updateResult(string: String) {
        guard let inputValue = InputType.init(string) else { return }
        result(inputValue)
    }
}
