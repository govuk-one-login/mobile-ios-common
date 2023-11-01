import Foundation
import GDSCommon

class MockButtonViewModel: ButtonViewModel {
    var title: GDSLocalisedString
    var icon: ButtonIconViewModel?
    var shouldLoadOnTap: Bool
    var action: () -> Void
    
    init(title: GDSLocalisedString,
         icon: ButtonIconViewModel? = nil,
         shouldLoadOnTap: Bool = false,
         action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.shouldLoadOnTap = shouldLoadOnTap
        self.action = action
    }
}
  
class MockButtonIconViewModel: ButtonIconViewModel {
    var iconName: String
    var symbolPosition: SymbolPosition
    
    init(iconName: String, symbolPosition: SymbolPosition) {
        self.iconName = iconName
        self.symbolPosition = symbolPosition
    }
}
  
