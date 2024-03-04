import UIKit

/// View model for the `ModalInfoViewController`
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is ``GDSLocalisedString``
public protocol ModalInfoViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
}

/// View model for extra configuration on the `ModalInfoViewController`
/// - `bodyTextColour` type is ``UIColor``
/// - `preventModalDismiss` type is ``Bool``
public protocol ModalInfoExtraViewModel {
    var bodyTextColour: UIColor { get }
    var preventModalDismiss: Bool { get }
}
