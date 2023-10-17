import Foundation

struct GDSAttributedString {
    let localisedString: String
    let attributes: Attributes
    
    var attributedString: NSAttributedString {
        let mutableAttributeString = NSMutableAttributedString(string: localisedString)
        attributes.forEach {
            let range = NSString(string: mutableAttributeString.string)
                .range(of: $0, options: .caseInsensitive)
            mutableAttributeString.addAttributes($1, range: range)
        }
        
        return mutableAttributeString
    }
}
