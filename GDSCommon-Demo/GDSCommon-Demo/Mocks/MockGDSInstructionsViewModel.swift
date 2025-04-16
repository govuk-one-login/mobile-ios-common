import GDSCommon
import UIKit

struct TestNumberedListViewModel: NumberedListViewModel {
    var title: GDSLocalisedString
    var titleFont: UIFont?
    var listItemStrings: [GDSLocalisedString]
}

struct MockGDSInstructionsViewModel: GDSInstructionsViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the Instructions View"
    let body: String = "We can add a subtitle here to give some extra context"
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let childView: UIView = NumberedListView(
        viewModel: TestNumberedListViewModel(
            title: "Test Numbered List View",
            titleFont: .body,
            listItemStrings: [
                "first numbered list element",
                "second numbered list element",
                "third numbered list element",
                "fourth numbered list element",
                "fifth numbered list element",
                "sixth numbered list element",
                "seventh numbered list element",
                "eighth numbered list element",
                "ninth numbered list element",
                "tenth numbered list element"
            ]
        )
    )
    let buttonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    let backButtonIsHidden: Bool = false
    
    let dismissAction: () -> Void
    
    func didAppear() {}
    func didDismiss() {
        dismissAction()
    }
}
