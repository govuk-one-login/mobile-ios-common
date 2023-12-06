import GDSCommon
import UIKit

struct MockErrorViewModel: ErrorViewModel, BaseViewModel {
    var image: UIImage = UIImage(systemName: "exclamationmark.circle") ?? UIImage()
    var title: GDSLocalisedString = "This is an Error View title"
    var body: GDSLocalisedString = "This is an Error View body This is an Error View body"
    var primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    var secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    var rightBarButtonTitle: GDSLocalisedString?
    var backButtonIsHidden: Bool = false
    
    func didAppear() {}
    
    func didDismiss() {}
}
