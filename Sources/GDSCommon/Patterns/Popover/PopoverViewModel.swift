import UIKit

/// View model for the `PopoverItemViewModel`
/// - `title` type is ``String``
/// - `titleFont` type is ``UIFont``
/// - `icon` type is ``String``
/// - `tint` type is ``UIColor``
/// - `action` type is ``() -> Void``
@MainActor
public protocol PopoverItemViewModel {
    var title: String { get }
    var titleFont: UIFont { get }
    var icon: String { get }
    var tint: UIColor { get }
    var action: () -> Void { get }
}
