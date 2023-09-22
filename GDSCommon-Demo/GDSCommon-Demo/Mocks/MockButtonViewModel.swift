import Foundation
import GDSCommon

class MockButtonViewModel: ButtonViewModel {
    var title: GDSCommon.GDSLocalisedString
    var icon: String?
    var shouldLoadOnTap: Bool
    var action: () -> Void
    
    init(title: GDSCommon.GDSLocalisedString,
         icon: String? = nil,
         shouldLoadOnTap: Bool,
         action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.shouldLoadOnTap = shouldLoadOnTap
        self.action = action
    }
}
  
