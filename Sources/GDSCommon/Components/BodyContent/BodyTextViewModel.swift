import UIKit

public struct BodyTextViewModel: ScreenBodyItem {
    var text: GDSLocalisedString
    var fontWeight: UIFont.Weight
    var overridingAlignment: NSTextAlignment?
    var minimumHeight: CGFloat?
    
    public init(
        text: GDSLocalisedString,
        fontWeight: UIFont.Weight = .regular,
        overridingAlignment: NSTextAlignment? = nil,
        minimumHeight: CGFloat? = nil
    ) {
        self.text = text
        self.fontWeight = fontWeight
        self.overridingAlignment = overridingAlignment
        self.minimumHeight = minimumHeight
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
        result.textAlignment = overridingAlignment ?? .center
        result.numberOfLines = 0
        if let minimumHeight {
            result.heightAnchor.constraint(equalToConstant: minimumHeight).isActive = true
        }
        return result
    }
}
