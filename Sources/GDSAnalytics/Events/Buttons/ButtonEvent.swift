import Foundation

public struct ButtonEvent: Event {
    public let name = EventName.navigation
    public let type = EventType.submitForm
    
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
        self.init(textKey: textKey, variableKeys: variableKeys, bundle: bundle)
    }
    
    public init(textKey: String,
                variableKeys: [String],
                bundle: Bundle = .main) {
        self.text = textKey.englishString(variableKeys, bundle: bundle)
    }
}
