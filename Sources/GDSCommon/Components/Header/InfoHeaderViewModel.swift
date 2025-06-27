import UIKit

public struct InfoHeaderViewModel: ScreenBodyItem {
    let title: GDSLocalisedString
    let titleFont: UIFont
    
    let subtitle: GDSLocalisedString
    let subtitleFont: UIFont
    
    let alignment: NSTextAlignment
    let spacing: CGFloat
    let backgroundColor: UIColor
    let textColor: UIColor
    
    public let horizontalPadding: CGFloat?
    
    public init(
        title: GDSLocalisedString,
        titleFont: UIFont,
        subtitle: GDSLocalisedString,
        subtitleFont: UIFont,
        alignment: NSTextAlignment = .left,
        spacing: CGFloat = 0,
        backgroundColor: UIColor,
        textColor: UIColor = .white
    ) {
        self.title = title
        self.titleFont = titleFont
        self.subtitle = subtitle
        self.subtitleFont = subtitleFont
        self.alignment = alignment
        self.spacing = spacing
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        
        self.horizontalPadding = 0
    }

    public var uiView: UIView {
        return InfoHeaderView(viewModel: self)
    }
    
}
