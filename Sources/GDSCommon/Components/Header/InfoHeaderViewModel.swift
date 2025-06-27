import UIKit

public struct InfoHeaderViewModel: ScreenBodyItem {
    var title: GDSLocalisedString
    var titleFont: UIFont
    
    var subtitle: GDSLocalisedString
    var subtitleFont: UIFont
    
    var alignment: NSTextAlignment
    var spacing: CGFloat
    
    public init(
        title: GDSLocalisedString,
        titleFont: UIFont,
        subtitle: GDSLocalisedString,
        subtitleFont: UIFont,
        alignment: NSTextAlignment = .left,
        spacing: CGFloat = 0
    ) {
        self.title = title
        self.titleFont = titleFont
        self.subtitle = subtitle
        self.subtitleFont = subtitleFont
        self.alignment = alignment
        self.spacing = spacing
    }

    public var uiView: UIView {
        return InfoHeaderView(viewModel: self)
    }
    
}
