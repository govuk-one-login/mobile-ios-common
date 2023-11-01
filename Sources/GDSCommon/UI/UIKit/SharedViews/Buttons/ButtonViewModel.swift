import UIKit

public protocol ButtonViewModel {
    var title: GDSLocalisedString { get }
    var icon: ButtonIconViewModel? { get }
    var shouldLoadOnTap: Bool { get }
    var action: () -> Void { get }
}

public protocol ButtonIconViewModel {
    var iconName: String { get }
    var symbolPosition: SymbolPosition { get }
}

public struct ButtonIcon {
    public static let arrowUpRight: String = "arrow.up.right"
}
