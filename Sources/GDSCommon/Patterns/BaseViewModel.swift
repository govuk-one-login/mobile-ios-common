import Foundation

@MainActor
public protocol BaseViewModel {
    var rightBarButtonTitle: GDSLocalisedString? { get }
    var backButtonIsHidden: Bool { get }
    
    func didAppear()
    func didDismiss()
}

@MainActor
public protocol ResettableView {
    var primaryButton: RoundedButton! { get }
}

@MainActor
public protocol ResettableViewController: ResettableView { }

extension ResettableViewController {
    public func resetPrimaryButton() {
        primaryButton.isEnabled = true
        primaryButton.isLoading = false
    }
}
