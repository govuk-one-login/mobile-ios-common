import GDSCommon
import UIKit

class MockListViewModel: GDSListOptionsViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the List Options screen pattern"
    let body: GDSLocalisedString? = "This is the optional body label. If the view model property is `nil` then the label is hidden."
    let childView: UIView?
    let listTitle: GDSLocalisedString?
    let listRows: [GDSLocalisedString] = ["Table view list item 1", "Table view list item two", "Table view list item 3", "Table view list item IV"]
    let listFooter: GDSLocalisedString? = "Optional footer. Configure it on the view model in a similar way as the `body` property. The right bar button works the same way."
    let buttonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    let rightBarButtonTitle: GDSLocalisedString? = "Right bar button"
    let backButtonIsHidden: Bool = false
    var selectedIndex: GDSLocalisedString = ""
    
    let screenView: () -> Void
    let dismissAction: () -> Void
    
    lazy var resultAction: (GDSLocalisedString) -> Void = {{ index in
        self.selectedIndex = index
    }}()
    
    func didDismiss() {
        dismissAction()
    }
    
    func didAppear() {
        screenView()
    }
    
    init(childView: UIView? = nil,
         secondaryButtonViewModel: ButtonViewModel? = nil,
         listTitle: GDSLocalisedString? = "Optional table title",
         screenView: (() -> Void)? = nil,
         dismissAction: (() -> Void)? = nil,
         buttonAction: (() -> Void)? = nil) {
        self.screenView = screenView ?? {}
        self.dismissAction = dismissAction ?? {}
        
        buttonViewModel = MockButtonViewModel(title: "Action button",
                                              icon: nil,
                                              shouldLoadOnTap: false,
                                              action: dismissAction ?? {})
        self.childView = childView
        self.secondaryButtonViewModel = secondaryButtonViewModel
        self.listTitle = listTitle
    }
}

#Preview {
    GDSListOptionsViewController(viewModel: MockListViewModel())
}
