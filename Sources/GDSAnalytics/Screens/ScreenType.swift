import Foundation

public protocol ScreenViewProtocol {
    associatedtype Screen: ScreenType
    var id: String? { get }
    var screen: Screen { get }
    var title: String { get }
    var parameters: [String: String] { get }
}

public struct ScreenView<Screen: ScreenType>: ScreenViewProtocol {
    public let id: String?
    public let screen: Screen
    public let title: String
    
    public var parameters: [String: String] {
        [
            ScreenParameter.id.rawValue: id,
            ScreenParameter.title.rawValue: title
        ].compactMapValues(\.?.formattedAsParameter)
    }
    
    public init(id: String? = nil,
                screen: Screen,
                titleKey: String,
                variableKeys: [String] = [],
                bundle: Bundle = .main) {
        self.id = id
        self.screen = screen
        self.title = titleKey.englishString(variableKeys, bundle: bundle).formattedAsParameter
    }
}
