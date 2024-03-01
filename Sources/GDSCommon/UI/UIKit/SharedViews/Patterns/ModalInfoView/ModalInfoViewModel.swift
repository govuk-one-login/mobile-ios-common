import UIKit

/// View model for the `ModalInfoViewController`
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is ``GDSLocalisedString``
public protocol ModalInfoViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
}

/// View model for the `ModalInfoViewController`
/// - `bodyTextColour` type is ``UIColor?``
/// - `primaryButtonViewModel` type is ``ButtonViewModel?``
/// - `secondaryButtonViewModel` type is ``ButtonViewModel?``
/// - `preventModalDismiss` type is ``Bool?``
public protocol ModalInfoButtonsViewModel: ModalInfoViewModel {
    var bodyTextColour: UIColor? { get }
    var primaryButtonViewModel: ButtonViewModel? { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
    var preventModalDismiss: Bool? { get }
}
