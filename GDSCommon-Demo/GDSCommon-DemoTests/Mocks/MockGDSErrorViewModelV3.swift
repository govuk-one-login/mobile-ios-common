@testable import GDSCommon
import XCTest

struct MockErrorViewModelV3: GDSErrorViewModelV3, BaseViewModel {
    let errorDefaults: ErrorDefaults
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString? = "This is an Error View body that should span onto multiple lines"
    
    let rightBarButtonTitle: GDSLocalisedString? = "Cancel"
    let backButtonIsHidden: Bool = false
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    var childView: UIView? {
        let childViewLabel = UILabel()
        childViewLabel.font = UIFont(style: .body)
        childViewLabel.text = "This is a child view"
        return UIStackView(
            views: [
                childViewLabel
            ]
        )
    }
    
    var buttonViewModels: [any ButtonViewModel]
    
    public init(
        buttonViewModels: [any ButtonViewModel],
        errorDefaults: ErrorDefaults = ErrorDefaults(),
        appearAction: @escaping () -> Void,
        dismissAction: @escaping () -> Void
    ) {
        self.buttonViewModels = buttonViewModels
        self.errorDefaults = errorDefaults
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
