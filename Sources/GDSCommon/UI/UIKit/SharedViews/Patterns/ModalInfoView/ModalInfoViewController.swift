import UIKit

/// View Controller for the `ModalInfoView` storyboard XIB
/// This screen includes the following views:
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   This screen provides guidance in a modal presentation context
///   with a title and body to present the information.
///   There is also configuration for a right `UIBarButtonItem` with an action
///   configurable in the `dismissModal()` method in the viewModel.
public final class ModalInfoViewController: BaseViewController, TitledViewController {
    public override var nibName: String? { "ModalInfoView" }
    
    public let viewModel: ModalInfoViewModel
    
    /// Initialiser for the `ModalInfoView` view controller.
    /// Requires a single parameter.
    /// - Parameter viewModel: `ModalInfoViewModel`
    public init(viewModel: ModalInfoViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "ModalInfoView", bundle: .module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private(set) var titleLabel: UILabel! {
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
    
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            if let buttonViewModel = viewModel.primaryButtonViewModel {
                primaryButton.setTitle(buttonViewModel.title, for: .normal)
                primaryButton.accessibilityIdentifier = "modal-info-primary-button"
            } else {
                primaryButton.isHidden = true
            }
        }
    }
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
        primaryButton.isLoading = true
        viewModel.primaryButtonViewModel?.action()
        primaryButton.isLoading = false
    }
    
    @IBOutlet private var secondaryButton: SecondaryButton! {
        didSet {
            if let buttonViewModel = viewModel.secondaryButtonViewModel {
                secondaryButton.setTitle(buttonViewModel.title, for: .normal)
                secondaryButton.accessibilityIdentifier = "modal-info-secondary-button"
                
                if let icon = buttonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else {
                secondaryButton.isHidden = true
            }
        }
    }
    
    @IBAction private func secondaryButtonAction(_ sender: Any) {
        viewModel.secondaryButtonViewModel?.action()
    }
}
