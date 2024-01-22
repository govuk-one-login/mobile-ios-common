import GDSCommon
import UIKit

struct MockPopoverItemViewModel: PopoverItemViewModel {
    var title: String
    var titleFont: UIFont = .body
    var icon: String
    var tint: UIColor = .label
    var action: () -> Void
    
    init(title: String, titleFont: UIFont, icon: String, tint: UIColor, action: @escaping () -> Void) {
        self.title = title
        self.titleFont = titleFont
        self.icon = icon
        self.tint = tint
        self.action = action
    }
}
