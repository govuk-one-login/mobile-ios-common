import Foundation

public struct FormEvent: Event {
    public let name = EventName.formResponse
    public let type = EventType.simpleSmartAnswer
    
    public let text: String
    public let response: String
    
    public var parameters: [String: String] {
        [
            EventParameter.text.rawValue: text,
            EventParameter.type.rawValue: type.rawValue,
            EventParameter.response.rawValue: response
        ].mapValues(\.formattedAsParameter)
    }
    
    public init(textKey: String, _ variableKeys: String...,
                responseKey: String,
                bundle: Bundle = .main) {
        self.text = textKey.englishString(variableKeys, bundle: bundle)
        self.response = responseKey.englishString(bundle: bundle)
    }
}
