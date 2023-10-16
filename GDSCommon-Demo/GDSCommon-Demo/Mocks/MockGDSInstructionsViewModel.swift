import GDSCommon
import UIKit

class MockGDSInstructionsViewModel: GDSInstructionsViewModel {
    var title: GDSLocalisedString
    var body: String
    var rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    var childView: UIView
    var buttonViewModel: ButtonViewModel
    var secondaryButtonViewModel: ButtonViewModel?
    func didAppear() {}
    func didDismiss() {}
    
    init(title: GDSLocalisedString = "This is the Instructions View",
         body: String = "We can add a subtitle here to give some extra context",
         childView: UIView = BulletView(title: "This is the bullet view",
                                        text: ["Here we can list things we want the user to know",
                                               "we can use this as a way to step them through an action",
                                               "or give details of a process"]),
         buttonViewModel: ButtonViewModel,
         secondaryButtonViewModel: ButtonViewModel? = nil) {
        self.title = title
        self.body = body
        self.childView = childView
        self.buttonViewModel = buttonViewModel
        self.secondaryButtonViewModel = secondaryButtonViewModel
    }
}
