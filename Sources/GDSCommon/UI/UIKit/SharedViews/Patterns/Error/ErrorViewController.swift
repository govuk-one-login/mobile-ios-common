import UIKit

public final class ErrorViewController: BaseViewController {
    public override var nibName: String? { "Error" }
    
    private let viewModel: ErrorViewModel

    public init(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "Error", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(coordinator:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var errorImageView: UIImageView! {
        didSet {
            errorImageView.image = viewModel.image
            errorImageView.accessibilityIdentifier = "error-image"
        }
    }
    
    @IBOutlet private var errorTitle: UILabel! {
        didSet {
            errorTitle.font = .init(style: .largeTitle, weight: .bold, design: .default)
            errorTitle.text = viewModel.title.value
            errorTitle.accessibilityIdentifier = "error-title"
        }
    }
    
    @IBOutlet private var errorBody: UILabel! {
        didSet {
            errorBody.text = viewModel.body.value
            errorBody.accessibilityIdentifier = "error-body"
        }
    }

    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            primaryButton.setTitle(viewModel.primaryButtonViewModel.title, for: .normal)
            primaryButton.accessibilityIdentifier = "error-primary-button"
        }
    }
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
        primaryButton.isLoading = true
        viewModel.primaryButtonViewModel.action()
        primaryButton.isLoading = false
    }
    
    @IBOutlet private var secondaryButton: SecondaryButton! {
        didSet {
            if let buttonViewModel = viewModel.secondaryButtonViewModel {
                secondaryButton.setTitle(buttonViewModel.title, for: .normal)
                secondaryButton.accessibilityIdentifier = "error-secondary-button"
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
