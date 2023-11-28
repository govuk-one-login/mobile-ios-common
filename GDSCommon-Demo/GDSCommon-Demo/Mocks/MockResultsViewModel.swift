import GDSCommon
import UIKit

struct MockResultsViewModel: ResultsViewModel, BaseViewModel {
    let image: String = "checkmark.circle"
    let title: GDSLocalisedString = "This is a results screen"
    let body: GDSLocalisedString? = "This is the body where we can give a brief description of the app"
    let resultsButtonViewModel: ButtonViewModel
    let rightBarButtonTitle: GDSLocalisedString?
    let backButtonIsHidden: Bool = false
    
    let dismissAction: () -> Void
    
    func didAppear() { }
    
    func didDismiss() {
        dismissAction()
    }
}
