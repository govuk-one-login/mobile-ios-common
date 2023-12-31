import UIKit

/// View model for the `ModalInfoViewController`
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is ``GDSLocalisedString``
public protocol ModalInfoViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
}
