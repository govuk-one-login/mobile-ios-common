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
@available(*, deprecated, renamed: "GDSCentreAlignedViewModel", message: "Should conform to GDSCentreAlignedViewModelWithImage and additional protocols if required")
public typealias GDSInformationViewModelV2 = GDSCentreAlignedViewModel & GDSCentreAlignedViewModelWithImage

@available(*, deprecated, renamed: "GDSCentreAlignedViewModelWithFootnote", message: "Should swap to non-optional alternative")
public typealias GDSInformationViewModelWithFootnote = GDSCentreAlignedViewModelWithFootnote

@available(*, deprecated, renamed: "GDSCentreAlignedViewModelWithPrimaryButton", message: "Should swap to non-optional alternative")
public typealias GDSInformationViewModelPrimaryButton = GDSCentreAlignedViewModelWithPrimaryButton

@available(*, deprecated, renamed: "GDSCentreAlignedViewModelWithSecondaryButton", message: "Should swap to non-optional alternative")
public typealias GDSInformationViewModelWithSecondaryButton = GDSCentreAlignedViewModelWithSecondaryButton

@available(*, deprecated, renamed: "GDSCentreAlignedViewModelWithChildView", message: "Should swap to non-optional alternative")
public typealias GDSInformationViewModelWithChildView = GDSCentreAlignedViewModelWithChildView
