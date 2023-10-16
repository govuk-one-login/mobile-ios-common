import GDSCommon

public struct MockOptionViewModel: OptionViewModel {
    public let title: GDSLocalisedString = "Example title text"
    public let subtitle: GDSLocalisedString = "Example subtitle text"
    public let buttonViewModel: ButtonViewModel = MockOptionButtonViewModel()
    
    public init() { }
}

struct MockOptionButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString = "Example button text"
    let icon: String? = nil
    let shouldLoadOnTap: Bool = true
    let action: () -> Void = { }
}
