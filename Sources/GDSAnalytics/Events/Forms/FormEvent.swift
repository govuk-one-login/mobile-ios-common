public struct FormEvent: Event {
    public let name: EventName
    public let type: EventType
    
    public let text: String
    public let response: String
    
    public var parameters: [String: String] {
        [
            EventParameter.text.rawValue: text,
            EventParameter.type.rawValue: type.rawValue,
            EventParameter.response.rawValue: response
        ].mapValues(\.formattedAsParameter)
    }
    
    public init(name: EventName = .formResponse,
                type: EventType = .simpleSmartAnswer,
                textKey: String,
                _ variableKeys: String...,
                responseKey: String) {
        self.text = textKey.englishString(variableKeys)
        self.response = responseKey.englishString()
        self.name = name
        self.type = type
    }
}
