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
    
    public init(textKey: String, _ variableKeys: String...) {
        self.init(textKey: textKey, variableKeys: variableKeys)
    }
    
    public init(textKey: String, variableKeys: [String]) {
        self.text = textKey.englishString(variableKeys)
    }
}
