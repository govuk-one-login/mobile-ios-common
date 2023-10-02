import GDSCommon

struct MockListViewModel: ListOptionsViewModel {
    let title: GDSLocalisedString = "Title"
    let body: String? = "Body"
    let listRows: [GDSLocalisedString] = ["1", "two", "3", "4"]
    let listFooter: String? = "this is a much longer footer I wonder if it fits and dynamic type works correctly"
    let buttonViewModel: ButtonViewModel = MockButtonViewModel(title: "button title",
                                                                      action: { print("button was tapped") })
    let resultAction: (GDSLocalisedString) -> Void
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"

    let screenView: () -> Void
    
    func didDismiss() {
        print("did dismiss")
    }
    
    func didAppear() {
        print("screen did appear")
    }
}
