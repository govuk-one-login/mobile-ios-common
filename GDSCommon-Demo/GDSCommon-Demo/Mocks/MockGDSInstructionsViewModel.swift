import GDSCommon
import UIKit

struct MockGDSInstructionsViewModel: GDSInstructionsViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the Instructions View"
    let body: String = "We can add a subtitle here to give some extra context"
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let childView: UIView = GDSContentTileV2(viewModel: PartialContentTileViewModel())
    let buttonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    let backButtonIsHidden: Bool = false
    
    let dismissAction: () -> Void
    
    func didAppear() {}
    func didDismiss() {
        dismissAction()
    }
}

private struct PartialContentTileViewModel: GDSContentTileViewModel,
                                            GDSContentTileViewModelWithImage,
                                            GDSContentTileViewModelWithCaption {
    let backgroundColour: UIColor? = .systemBackground
    let title: GDSLocalisedString = "Title"
    let image: UIImage = UIImage(named: "licence")!
    let caption: GDSLocalisedString = "Caption"
    let showSeparatorLine: Bool = true
}
