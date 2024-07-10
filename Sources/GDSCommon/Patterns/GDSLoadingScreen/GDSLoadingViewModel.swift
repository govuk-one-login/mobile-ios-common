import Foundation

/// Protocol for the view model required to initilise a ``GDSLoadingViewController``
/// Concrete implementations of this protocol can be combined with conformance to
/// ``BaseViewModel`` to extend functionality to the parent class ``BaseViewController``.
/// Functionality segregated onto ``BaseViewController`` pertains to optionally displaying
/// screens modally and calling custom methods when screens appear and dismiss.
/// For example, this might include tracking an analytics screen view, but it could be used
/// for other code such as making an API call.
@MainActor
public protocol GDSLoadingViewModel {
    var loadingLabelKey: GDSLocalisedString { get }
}
