/// View model for the `OptionView`
/// - `title` type is ``GDSLocalisedString``
/// - `subtitle` type is ``GDSLocalisedString``
/// - `buttonViewModel` type is ``ButtonViewModel``
public protocol OptionViewModel {
    var title: GDSLocalisedString { get }
    var subtitle: GDSLocalisedString { get }
    var buttonViewModel: ButtonViewModel { get }
}
