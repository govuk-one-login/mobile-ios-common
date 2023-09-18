import GDSCommon

struct MockListViewModel: ListOptionsViewModel {
    public let title: GDSLocalisedString = "Title"
    public let body: String? = "Body"
    public let listRows: [GDSLocalisedString] = ["1", "two", "3", "4"]
    public let listHeader: String? = "footer"
    public let listFooter: String? = "this is a much longer header I wonder if it fits and dynamic type works correctly"
    public let buttonViewModel: ButtonViewModel = MockButtonViewModel(title: "button title",
                                                                      action: { print("button was tapped") })
    public let resultAction: (GDSLocalisedString) -> Void
    
    public func didAppear() {
        print("screen did appear")
    }
}
