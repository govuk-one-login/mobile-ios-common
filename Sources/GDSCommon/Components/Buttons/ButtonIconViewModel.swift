@MainActor
public protocol ButtonIconViewModel {
    var iconName: String { get }
    var symbolPosition: SymbolPosition { get }
}

public struct ButtonIcon {
    public static let arrowUpRight: String = "arrow.up.right"
    public static let xMark: String = "xmark"
}
