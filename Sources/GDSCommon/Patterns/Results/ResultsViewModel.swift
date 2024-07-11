import UIKit

/// Protocol for the view model required to initilise a ``ResultsViewController``
@MainActor
public protocol ResultsViewModel {
    var image: String { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
    var resultsButtonViewModel: ButtonViewModel { get }
}
