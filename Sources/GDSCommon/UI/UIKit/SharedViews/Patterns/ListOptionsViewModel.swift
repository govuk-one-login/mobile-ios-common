import Foundation

public protocol ListOptionsViewModel {
    var title: GDSLocalisedString { get }
    var body: String? { get }
    var listRows: [GDSLocalisedString] { get }
    var listHeader: String? { get }
    var listFooter: String? { get }
    var buttonViewModel: ButtonViewModel { get }
    
    func didAppear()
}

#if DEBUG
public struct MockListViewModel: ListOptionsViewModel {
    public let title: GDSLocalisedString = "Title"
    public let body: String? = "Body"
    public let listRows: [GDSLocalisedString] = ["1", "two", "3", "4"]
    public let listHeader: String? = "footer"
    public let listFooter: String? = "this is a much longer header I wonder if it fits and dynamic type works correctly"
    public let buttonViewModel: ButtonViewModel = MockButtonVM()
    
    public func didAppear() {
        print("screen did appear")
    }
}

// TODO:
struct MockButtonVM: ButtonViewModel {
    let title: GDSLocalisedString = "button title"
    let icon: String? = nil
    let shouldLoadOnTap: Bool = false
    let action: () -> Void = { print("button was tapped") }
}
#endif
