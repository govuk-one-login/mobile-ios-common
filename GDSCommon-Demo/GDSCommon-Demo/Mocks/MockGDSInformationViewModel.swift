import GDSCommon
import UIKit

struct MockGDSInformationViewModel: GDSInformationViewModel, BaseViewModel {
    let image: String = "faceid"
    let imageWeight: UIFont.Weight = .thin
    let title: GDSLocalisedString = "This is an Information View title"
    let body: GDSLocalisedString = "This is an Information View body. \n\n This is another Information View body."
    let footnote: GDSLocalisedString? = "This is an Information View footnote where additional information for the buttons can be detailed."
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    
    func didDismiss() {}
}
