/// Protocol for the view model required to initilise ``GDSLeftAlignedScreen``
@MainActor
public protocol GDSLeftAlignedViewModel {
    var title: GDSLocalisedString { get }
    var bodyContent: [ScreenBodyItem] { get }
    var buttonViewModels: [ButtonViewModel] { get }
}
