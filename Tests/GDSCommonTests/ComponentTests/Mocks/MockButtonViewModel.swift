import GDSCommon
import UIKit

internal struct MockButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString
    let icon: ButtonIconViewModel?
    let shouldLoadOnTap: Bool
    var contentAlignment: UIControl.ContentHorizontalAlignment?
    let action: () -> Void
    
    init(
        title: GDSLocalisedString,
        icon: ButtonIconViewModel? = nil,
        shouldLoadOnTap: Bool = false,
        contentAlignment: UIControl.ContentHorizontalAlignment? = .center,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.shouldLoadOnTap = shouldLoadOnTap
        self.action = action
    }
}
