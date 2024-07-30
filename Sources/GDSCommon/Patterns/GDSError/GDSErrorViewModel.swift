import UIKit

/// Protocol for the view model required to initilise ``ErrorViewModel``
@MainActor
public protocol GDSErrorViewModel {
    var image: String { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var primaryButtonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
}

/// Conform view models that inherit from ``ErrorViewModel`` to this protocol to set a tertiary button
public protocol GDSTertiaryButtonViewModel {
    var tertiaryButtonViewModel: ButtonViewModel { get }
}
