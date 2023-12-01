@testable import GDSCommon

struct MockBaseViewModel: BaseViewModel {
    var rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    var backButtonIsHidden: Bool = false
    
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }
}
