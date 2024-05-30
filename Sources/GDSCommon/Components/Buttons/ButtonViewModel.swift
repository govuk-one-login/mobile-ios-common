import UIKit

public protocol ButtonViewModel {
    var title: GDSLocalisedString { get }
    var icon: ButtonIconViewModel? { get }
    var shouldLoadOnTap: Bool { get }
    var action: () -> Void { get }
}

public protocol ColoredButtonViewModel: ButtonViewModel {
    var backgroundColor: UIColor { get }
}

extension ColoredButtonViewModel {
    var backgroundColor: UIColor { .gdsGreen }
}
