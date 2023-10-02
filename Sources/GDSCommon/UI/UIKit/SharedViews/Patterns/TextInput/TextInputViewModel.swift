import Foundation
import GDSCommon
import UIKit

public protocol TextInputViewModel {
    associatedtype InputType: LosslessStringConvertible
    
    var title: GDSLocalisedString { get }
    var textFieldFooter: String? { get }
    var buttonViewModel: ButtonViewModel { get }
    var rightBarButtonTitle: GDSLocalisedString? { get }
    var textFieldViewModel: TextFieldViewModel { get }
    
    var result: (InputType) -> Void { get }
    
    func didAppear()
    func didDismiss()
}

extension TextInputViewModel {
    func updateResult(string: String) {
        guard let inputValue = InputType.init(string) else { return }
        result(inputValue)
    }
}
