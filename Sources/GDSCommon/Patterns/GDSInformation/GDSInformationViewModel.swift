import UIKit

/// View model for the ``GDSInformationViewController``
/// - `image` type is `String`
/// - `imageWeight` type is `UIFont.Weight`?
/// - `imageColour` type is `UIColor`?
/// - `imageHeightConstraint` type is `CGFloat`?
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is ``GDSLocalisedString``?
/// - `footnote` type is ``GDSLocalisedString``?
/// - `primaryButtonViewModel` type is ``ButtonViewModel``
/// - `secondaryButtonViewModel` type is ``ButtonViewModel``?
///
/// There are several optional properties as part of this protocol to extend the functionality
/// of the ``GDSInformationViewController``. When properties are `nil`, default
/// configuration has been created to account for the lack of specific configuration.
/// Concrete implementations of this protocol can be combined with conformance to
/// ``BaseViewModel`` to extend functionality to the parent class ``BaseViewController``.
/// Functionality segregated onto ``BaseViewController`` pertains to optionally displaying
/// screens modally and calling custom methods when screens appear and dismiss.
/// For example, this might include tracking an analytics screen view, but it could be used
/// for other code such as making an API call.
@MainActor
public protocol GDSInformationViewModel {
    var image: String { get }
    var imageWeight: UIFont.Weight? { get }
    var imageColour: UIColor? { get }
    var imageHeightConstraint: CGFloat? { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
    var footnote: GDSLocalisedString? { get }
    var primaryButtonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
}

@MainActor
public protocol GDSInformationViewModelWithChildView {
    var childView: UIView { get }
}
