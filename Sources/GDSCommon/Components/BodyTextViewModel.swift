import UIKit

public struct BodyTextViewModel: ScreenBodyItem {
    var text: String
    var fontWeight: UIFont.Weight
    var overridingAlignment: NSTextAlignment?
    
    public init(
        text: String,
        fontWeight: UIFont.Weight = .regular,
        overridingAlignment: NSTextAlignment? = nil
    ) {
        self.text = text
        self.fontWeight = fontWeight
        self.overridingAlignment = overridingAlignment
    }
}
