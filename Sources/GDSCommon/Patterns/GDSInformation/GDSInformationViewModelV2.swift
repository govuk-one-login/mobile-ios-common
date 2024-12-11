import UIKit

/// ``GDSInformationViewModelV2`` Is the view model for the ``GDSInformationViewController``
/// - `image` type is `String`
/// - `imageWeight` type is `UIFont.Weight`?
/// - `imageColour` type is `UIColor`?
/// - `imageHeightConstraint` type is `CGFloat`?
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is ``GDSLocalisedString``?
/// The following properties are included on additional protocols, which combine to make ``GDSInformationViewModel``
/// - `footnote` type is ``GDSLocalisedString``?
/// - `primaryButtonViewModel` type is ``ButtonViewModel``
/// - `secondaryButtonViewModel` type is ``ButtonViewModel``?
/// There are a number of optional properties as part of this protocol to extend the functionality
/// of the ``GDSInformationViewController``. When properties are `nil`, default
/// configuration has been created to account for the lack of specific configuration.
/// Concrete implementations of this protocol can be combined with conformance to
/// ``BaseViewModel`` to extend functionality to the parent class ``BaseViewController``.
/// Functionality segregated onto ``BaseViewController`` pertains to optionally displaying
/// screens modally and calling custom methods when screens appear and dismiss.
/// For example, this might include tracking an analytics screen view, but it could be used
/// for other code such as making an API call.
@available(*, deprecated,
            renamed: "GDSInformationViewModelWithTitleAndBody",
            message: "Should conform to GDSInformationViewModelWithTitleAndBody and GDSInformationViewModelWithImage")
public typealias GDSInformationViewModelV2 = GDSInformationViewModelWithTitleAndBody & GDSInformationViewModelWithImage

@MainActor
public protocol GDSInformationViewModelWithTitleAndBody {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
}

@MainActor
public protocol GDSInformationViewModelWithImage {
    var image: String { get }
    var imageWeight: UIFont.Weight? { get }
    var imageColour: UIColor? { get }
    var imageHeightConstraint: CGFloat? { get }
}

@MainActor
public protocol GDSInformationViewModelWithFootnote {
    var footnote: GDSLocalisedString { get }
}

@MainActor
public protocol GDSInformationViewModelPrimaryButton {
    var primaryButtonViewModel: ButtonViewModel { get }
}

@MainActor
public protocol GDSInformationViewModelWithSecondaryButton {
    var secondaryButtonViewModel: ButtonViewModel { get }
}

@MainActor
public protocol GDSInformationViewModelWithChildView {
    var childView: UIView { get }
}
