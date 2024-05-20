import UIKit

/// `DatePickerScreenViewModel` contains the properties required to configure a `DatePicker` screen.
/// This includes a `DatePickerViewModel` (which includes `UIDatePickerStyle`, min / max and selected
/// dates). `datePickerFooter` is an optional label which adds additional contextual information to the date
/// picker if further descritpion is required.
/// `rightBarButtonTitle` is optional. If set, the right bar button is displayed and its action can be
/// configured with the `didDismiss` method.
/// If an action needs to be done on appearance of the screen, add that to the `didAppear` method. This might
/// include logging screen analytics or loading content from an endpoint for example.
/// The `result` closure returns the selected date.
@available(iOS 13.4, *)
public protocol DatePickerScreenViewModel {
    var title: GDSLocalisedString { get }
    var datePickerViewModel: DatePickerViewModel { get set }
    var datePickerFooter: String? { get }
    var buttonViewModel: ButtonViewModel { get }
    var result: (Date) -> Void { get }
}
