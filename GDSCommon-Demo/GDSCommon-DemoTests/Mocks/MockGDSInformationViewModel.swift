import GDSCommon
import UIKit

struct MockGDSInformationViewModel: GDSInformationViewModel, BaseViewModel {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = .semibold
    let imageColour: UIColor? = .gdsPrimary
    let imageHeightConstraint: CGFloat? = 55
    let title: GDSLocalisedString = "Information screen title"
    let body: GDSLocalisedString? = "Information screen body"
    let footnote: GDSLocalisedString? = "Information screen footnote"
    let primaryButtonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let backButtonIsHidden: Bool = false
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    init(primaryButtonViewModel: ButtonViewModel,
         secondaryButtonViewModel: ButtonViewModel,
         appearAction: @escaping () -> Void,
         dismissAction: @escaping () -> Void) {
        self.primaryButtonViewModel = primaryButtonViewModel
        self.secondaryButtonViewModel = secondaryButtonViewModel
        self.appearAction = appearAction
        self.dismissAction = dismissAction
    }
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }
}
