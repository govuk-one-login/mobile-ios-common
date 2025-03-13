import UIKit

@MainActor
public protocol ButtonViewModel {
    var title: GDSLocalisedString { get }
    var icon: ButtonIconViewModel? { get }
    var shouldLoadOnTap: Bool { get }
    var action: () -> Void { get }
    var voiceOverHint: GDSLocalisedString? { get }
}

public protocol ColoredButtonViewModel: ButtonViewModel {
    var backgroundColor: UIColor { get }
}

extension ButtonViewModel {
    public var voiceOverHint: GDSLocalisedString? { nil }
}

extension ColoredButtonViewModel {
    var backgroundColor: UIColor { .gdsGreen }
}
