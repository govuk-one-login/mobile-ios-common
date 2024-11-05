import GDSCommon
import UIKit

struct MockGDSInstructionsViewModel: GDSInstructionsViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the Instructions View"
    let body: String = """
We can add a subtitle here to give some extra context, along with a child view below. The child view is currently presenting the content tile, however this can be changed
"""
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let childView: UIView = GDSContentTileView(viewModel: MockGDSContentTile(cardTappedAction: { print("card tapped")},
                                                                             closeButtonAction: { }))
    let buttonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    let backButtonIsHidden: Bool = false
    
    let dismissAction: () -> Void
    
    func didAppear() {}
    func didDismiss() {
        dismissAction()
    }
}
