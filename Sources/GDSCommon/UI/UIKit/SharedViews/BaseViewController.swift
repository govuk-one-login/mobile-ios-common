import UIKit

public protocol BaseViewModel {
    var rightBarButtonTitle: GDSLocalisedString? { get }
    
    func didAppear()
    func didDismiss()
}

public class BaseViewController: UIViewController {
    private let viewModel: BaseViewModel?
    
    init(viewModel: BaseViewModel?, nibName: String, bundle: Bundle) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel?.rightBarButtonTitle != nil {
            self.navigationItem.rightBarButtonItem = .init(title: viewModel?.rightBarButtonTitle?.value,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(dismissScreen))
        }
    }
    
    @objc private func dismissScreen() {
        self.dismiss(animated: true)
        
        viewModel?.didDismiss()
    }
}

