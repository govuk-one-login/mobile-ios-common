import GDSCommon

struct MockGDSLoadingViewModel: GDSLoadingViewModel, BaseViewModel {
    var rightBarButtonTitle: GDSLocalisedString?
    var backButtonIsHidden: Bool = false
    var loadingLabelKey: GDSLocalisedString = "Loading"

    var appearAction: (() -> Void)? = nil
    var dismissAction: (() -> Void)? = nil
    
    func didAppear() { 
        appearAction?()
    }
    
    func didDismiss() {
        dismissAction?()
    }
}
