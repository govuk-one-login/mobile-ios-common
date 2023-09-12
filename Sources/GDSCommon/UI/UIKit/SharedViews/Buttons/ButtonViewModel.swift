import UIKit

public protocol ButtonViewModel {
    var title: GDSLocalisedString { get }
    var icon: String? { get }
    var shouldLoadOnTap: Bool { get }
    var action: () -> Void { get }
}

public struct ButtonIcon {
    public static let arrowUpRight: String = "arrow.up.right"
}
