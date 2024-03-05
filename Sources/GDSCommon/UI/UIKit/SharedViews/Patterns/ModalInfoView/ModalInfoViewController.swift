import UIKit

/// View Controller for the `ModalInfoView` storyboard XIB
/// This screen includes the following views:
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   - `primaryButton` (type: `RoundedButton`)
///   - `secondaryButton` (type: `SecondaryButton`)
///   This screen provides guidance in a modal presentation context
///   with a title and body to present the information.
///   Additional configuration and buttons can be added to this view by conforming to the:
///   `BaseViewModel`, `ModalInfoExtraViewModel`, `PageWithPrimaryButtonViewModel` and `PageWithSecondaryButtonViewModel` protocols.
public final class ModalInfoViewController: BaseViewController, TitledViewController {
    public override var nibName: String? { "ModalInfoView" }
    
    public let viewModel: ModalInfoViewModel
    
    /// Initialiser for the `ModalInfoView` view controller.
    /// Requires a single parameter.
    /// - Parameter viewModel: `ModalInfoViewModel`
    public init(viewModel: ModalInfoViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "ModalInfoView", bundle: .module)
        isModalInPresentation = (viewModel as? ModalInfoExtraViewModel)?.preventModalDismiss ?? false
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
            bodyLabel.textColor = viewModel.bodyTextColor
            bodyLabel.accessibilityIdentifier = "bodyLabel"
        }
    }
    
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            if let pbvm = viewModel as? PageWithPrimaryButtonViewModel {
                primaryButton.setTitle(pbvm.primaryButtonViewModel.title, for: .normal)
                primaryButton.accessibilityIdentifier = "modal-info-primary-button"
            } else {
                primaryButton.isHidden = true
            }
        }
    }
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
        primaryButton.isLoading = true
        (viewModel as? PageWithPrimaryButtonViewModel)?.primaryButtonViewModel.action()
        primaryButton.isLoading = false
    }
    
    @IBOutlet private var secondaryButton: SecondaryButton! {
        didSet {
            if let sbvm = viewModel as? PageWithSecondaryButtonViewModel {
                secondaryButton.setTitle(sbvm.secondaryButtonViewModel.title, for: .normal)
                secondaryButton.accessibilityIdentifier = "modal-info-secondary-button"
                if let icon = sbvm.secondaryButtonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else {
                secondaryButton.isHidden = true
            }
        }
    }
    
    @IBAction private func secondaryButtonAction(_ sender: Any) {
        (viewModel as? PageWithSecondaryButtonViewModel)?.secondaryButtonViewModel.action()
    }
}
