import UIKit

/// View model for the `ModalInfoViewController`
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is ``GDSLocalisedString``
/// -
/// Additionally there are protocol methods for `didAppear()` and `didDismiss()` which should be used
/// for any code that needs to be performed when the screen appears or is dismissed.
/// For example, this might include tracking an analytics screen view, but it could be used
/// for other code such as making an API call.
public protocol ModalInfoViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var rightBarButtonTitle: GDSLocalisedString { get }
    
    func didAppear()
    func didDismiss()
}
