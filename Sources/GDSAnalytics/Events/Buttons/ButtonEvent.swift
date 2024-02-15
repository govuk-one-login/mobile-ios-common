public struct ButtonEvent: Event {
    public let name: EventName
    public let type: EventType
    
    public let text: String
    
    public var parameters: [String: String] {
        [
            EventParameter.text.rawValue: text,
            EventParameter.type.rawValue: type.rawValue
        ].mapValues(\.formattedAsParameter)
    }
    
    public init(eventName: EventName = .navigation,
                eventType: EventType = .submitForm,
                textKey: String, 
                _ variableKeys: String...) {
        self.init(textKey: textKey, variableKeys: variableKeys)
    }
    
    public init(eventName: EventName = .navigation, 
                eventType: EventType = .submitForm,
                textKey: String,
                variableKeys: [String]) {
        self.text = textKey.englishString(variableKeys)
        self.name = eventName
        self.type = eventType
    }
}
