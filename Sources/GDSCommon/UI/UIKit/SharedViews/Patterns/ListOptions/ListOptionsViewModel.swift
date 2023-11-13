import Foundation

/// Protocol for the view model required to initilise a ``ListOptionsViewController``
public protocol ListOptionsViewModel: BaseViewModel {
    var title: GDSLocalisedString { get }
    var body: String? { get }
    var listRows: [GDSLocalisedString] { get }
    var listFooter: String? { get }
    var buttonViewModel: ButtonViewModel { get }
    var rightBarButtonTitle: GDSLocalisedString? { get }
    var resultAction: (GDSLocalisedString) -> Void { get }
    
    func didAppear()
    func didDismiss()
}
