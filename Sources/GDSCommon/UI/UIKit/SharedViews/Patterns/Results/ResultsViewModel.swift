import UIKit

/// Protocol for the view model required to initilise a ``ResultsViewController``
public protocol ResultsViewModel {
    var image: String { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
    var resultsButtonViewModel: ButtonViewModel { get }
    
    func didAppear()
    func didDismiss()
}
