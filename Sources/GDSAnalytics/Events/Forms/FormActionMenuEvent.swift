import Foundation

public struct FormActionMenuEvent: Event {
    public let name = EventName.formResponse
    public let type = EventType.actionMenu
    
    public let text: String
    
    public var parameters: [String: String] {
        [
            EventParameter.text.rawValue: text,
            EventParameter.type.rawValue: type.rawValue
        ].mapValues(\.formattedAsParameter)
    }
    
    public init(textKey: String,
                _ variableKeys: String...,
                bundle: Bundle = .main) {
        self.text = textKey.englishString(variableKeys, bundle: bundle)
    }
}
