import UIKit

/// Protocol for the view model required to initilise ``GDSErrorScreen``
@MainActor
public protocol GDSErrorViewModelV3 {
    var title: GDSLocalisedString { get }
    var bodyContent: [ScreenBodyItem] { get }
    var buttonViewModels: [ButtonViewModel] { get }
    var image: ErrorScreenImage { get }
    var buttonTextAlignment: NSTextAlignment { get }
}

extension GDSErrorViewModelV3 {
    public var buttonTextAlignment: NSTextAlignment { .center }
}

/// Deprecated alias to allow initialisation of ``GDSErrorViewController`` combining the below two protocols
@available(*, deprecated, renamed: "GDSErrorViewModelV2", message: "Should also conform to GDSErrorViewModelWithImage if image is required")
public typealias GDSErrorViewModel = GDSErrorViewModelV2 & GDSErrorViewModelWithImage

/// Protocol for the view model required to initilise ``GDSErrorViewController``
@available(*, deprecated, renamed: "GDSErrorViewModelV3", message: "Update errors to use new DesignSystem GDSErrorScreen with GDSErrorViewModelV3") // Deprecated 24/03/2025
@MainActor
public protocol GDSErrorViewModelV2 {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var primaryButtonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
}

/// Conform view models that inherit from ``GDSErrorViewModelV2`` to this protocol to set a image icon
@MainActor
@available(*, deprecated, message: "Update errors to use new DesignSystem GDSErrorScreen with GDSErrorViewModelV3") // Deprecated 24/03/2025
public protocol GDSErrorViewModelWithImage {
    var image: String { get }
}

/// Conform view models that inherit from ``GDSErrorViewModelV2`` to this protocol to set a tertiary button
@available(*, deprecated, message: "Update errors to use new DesignSystem GDSErrorScreen with GDSErrorViewModelV3") // Deprecated 24/03/2025
@MainActor
public protocol GDSScreenWithTertiaryButtonViewModel {
    var tertiaryButtonViewModel: ButtonViewModel { get }
}
