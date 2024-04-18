import UIKit

/// View model for the `ModalInfoViewController`
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is ``GDSLocalisedString``
/// - `bodyTextColour` type is ``UIColor``
public protocol ModalInfoViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var bodyTextColor: UIColor { get }
    var privacyPolicyButtonTitle: GDSLocalisedString? { get }
}

/// View model for extra configuration on the `ModalInfoViewController`
/// - `preventModalDismiss` type is ``Bool``
public protocol ModalInfoExtraViewModel {
    var preventModalDismiss: Bool { get }
}
