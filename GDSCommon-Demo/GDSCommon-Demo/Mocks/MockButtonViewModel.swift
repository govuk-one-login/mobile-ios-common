import Foundation
import GDSCommon

struct MockButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString
    let icon: ButtonIconViewModel?
    let shouldLoadOnTap: Bool
    let action: () -> Void
}

struct MockButtonIconViewModel: ButtonIconViewModel {
    let iconName: String
    let symbolPosition: SymbolPosition
}

extension MockButtonViewModel {
    static var primary: MockButtonViewModel {
        MockButtonViewModel(title: "Action button",
                            icon: nil,
                            shouldLoadOnTap: false,
                            action: {})
    }
    
    static var secondary: MockButtonViewModel {
        MockButtonViewModel(title: "Secondary Button",
                            icon: MockButtonIconViewModel(iconName: "arrow.up.right",
                                                          symbolPosition: .afterTitle),
                            shouldLoadOnTap: false,
                            action: {})
    }
    
    static var secondaryQR: MockButtonViewModel {
        MockButtonViewModel(title: "Secondary Button",
                            icon: MockButtonIconViewModel(iconName: "qrcode",
                                                          symbolPosition: .beforeTitle),
                            shouldLoadOnTap: false,
                            action: {})
    }
}
