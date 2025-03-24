import GDSCommon
import UIKit

struct MockOptionViewModel1: OptionViewModel {
    let title: GDSLocalisedString = "Example title text 1"
    let subtitle: GDSLocalisedString = "Example subtitle text 1"
    let buttonViewModel: ButtonViewModel = MockOptionButtonViewModel()
    
    init() { }
}

struct MockOptionViewModel2: OptionViewModel {
    let title: GDSLocalisedString = "Example title text 2"
    let subtitle: GDSLocalisedString = "Example subtitle text 2"
    let buttonViewModel: ButtonViewModel = MockOptionButtonViewModel()
    
    init() { }
}

struct MockOptionButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString = "Example button text"
    let icon: ButtonIconViewModel? = nil
    let shouldLoadOnTap: Bool = true
    let action: () -> Void = { }
    let contentAlignment: UIControl.ContentHorizontalAlignment? = .center
}
