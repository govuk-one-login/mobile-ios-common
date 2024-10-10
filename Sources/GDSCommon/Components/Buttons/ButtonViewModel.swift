import UIKit

@MainActor
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

struct MockButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString
    let icon: ButtonIconViewModel?
    let shouldLoadOnTap: Bool
    let action: () -> Void
    
    static var primary: MockButtonViewModel {
        MockButtonViewModel(title: "Action button",
                            icon: nil,
                            shouldLoadOnTap: false) {
            /* This is empty as it is only used on the extension of GDSInformationViewModelPrimaryButton */
        }
    }
}
