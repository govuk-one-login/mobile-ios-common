@testable import GDSCommon
import UIKit

@available(iOS 13.4, *)
public protocol DatePickerScreenViewModel {
    var title: GDSLocalisedString { get }
    var datePickerViewModel: DatePickerViewModel { get set }
    var datePickerFooter: String? { get }
    var buttonViewModel: ButtonViewModel { get }
    var rightBarButtonTitle: GDSLocalisedString? { get }
    var result: (Date) -> Void { get }
    
    func didAppear()
    func didDismiss()
}
