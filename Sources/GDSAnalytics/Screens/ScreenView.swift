public protocol ScreenViewProtocol {
//    associatedtype Screen: NamedScreen
//    var screen: Screen { get }
    var title: String { get }
    var screenID: String { get }
    var parameters: [String: String] { get }
}

//<Screen: NamedScreen>:
public struct ScreenView: ScreenViewProtocol {
//    public let screen: Screen
    public let title: String
    public let screenID: String
    
    public var parameters: [String: String] {
        [ScreenParameter.title.rawValue: title,
         "screen_id": screenID]
            .mapValues(\.formattedAsParameter)
    }
    
    public init(screenID: String,
                titleKey: String,
                variableKeys: [String] = []) {
//        self.screen = screen
        self.title = titleKey.englishString(variableKeys)
        self.screenID = screenID
    }
}
