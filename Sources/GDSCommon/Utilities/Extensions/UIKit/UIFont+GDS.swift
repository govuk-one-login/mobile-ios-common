import UIKit

extension UIFont {
    public convenience init(style: TextStyle,
                            weight: Weight = .regular,
                            design: UIFontDescriptor.SystemDesign = .default) {
        guard let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
            .addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
            .withDesign(design) else {
            preconditionFailure("Could not find a matching font")
        }
        self.init(descriptor: descriptor, size: 0)
    }
    
    public static let footnote = UIFont(style: .footnote, weight: .regular)
    
    public static let body = UIFont(style: .body, weight: .regular)
    public static let bodySemiBold = UIFont(style: .body, weight: .semibold)
    public static let bodyBold = UIFont(style: .body, weight: .bold)
    
    public static let title3 = UIFont(style: .title3, weight: .regular)
    public static let title3Bold = UIFont(style: .title3, weight: .bold)
    
    public static let title1 = UIFont(style: .title1, weight: .regular)
    public static let title1Bold = UIFont(style: .title1, weight: .bold)
    
    public static let title2Bold = UIFont(style: .title2, weight: .bold)
    
    public static let largeTitle = UIFont(style: .largeTitle, weight: .regular)
    public static let largeTitleBold = UIFont(style: .largeTitle, weight: .bold)
    
    public static let bulletFont = UIFont.systemFont(ofSize: 6)
    public static let linkArrowFont = UIFont.systemFont(ofSize: 14)
}
