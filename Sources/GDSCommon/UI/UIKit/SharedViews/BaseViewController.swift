import UIKit

/// `BaseViewController` provides standard lifecycle functionality for other view controllers to inherit from
/// The view controller is configured with a  `BaseViewModel`
/// For the functionality of `BaseViewController` to work, the concrete implementation of
/// view model must conform to `BaseViewModel`.
/// Screen view controllers should generally inherit from ``BaseViewController`` instead of `UIViewController`
/// unless the functionality of the screen needs to be intentionally different from standard screens.
open class BaseViewController: UIViewController {
    private let viewModel: BaseViewModel?
    
    public init(viewModel: BaseViewModel?, nibName: String, bundle: Bundle) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        setBackButtonTitle(isHidden: viewModel?.backButtonIsHidden ?? false)
        
        if viewModel?.rightBarButtonTitle != nil {
            self.navigationItem.rightBarButtonItem = .init(title: viewModel?.rightBarButtonTitle?.value,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(dismissScreen))
        }
    }
    
    // TODO: GOVAPP-228 reimplement `viewIsAppearing` method
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.didAppear()
        
        Task { @MainActor in
            if let screen = self as? VoiceOverFocus {
                UIAccessibility.post(notification: .screenChanged,
                                     argument: screen.initialVoiceOverView)
            }
        }
    }
    
    @objc private func dismissScreen() {
        self.dismiss(animated: true)
        viewModel?.didDismiss()
    }
}
