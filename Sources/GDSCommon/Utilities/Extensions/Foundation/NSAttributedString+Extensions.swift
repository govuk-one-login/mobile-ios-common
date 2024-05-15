import UIKit

extension NSAttributedString {
    static var empty: NSAttributedString {
        .init(string: "")
    }
    
    static var newLine: NSAttributedString {
        .init(string: "\n")
    }
    
    static var bullet: NSAttributedString {
        .init(string: "\t●\t", attributes: .bulletAttributes)
    }
    
    static var nonBreakingSpace: NSAttributedString {
        .init(string: "\u{00A0}")
    }
    
    convenience init(_ strings: [NSAttributedString]) {
        self.init(attributedString: strings
            .reduce(into: NSMutableAttributedString()) {
                $0.append($1)
            }
        )
    }
    
    public convenience init(key: String) {
        self.init(string: NSLocalizedString(key: key))
    }
    
    static func + (_ lhs: NSAttributedString, _ rhs: NSAttributedString) -> NSAttributedString {
        NSAttributedString([lhs, rhs])
    }
    
    func addingSymbol(named iconName: String, configuration: UIImage.SymbolConfiguration = .unspecified, tintColor: UIColor = .label,
                      symbolPosition: SymbolPosition = .afterTitle) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: iconName, withConfiguration: configuration)?
            .withTintColor(tintColor)
        
        let imageString = NSAttributedString(attachment: attachment)
        
        
        // Non-breaking space ensures the arrow symbol (􀄯) stays associated with the label text
        switch symbolPosition {
        case .beforeTitle:
            return imageString + .nonBreakingSpace + self
        case .afterTitle:
            return self + .nonBreakingSpace + imageString
        }
    }
    
    public func addingAttributes(_ attributes: [NSAttributedString.Key: Any] = [.font: UIFont(style: .body, weight: .bold)],
                                 to text: String) -> NSAttributedString {
        let range = NSString(string: string).range(of: text, options: .caseInsensitive)
        let string = NSMutableAttributedString(attributedString: self)
        string.addAttributes(attributes, range: range)
        return string
    }
}

extension Array where Element: NSAttributedString {
     func joined(separator: NSAttributedString = .empty) -> NSAttributedString {
        guard let first = first else { return .empty }
        return dropFirst().reduce(first) {
            $0 + .newLine + $1
        }
    }
}

extension NSAttributedString {
    public convenience init(stringKey: String, _ parameters: CVarArg...) {
        let localisedString = String(format: NSLocalizedString(key: stringKey),
                                     arguments: parameters)
        self.init(string: localisedString)
    }
}
