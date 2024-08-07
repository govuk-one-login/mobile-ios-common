import GDSCommon
import UIKit

struct MockErrorViewModel: GDSErrorViewModelV2, GDSErrorViewModelWithImage, BaseViewModel {
    let image: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString = "This is an Error View body This is an Error View body"
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    
    func didDismiss() {}
}

struct MockErrorViewModelNoIcon: GDSErrorViewModelV2, BaseViewModel {
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString = "This is an Error View body This is an Error View body"
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    
    func didDismiss() {}
}

struct MockErrorViewModelWithTertiary: GDSErrorViewModelV2, GDSErrorViewModelWithImage, GDSScreenWithTertiaryButtonViewModel, BaseViewModel {
    let image: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString = "This is an Error View body This is an Error View body"
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let tertiaryButtonViewModel: ButtonViewModel = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    
    func didDismiss() {}
}
