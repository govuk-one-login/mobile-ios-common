import UIKit

private struct ErrorViewModelInitialiser: GDSErrorViewModel {
    let image: String
    let title: GDSLocalisedString
    let body: GDSLocalisedString
    let primaryButtonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    
    init(viewModelV2: GDSErrorViewModelV2) {
        if let viewModel = viewModelV2 as? GDSErrorViewModelWithImage {
            self.image = viewModel.image
        } else {
            self.image = ""
        }
        self.title = viewModelV2.title
        self.body = viewModelV2.body
        self.primaryButtonViewModel = viewModelV2.primaryButtonViewModel
        self.secondaryButtonViewModel = viewModelV2.secondaryButtonViewModel
    }
}

/// View controller for `GDSError` screen
///     - `errorImage` (type: `String`)
///     - `titleLabel` (type: `UILabel`)
///     - `bodyLabel` (type: `UILabel`)
///     - `primaryButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
///     - `secondaryButton`  (type: ``SecondaryButton`` inherits from ``UIButton``)
///     - `tertiaryButton` (type: ``SecondaryButton`` inherits from ``UIButton``)
public final class GDSErrorViewController: BaseViewController, TitledViewController {
    public override var nibName: String? { "GDSError" }
    
    public private(set) var viewModel: GDSErrorViewModel
    public private(set) var viewModelV2: GDSErrorViewModelV2
    
    public init(viewModel: GDSErrorViewModelV2) {
        if let viewModel = viewModel as? GDSErrorViewModel {
            self.viewModel = viewModel
        } else {
            self.viewModel = ErrorViewModelInitialiser(viewModelV2: viewModel)
        }
        self.viewModelV2 = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "GDSError", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(viewModel:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var errorImage: UIImageView! {
        didSet {
            if let viewModel = viewModelV2 as? GDSErrorViewModelWithImage {
                let font = UIFont(style: .largeTitle, weight: .light)
                let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
                errorImage.image = UIImage(systemName: viewModel.image, withConfiguration: configuration)
            } else {
                errorImage.isHidden = true
            }
            errorImage.accessibilityIdentifier = "error-image"
        }
    }
    
    @IBOutlet private(set) var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold, design: .default)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityIdentifier = "error-title"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body.value
            bodyLabel.accessibilityIdentifier = "error-body"
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
                if let icon = buttonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else {
                secondaryButton.isHidden = true
            }
            secondaryButton.accessibilityIdentifier = "error-secondary-button"
        }
    }
    
    @IBAction private func secondaryButtonAction(_ sender: Any) {
        viewModel.secondaryButtonViewModel?.action()
    }
    
    @IBOutlet private var tertiaryButton: SecondaryButton! {
        didSet {
            if let buttonViewModel = (viewModelV2 as? GDSScreenWithTertiaryButtonViewModel)?.tertiaryButtonViewModel {
                tertiaryButton.setTitle(buttonViewModel.title, for: .normal)
            } else {
                tertiaryButton.isHidden = true
            }
            tertiaryButton.accessibilityIdentifier = "error-tertiary-button"
        }
    }
    
    @IBAction private func tertiaryButtonAction(_ sender: Any) {
        (viewModelV2 as? GDSScreenWithTertiaryButtonViewModel)?.tertiaryButtonViewModel.action()
    }
}
