import UIKit

/// Protocol for the view model required to initilise ``ErrorViewModel``
@available(*, deprecated, renamed: "GDSErrorViewModelV2", message: "Should also conform to GDSErrorViewModelWithImage if image is required")
public typealias GDSErrorViewModel = GDSErrorViewModelV2 & GDSErrorViewModelWithImage

@MainActor
public protocol GDSErrorViewModelV2 {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var primaryButtonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
}

@MainActor
public protocol GDSErrorViewModelWithImage {
    var image: String { get }
}

/// Conform view models that inherit from ``ErrorViewModel`` to this protocol to set a tertiary button
@MainActor
public protocol GDSScreenWithTertiaryButtonViewModel {
    var tertiaryButtonViewModel: ButtonViewModel { get }
}
