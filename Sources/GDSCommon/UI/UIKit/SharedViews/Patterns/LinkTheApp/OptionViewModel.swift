import Foundation

public protocol OptionViewModel {
    var title: GDSLocalisedString { get }
    var subtitle: GDSLocalisedString { get }
    var buttonViewModel: ButtonViewModel { get }
}

struct MockButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString = "Example button text"
    let icon: String? = nil
    let shouldLoadOnTap: Bool = true
    let action: () -> Void = { }
}

public struct MockOptionViewModel: OptionViewModel {
    public let title: GDSLocalisedString = "Example title text"
    public let subtitle: GDSLocalisedString = "Example subtitle text"
    public let buttonViewModel: ButtonViewModel = MockButtonViewModel()
    
    public init() { }
}
