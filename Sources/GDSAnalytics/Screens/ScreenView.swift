public protocol ScreenViewProtocol {
    associatedtype Screen: NamedScreen
    var screen: Screen { get }
    var title: String { get }
    var type: String? { get }
    var screenID: String? { get }
    var parameters: [String: String] { get }
}

public struct ScreenView<Screen: NamedScreen>: ScreenViewProtocol {
    public let screen: Screen
    public let title: String
    public var type: String?
    public let screenID: String?
    
    public var parameters: [String: String] {
        if let screenID, let type {
            return         [ScreenParameter.title.rawValue: title,
                            "screen_id": screenID,
                            "type": type]
                               .mapValues(\.formattedAsParameter)
        } else {
            return [ScreenParameter.title.rawValue: title]
                .mapValues(\.formattedAsParameter)
        }
    }
    
    public init(screen: Screen,
                screenID: String?,
                type: String?,
                titleKey: String,
                variableKeys: [String] = []) {
        self.screen = screen
        self.title = titleKey.englishString(variableKeys)
        self.screenID = screenID
        self.type = type
    }
}
