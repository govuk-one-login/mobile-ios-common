import UIKit

/// View model for the `ModalInfoViewController`
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is ``GDSLocalisedString``
/// - `bodyTextColour` type is ``UIColor``
@MainActor
public protocol ModalInfoViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var bodyTextColor: UIColor { get }
}

/// View model for extra configuration on the `ModalInfoViewController`
/// - `preventModalDismiss` type is ``Bool``
@MainActor
public protocol ModalInfoExtraViewModel {
    var preventModalDismiss: Bool { get }
}
