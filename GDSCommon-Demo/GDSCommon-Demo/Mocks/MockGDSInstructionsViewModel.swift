import GDSCommon
import UIKit

struct MockBulletViewModel: BulletViewModel {
    var title: String?
    var titleFont: UIFont?
    var text: [String]
    
    init(title: String? = "This is the bullet view", 
         titleFont: UIFont? = .init(style: .largeTitle, weight: .bold),
         text: [String] = ["Here we can list things we want the user to know", "we can use this as a way to step them through an action", "or give details of a process"]) {
        self.title = title
        self.titleFont = titleFont
        self.text = text
    }
}

struct MockGDSInstructionsViewModel: GDSInstructionsViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the Instructions View"
    let body: String = "We can add a subtitle here to give some extra context"
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let childView: UIView = BulletView(viewModel: MockBulletViewModel())
    let buttonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    let backButtonIsHidden: Bool = false
    
    let dismissAction: () -> Void
    
    func didAppear() {}
    func didDismiss() {
        dismissAction()
    }
}
