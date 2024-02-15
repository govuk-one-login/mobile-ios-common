public struct LinkEvent: Event {
    public let name = EventName.navigation
    public let type = EventType.genericLink
    
    public let text: String
    public let linkDomain: String
    public let external: ExternalLinkParameter
    
    public var parameters: [String: String] {
        [
            EventParameter.text.rawValue: text,
            EventParameter.type.rawValue: type.rawValue,
            EventParameter.linkDomain.rawValue: linkDomain,
            EventParameter.external.rawValue: external.rawValue
        ].mapValues(\.formattedAsParameter)
    }
    
    public init(textKey: String,
                variableKeys: String...,
                linkDomain: String,
                external: ExternalLinkParameter) {
        self.text = textKey.englishString(variableKeys)
        self.linkDomain = linkDomain
        self.external = external
    }
}
