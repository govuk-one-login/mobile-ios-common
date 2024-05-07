import GDSCommon
import UIKit

struct MockListViewModel: ListOptionsViewModel, BaseViewModel {
    
    let title: GDSLocalisedString = "This is the List Options screen pattern"
    let body: String? = "This is the optional body label. If the view model property is `nil` then the label is hidden."
    let childView: UIView?
    let listTitle: String? = "This is the tables optional title"
    let listRows: [GDSLocalisedString] = ["Table view list item 1", "Table view list item two", "Table view list item 3", "Table view list item IV"]
    let listFooter: String? = "Optional footer. Configure it on the view model in a similar way as the `body` property. The right bar button works the same way."
    let buttonViewModel: ButtonViewModel
    let resultAction: (GDSLocalisedString) -> Void
    let secondaryButtonViewModel: ButtonViewModel?
    let rightBarButtonTitle: GDSLocalisedString? = "Right bar button"
    let backButtonIsHidden: Bool = false
    
    let screenView: () -> Void
    let dismissAction: () -> Void
    
    func didDismiss() {
        dismissAction()
    }
    
    func didAppear() {
        screenView()
    }
    
    init(resultAction: ((GDSLocalisedString) -> Void)? = nil,
         screenView: (() -> Void)? = nil,
         dismissAction: (() -> Void)? = nil,
         buttonAction: (() -> Void)? = nil) {
        self.resultAction = resultAction ?? { _ in
            // the resultAction shouldn't be nil
        }
        self.screenView = screenView ?? {}
        self.dismissAction = dismissAction ?? {}
        
        buttonViewModel = MockButtonViewModel(title: "Action button",
                                              icon: nil,
                                              shouldLoadOnTap: false,
                                              action: dismissAction ?? {})
        
        secondaryButtonViewModel = MockButtonViewModel(title: "Secondary Button", icon: nil, shouldLoadOnTap: false, action: dismissAction ?? {})
        
        childView = BulletView(viewModel: MockBulletViewModel(title: nil))
    }
}

#Preview {
    ListOptionsViewController(viewModel: MockListViewModel())
}
