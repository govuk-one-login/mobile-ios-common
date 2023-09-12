public protocol ScreenViewProtocol {
    associatedtype Screen: NamedScreen
    var screen: Screen { get }
    var title: String { get }
    var parameters: [String: String] { get }
}

public struct ScreenView<Screen: NamedScreen>: ScreenViewProtocol {
    public let screen: Screen
    public let title: String
    
    public var parameters: [String: String] {
        [ScreenParameter.title.rawValue: title]
            .mapValues(\.formattedAsParameter)
    }
    
    public init(screen: Screen,
                titleKey: String,
                variableKeys: [String] = []) {
        self.screen = screen
        self.title = titleKey.englishString(variableKeys)
    }
}
