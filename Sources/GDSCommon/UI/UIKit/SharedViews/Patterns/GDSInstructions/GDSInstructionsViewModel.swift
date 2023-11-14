import UIKit

/// View model for the ``GDSInstructionsViewController``
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is `NSAttributedString`
/// - `rightBarButtonTitle` type is ``GDSLocalisedString``?
/// - `childView type is `UIView`
/// - `primaryButtonViewModel` type is ``ButtonViewModel``
/// - `secondaryButtonViewModel` type is ``ButtonViewModel``?
///
/// `childView` is added at the bottom of the `stackView` that contains the `title` and
/// `body`. Because it is of type `UIView` the kind of view that can be added here is very flexible.
///
/// Additionally there is a protocol method `didAppear()` which should be used
/// for any code that needs to be performed when the screen appears.
/// For example, this might include tracking an analytics screen view, but it could be used
/// for other code such as making an API call.
/// If `rightBarButtonTitle` is `nil` then the navigation item right bar button is hidden
/// Otherwise, it is set to the title property and the action is set to the `didDismiss()` action.
public protocol GDSInstructionsViewModel {
    var title: GDSLocalisedString { get }
    var body: String { get }
    var rightBarButtonTitle: GDSLocalisedString? { get }
    var childView: UIView { get }
    var buttonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
    
    func didAppear()
    func didDismiss()
}
