import UIKit

public struct BodyTextViewModel: ScreenBodyItem {
    var text: GDSLocalisedString
    var fontWeight: UIFont.Weight
    var overridingAlignment: NSTextAlignment?
    
    public init(
        text: GDSLocalisedString,
        fontWeight: UIFont.Weight = .regular,
        overridingAlignment: NSTextAlignment? = nil
    ) {
        self.text = text
        self.fontWeight = fontWeight
        self.overridingAlignment = overridingAlignment
    }
}

extension BodyTextViewModel {
    public var uiView: UIView {
        let result = UILabel()
        result.font = UIFont(
            style: .body,
            weight: self.fontWeight
        )
        result.text = self.text.value
        result.adjustsFontForContentSizeCategory = true
        result.lineBreakMode = .byWordWrapping
        result.textAlignment = .center
        result.numberOfLines = 0
        return result
    }
}
