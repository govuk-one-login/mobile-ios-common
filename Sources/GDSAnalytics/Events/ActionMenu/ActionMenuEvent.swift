public struct ActionMenuEvent: Event {
    public let name = EventName.popup
    public let type = EventType.actionMenu
    
    public let text: String
    
    public var parameters: [String: String] {
        [
            EventParameter.text.rawValue: text,
            EventParameter.type.rawValue: type.rawValue
        ].mapValues(\.formattedAsParameter)
    }
    
    public init(textKey: String, _ variableKeys: String...) {
        self.text = textKey.englishString(variableKeys)
    }
}
