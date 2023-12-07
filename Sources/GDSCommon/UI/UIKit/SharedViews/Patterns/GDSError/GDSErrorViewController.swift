import UIKit

/// View controller for `Error` screen
///     - `errorImageView` (type: `UIImageView`)
///     - `errorTitle` (type: `UILabel`)
///     - `errorBody` (type: `UILabel`)
///     - `primaryButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
///     - `secondaryButton`  (type: ``SecondaryButton`` inherits from ``UIButton``)
///
///  A navigation item can be configured:
///  If viewModel conforms to BaseViewModel:
///  - A back button can be set via the `hideBackButton` boolean property on the view controller
///  - A right bar button can be set via the`rightBarButtonTitle` string property on the view controller
///  - A `viewWillAppear` lifecycle event triggers the `didAppear` method in the viewModel.
///  - A `dismissScreen` lifecycle event triggers the `didDismiss` method in the viewModel.
///
/// The `primaryButton`'s action is set from the ``ButtonViewModel`` in the viewModel.
/// The `secondaryButton`'s action is set from the ``ButtonViewModel`` in the viewModel.
public final class GDSErrorViewController: BaseViewController {
    public override var nibName: String? { "GDSError" }
    
    private let viewModel: GDSErrorViewModel

    public init(viewModel: GDSErrorViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "Error", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(coordinator:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var errorImageView: UIImageView! {
        didSet {
            let font = UIFont(style: .largeTitle, weight: .light)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            errorImageView.image = UIImage(systemName: viewModel.image, withConfiguration: configuration)
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
