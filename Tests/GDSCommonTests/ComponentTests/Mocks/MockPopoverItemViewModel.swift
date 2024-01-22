import GDSCommon
import UIKit

public struct MockPopoverItemViewModel: PopoverItemViewModel {
    public var title: String
    public var titleFont: UIFont = .body
    public var icon: String
    public var tint: UIColor = .label
    public var action: () -> Void
    
    init(title: String, titleFont: UIFont, icon: String, tint: UIColor, action: @escaping () -> Void) {
        self.title = title
        self.titleFont = titleFont
        self.icon = icon
        self.tint = tint
        self.action = action
    }
}
