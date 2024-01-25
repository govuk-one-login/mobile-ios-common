import GDSCommon
import UIKit

struct MockInformationViewModel: GDSInformationViewModel, BaseViewModel {
    let image: String = "lock"
    let title: GDSLocalisedString = "This is an Information View title"
    let body: GDSLocalisedString = "This is an Error View body /n/n This is an Error View body"
    let footnote: GDSLocalisedString = "This a footnote"
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary

    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    func didDismiss() {}
}

