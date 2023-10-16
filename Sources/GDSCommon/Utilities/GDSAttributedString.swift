import Foundation

public struct GDSAttributedString {
    public let localisedString: GDSLocalisedString
    public let attributes: [NSAttributedString.Key: Any]
    public let stringToAttribute: GDSLocalisedString
    
    public var attributedString: NSAttributedString {
        NSAttributedString(string: localisedString.value).addingAttributes(attributes, to: stringToAttribute.value)
    }
    
    public init(localisedString: GDSLocalisedString, attributes: [NSAttributedString.Key: Any], stringToAttribute: GDSLocalisedString) {
        self.localisedString = localisedString
        self.attributes = attributes
        self.stringToAttribute = stringToAttribute
    }
}
