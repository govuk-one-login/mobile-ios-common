import GDSCommon
import UIKit

struct MockListViewModel: ListOptionsViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the List Options screen pattern"
    let body: String? = "This is the optional body label. If the view model property is `nil` then the label is hidden."
    let listRows: [GDSLocalisedString] = ["Table view list item 1", "Table view list item two", "Table view list item 3", "Table view list item IV"]
    let listFooter: String? = "Optional footer. Configure it on the view model in a similar way as the `body` property. The right bar button works the same way."
    let buttonViewModel: ButtonViewModel
    let resultAction: (GDSLocalisedString) -> Void
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
    }
}

struct MockDismissableListViewModel: DismissableListOptionsViewModel, BaseViewModel {
    let title: GDSLocalisedString = "Select a document:"
    let body: String? = nil
    let listRows: [GDSLocalisedString] = ["Table view list item 1", "Table view list item two", "Table view list item 3", "Table view list item IV"]
    let listFooter: String? = nil
    let buttonViewModel: ButtonViewModel
    let resultAction: (GDSLocalisedString) -> Void
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    let screenView: () -> Void
    let dismissAction: () -> Void
    
    let titleFont: UIFont = .bodyBold
    let navigationTitle: String? = "Data of Issue"
    
    let selectedItem: String?
    
    func didDismiss() {
        dismissAction()
    }
    
    func didAppear() {
        screenView()
    }
    
    init(resultAction: ((GDSLocalisedString) -> Void)? = nil,
         screenView: (() -> Void)? = nil,
         dismissAction: (() -> Void)? = nil,
         buttonAction: (() -> Void)? = nil,
         selectedItem: String? = nil) {
        self.resultAction = resultAction ?? { _ in
            // the resultAction shouldn't be nil
        }
        self.screenView = screenView ?? {}
        self.dismissAction = dismissAction ?? {}
        self.selectedItem = selectedItem
        
        buttonViewModel = MockButtonViewModel(title: "Action button",
                                              icon: nil,
                                              shouldLoadOnTap: false,
                                              action: dismissAction ?? {})
    }
}
