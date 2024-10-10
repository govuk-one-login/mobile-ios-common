import GDSCommon
import UIKit

internal struct MockGDSInstructionsViewModel: GDSInstructionsViewModel, BaseViewModel {
    let title: GDSLocalisedString = "test title"
    let body: String = "test body"
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let childView: UIView
    let buttonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    let backButtonIsHidden: Bool = false
    
    let screenView: () -> Void
    let dismissAction: () -> Void
    
    func didAppear() {
        screenView()
    }
    
    func didDismiss() {
        dismissAction()
    }
}
