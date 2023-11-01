import GDSCommon

public struct MockOptionViewModel1: OptionViewModel {
    public let title: GDSLocalisedString = "Example title text 1"
    public let subtitle: GDSLocalisedString = "Example subtitle text 1"
    public let buttonViewModel: ButtonViewModel = MockOptionButtonViewModel()
    
    public init() { }
}

public struct MockOptionViewModel2: OptionViewModel {
    public let title: GDSLocalisedString = "Example title text 2"
    public let subtitle: GDSLocalisedString = "Example subtitle text 2"
    public let buttonViewModel: ButtonViewModel = MockOptionButtonViewModel()
    
    public init() { }
}

struct MockOptionButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString = "Example button text"
    let icon: ButtonIconViewModel? = nil
    let shouldLoadOnTap: Bool = true
    let action: () -> Void = { }
}
