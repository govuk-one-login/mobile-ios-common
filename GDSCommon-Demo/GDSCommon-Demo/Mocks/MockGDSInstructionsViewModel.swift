import GDSCommon
import UIKit

struct MockGDSInstructionsViewModel: GDSInstructionsViewModel, BaseViewModel {
    var title: GDSLocalisedString = "This is the Instructions View"
    var body: String = "We can add a subtitle here to give some extra context"
    var rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    var childView: UIView = BulletView(title: "This is the bullet view",
                                       text: ["Here we can list things we want the user to know",
                                              "we can use this as a way to step them through an action",
                                              "or give details of a process"])
    var buttonViewModel: ButtonViewModel
    var secondaryButtonViewModel: ButtonViewModel?
    var backButtonIsHidden: Bool = false
    
    let dismissAction: () -> Void
    
    func didAppear() {}
    func didDismiss() {
        dismissAction()
    }
}
