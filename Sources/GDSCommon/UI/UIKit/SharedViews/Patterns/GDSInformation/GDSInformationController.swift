import UIKit

public final class GDSInformationController: BaseViewController, TitledViewController {
    public override var nibName: String? { "GDSInformation" }
    
    public private(set) var viewModel: GDSInformationViewModel
    
    public init(viewModel: GDSInformationViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "GDSInformation", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(coordinator:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet var informationImage: UIImageView! {
        didSet {
            let font = UIFont(style: .largeTitle, weight: .light)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            informationImage.image = UIImage(systemName: viewModel.image, withConfiguration: configuration)
            informationImage.accessibilityIdentifier = "information-image"
        }
    }
    
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold, design: .default)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityIdentifier = "information-title"
        }
    }
    
    @IBOutlet var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body.value
            bodyLabel.accessibilityIdentifier = "information-body"
        }
    }
    
    // good naming?
    @IBOutlet var footnoteLabel: UILabel! {
        didSet {
            footnoteLabel.font = .init(style: .footnote) // do i need weight & design
            footnoteLabel.text = viewModel.title.value
            footnoteLabel.accessibilityIdentifier = "information-footnote"
        }
    }
    
    @IBOutlet var primaryButton: RoundedButton! {
        didSet {
            primaryButton.setTitle(viewModel.primaryButtonViewModel.title, for: .normal)
            primaryButton.accessibilityIdentifier = "information-primary-button"
        }
        
    }
    
    @IBAction func primaryButtonAction(_ sender: Any) {
        primaryButton.isLoading = true
        viewModel.primaryButtonViewModel.action()
        primaryButton.isLoading = false
    }
    
    @IBOutlet var secondaryButton: SecondaryButton! {
        didSet {
            if let buttonViewModel = viewModel.secondaryButtonViewModel {
                secondaryButton.setTitle(buttonViewModel.title, for: .normal)
                secondaryButton.accessibilityIdentifier = "information-secondary-button"
                
                if let icon = buttonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else {
                secondaryButton.isHidden = true
            }
        }
    }
    
    @IBAction func secondaryButtonAction(_ sender: Any) {
        viewModel.secondaryButtonViewModel?.action()
    }
}
