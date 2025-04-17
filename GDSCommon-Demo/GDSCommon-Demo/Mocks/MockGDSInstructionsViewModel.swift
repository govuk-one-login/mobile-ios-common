import GDSCommon
import UIKit

struct MockGDSInstructionsViewModel: GDSInstructionsViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the Instructions View"
    let body: String = "We can add a subtitle here to give some extra context"
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let childView: UIView = NumberedListView(
        viewModel: MockNumberedListViewModel(
            title: "Test numbered list view",
            titleFont: .body,
            listItemStrings: [
                "first numbered list element",
                .init(
                    stringLiteral: "second numbered list element",
                    attributes: [("numbered list", [.font: UIFont.bodyBold])]
                ),
                "third numbered list element",
                "fourth numbered list element"
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
