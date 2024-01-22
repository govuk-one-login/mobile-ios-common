import UIKit

public protocol PopoverItemViewModel {
    var title: String { get }
    var titleFont: UIFont { get }
    var icon: String { get }
    var tint: UIColor { get }
    var action: () -> Void { get }
}
