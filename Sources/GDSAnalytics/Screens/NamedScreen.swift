@available(*, deprecated, renamed: "ScreenType")
public typealias NamedScreen = ScreenType

public protocol ScreenType {
    var name: String { get }
}
