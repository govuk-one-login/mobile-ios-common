import UIKit

public struct BodyHeadingViewModel: ScreenBodyItem {
    var text: GDSLocalisedString
    var overridingAlignment: NSTextAlignment?
    
    public init(
        text: GDSLocalisedString,
        overridingAlignment: NSTextAlignment? = nil
    ) {
        self.text = text
        self.overridingAlignment = overridingAlignment
    }
}

extension BodyHeadingViewModel {
    public var uiView: UIView {
        let result = UILabel()
        result.font = .bodySemiBold
        result.text = self.text.value
        result.adjustsFontForContentSizeCategory = true
        result.lineBreakMode = .byWordWrapping
        result.textAlignment = overridingAlignment ?? .center
        result.numberOfLines = 0
        result.accessibilityTraits = .header
        return result
    }
}
