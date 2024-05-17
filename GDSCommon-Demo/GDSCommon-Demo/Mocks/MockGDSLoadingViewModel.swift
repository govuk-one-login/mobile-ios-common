import GDSCommon

struct MockGDSLoadingViewModel: GDSLoadingViewModel, BaseViewModel {
    var rightBarButtonTitle: GDSLocalisedString?
    var backButtonIsHidden: Bool = false
    var loadingLabelKey: GDSLocalisedString = "Loading"

    var appearAction: (() -> Void)?
    var dismissAction: (() -> Void)?

    func didAppear() {
        appearAction?()
    }
    
    func didDismiss() {
        dismissAction?()
    }
}
