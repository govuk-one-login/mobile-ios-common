import GDSCommon
import UIKit

struct MockGDSInformationViewModel: GDSInformationViewModel, BaseViewModel {
    var image: String = "lock"
    var title: GDSLocalisedString = "This is an Information View title"
    var body: GDSLocalisedString = "This is an Information View body \n\n This is an Information View body"
    var footnote: GDSLocalisedString? = "This is an Information View footnote"
    var primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    var secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    var rightBarButtonTitle: GDSLocalisedString? = nil
    var backButtonIsHidden: Bool = false
    
    func didAppear() {}
    
    func didDismiss() {}

}
