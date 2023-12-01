import Foundation

public protocol BaseViewModel {
    var rightBarButtonTitle: GDSLocalisedString? { get }
    var backButtonIsHidden: Bool { get }
    
    func didAppear()
    func didDismiss()
}
