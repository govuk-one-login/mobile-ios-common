public protocol ScreenViewProtocol {
    associatedtype Screen: NamedScreen
    var screen: Screen { get }
    var title: String { get }
    var type: ScreenType? { get }
    var id: String? { get }
    var parameters: [String: String] { get }
}

public struct ScreenView<Screen: NamedScreen>: ScreenViewProtocol {
    public let screen: Screen
    public let title: String
    public var type: ScreenType?
    public let id: String?
    
    public var parameters: [String: String] {
        if let id, let type {
            return [ScreenParameter.id.rawValue: id,
                    ScreenParameter.title.rawValue: title,
                    ScreenParameter.type.rawValue: type.rawValue]
                .mapValues(\.formattedAsParameter)
        } else {
            return [ScreenParameter.title.rawValue: title]
                .mapValues(\.formattedAsParameter)
        }
    }
    
    public init(screen: Screen,
                id: String?,
                type: ScreenType?,
                titleKey: String,
                variableKeys: [String] = []) {
        self.screen = screen
        self.title = titleKey.englishString(variableKeys)
        self.id = id
        self.type = type
    }
}
