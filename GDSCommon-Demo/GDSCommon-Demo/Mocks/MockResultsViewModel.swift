import GDSCommon
import UIKit

struct MockResultsViewModel: ResultsViewModel {
    var image: String = "checkmark.circle"
    var title: GDSLocalisedString = "This is a results screen"
    var body: GDSLocalisedString? = "This is the body where we can give a brief description of the app"
    var resultsButtonViewModel: ButtonViewModel
    
    let dismissAction: () -> Void
    
    func didAppear() { }
    
    func didDismiss() {
        dismissAction()
    }

}
