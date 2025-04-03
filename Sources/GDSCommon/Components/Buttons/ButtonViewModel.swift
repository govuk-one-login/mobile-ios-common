import UIKit

@MainActor
public protocol ButtonViewModel: ScreenBodyItem {
    var title: GDSLocalisedString { get }
    var icon: ButtonIconViewModel? { get }
    var shouldLoadOnTap: Bool { get }
    var action: () -> Void { get }
    var accessibilityHint: GDSLocalisedString? { get }
    var overrideContentAlignment: UIControl.ContentHorizontalAlignment { get }
}

extension ButtonViewModel {
    public var overrideContentAlignment: UIControl.ContentHorizontalAlignment { .center }
}

extension ButtonViewModel {
    public var uiView: UIView {
        let result = SecondaryButton()
        result.contentHorizontalAlignment = self.overrideContentAlignment
        result.setTitle(self.title, for: .normal)
        result.titleLabel?.textColor = .accent
        result.symbolPosition = self.icon?.symbolPosition ?? .afterTitle
        result.icon = self.icon?.iconName
        result.accessibilityHint = self.accessibilityHint?.value
        result.addAction {
            self.action()
        }
        return result
    }
}


public protocol ColoredButtonViewModel: ButtonViewModel {
    var backgroundColor: UIColor { get }
}

extension ButtonViewModel {
    public var accessibilityHint: GDSLocalisedString? { nil }
}

extension ColoredButtonViewModel {
    var backgroundColor: UIColor { .gdsGreen }
}
