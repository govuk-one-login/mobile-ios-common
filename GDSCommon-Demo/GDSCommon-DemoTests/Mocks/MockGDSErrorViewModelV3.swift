@testable import GDSCommon
import XCTest

struct MockErrorViewModelV3: GDSErrorViewModelV3, BaseViewModel {
    
    var image: ErrorScreenImage = .error
    let title: GDSLocalisedString = "This is an Error View title"
    
    let rightBarButtonTitle: GDSLocalisedString? = "Cancel"
    let backButtonIsHidden: Bool = false
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    var bodyContent: [any GDSCommon.ScreenBodyItem]
    var buttonViewModels: [any ButtonViewModel]

    public init(
        buttonViewModels: [any ButtonViewModel],
        image: ErrorScreenImage,
        bodyContent: [ScreenBodyItem] = [],
        appearAction: @escaping () -> Void,
        dismissAction: @escaping () -> Void
    ) {
        self.buttonViewModels = buttonViewModels
        self.image = image
        self.bodyContent = bodyContent
        self.appearAction = appearAction
        self.dismissAction = dismissAction
    }
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }
}
