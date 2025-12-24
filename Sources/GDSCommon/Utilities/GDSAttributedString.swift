import Foundation

/// `GDSAttributedString` is a custom type to help styling `GDSLocalisedString`.
/// It is an internal type and is not used directly but rather it is used through a `GDSLocalisedString`.
/// - `localisedString` (type: `String`)
/// - `attributes` (type:`Attributes`)
/// - `attributedString` (type: `NSAttributedString`)
/// The computed property `attributedString` uses both stored properties `localisedString` and `attributes`
/// to return an `NSAttributedString`.Thanks to the initialisers available in `GDSLocalisedString` you can set attributes
/// along with the strings you wish to apply these attributes to like in this example below.
/// ```swift
/// var body: GDSLocalisedString = .init(
/// stringLiteral: "This text is bold. This text is not.",
/// attributes: [("This text is bold", [.font: UIFont.bodyBold])])
/// ```
struct GDSAttributedString: Sendable {
    let localisedString: String
    
    private let sendableAttributes: SendableAttributes
    var attributes: Attributes { sendableAttributes.attributes }
    
    var attributedString: NSAttributedString {
        let mutableAttributeString = NSMutableAttributedString(string: localisedString)
        attributes.forEach {
            let range = NSString(string: mutableAttributeString.string)
                .range(of: $0, options: .caseInsensitive)
            mutableAttributeString.addAttributes($1, range: range)
        }
        
        return mutableAttributeString
    }
    
    init(localisedString: String, attributes: Attributes) {
        self.localisedString = localisedString
        self.sendableAttributes = SendableAttributes(attributes: attributes)
    }
}
