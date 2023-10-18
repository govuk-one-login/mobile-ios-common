import UIKit

/// View Controller for the `ModalInfoView` storyboard XIB
/// This screen includes the following views:
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   This screen provides guidance in a modal presentation context
///   with a title and body to present the information.
///   There is also configuration for a right `UIBarButtonItem` with an action
///   configurable in the `dismissModal()` method in the viewModel.
public final class ModalInfoViewController: UIViewController {
    public override var nibName: String? { "ModalInfoView" }
    
    public let viewModel: ModalInfoViewModel
    
    /// Initialiser for the `ModalInfoView` view controller.
    /// Requires a single parameter.
    /// - Parameter viewModel: `ModalInfoViewModel`
    public init(viewModel: ModalInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ModalInfoView", bundle: .module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = .init(title: viewModel.rightBarButtonTitle.value,
                                                       style: .done,
                                                       target: self,
                                                       action: #selector(dismissModal))
        self.navigationItem.hidesBackButton = true
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.didAppear()
    }
    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.font = .init(style: .largeTitle, weight: .bold, design: .default)
            titleLabel.accessibilityIdentifier = "titleLabel"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            if let attributedString = viewModel.body.attributedValue {
                bodyLabel.attributedText = attributedString
            } else {
                bodyLabel.text = viewModel.body.value
            }
            bodyLabel.textColor = .gdsGrey
            bodyLabel.accessibilityIdentifier = "bodyLabel"
        }
    }
    
    @objc private func dismissModal() {
        self.dismiss(animated: true)
        
        viewModel.didDismiss()
    }
}
