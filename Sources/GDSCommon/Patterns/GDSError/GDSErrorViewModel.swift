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
