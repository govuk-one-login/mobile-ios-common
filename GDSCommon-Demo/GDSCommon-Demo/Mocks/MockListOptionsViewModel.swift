import GDSCommon

struct MockListViewModel: ListOptionsViewModel {
    let title: GDSLocalisedString = "This is the List Options screen pattern"
    let body: String? = "This is the optional body label. If the view model property is `nil` then the label is hidden."
    let listRows: [GDSLocalisedString] = ["Table view list item 1", "Table view list item two", "Table view list item 3", "Table view list item IV"]
    let listFooter: String? = "Optional footer. Configure it on the view model in a similar way as the `body` property. The right bar button works the same way."
    let buttonViewModel: ButtonViewModel = MockButtonViewModel(title: "button title",
                                                                      action: { print("button was tapped") })
    let resultAction: (GDSLocalisedString) -> Void
    let rightBarButtonTitle: GDSLocalisedString? = "Action button"

    let screenView: () -> Void
    
    func didDismiss() {
        print("did dismiss")
    }
    
    func didAppear() {
        screenView()
    }
    
    init(resultAction: ((GDSLocalisedString) -> Void)? = nil, screenView: (() -> Void)? = nil) {
        self.resultAction = resultAction ?? { string in
            print(string.value)
        }
        self.screenView = screenView ?? {}
    }
}
