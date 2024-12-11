import UIKit

/// View controller for `GDSInformation` screen
///     - `informationImage` (type: `String`)
///     - `titleLabel` (type: `UILabel`)
///     - `bodyLabel` (type: `UILabel`)
///     - `footnoteLabel`  (type: `UILabel`)
///     - `primaryButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
///     - `secondaryButton`  (type: ``SecondaryButton`` inherits from ``UIButton``)
public final class GDSInformationViewController: BaseViewController, TitledViewController {
    public override var nibName: String? { "GDSInformation" }
    
    public private(set) var viewModel: GDSInformationViewModelWithTitleAndBody
    
    public init(viewModel: GDSInformationViewModelWithTitleAndBody) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "GDSInformation", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(viewModel:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    @IBOutlet private var bottomStack: UIStackView!
    @IBOutlet private var scrollView: UIScrollView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Position the footnote initially based on the current content size.
        checkContentSizeCategory()
        
        // Observer to position footnote when the user changes their preferred content size.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkContentSizeCategory),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
    }
    
    @objc private func checkContentSizeCategory() {
        let currentFontSize = UIApplication.shared.preferredContentSizeCategory
        
        if currentFontSize >= .accessibilityLarge {
            moveFootnoteToScrollView()
        } else {
            moveFootnoteToBottomStackView()
        }
    }
    
    private func moveFootnoteToScrollView() {
        if footnoteLabel.superview == bottomStack {
            // remove footnote from bottom stack
            bottomStack.removeArrangedSubview(footnoteLabel)
            footnoteLabel.removeFromSuperview()
            
            // add to scroll view
            stackView.addArrangedSubview(footnoteLabel)
            
            footnoteLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func moveFootnoteToBottomStackView() {
        if  footnoteLabel.superview != bottomStack {
            // remove from scroll view
            bottomStack.removeArrangedSubview(footnoteLabel)
            footnoteLabel.removeFromSuperview()
            
            // add to stack
            bottomStack.insertArrangedSubview(footnoteLabel, at: 0)
        }
    }
    
    @IBOutlet private var informationImage: UIImageView! {
        didSet {
            if let viewModel = viewModel as? GDSInformationViewModelWithImage {
                let font = UIFont(style: .largeTitle, weight: viewModel.imageWeight ?? .semibold)
                let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
                
                informationImage.image = UIImage(systemName: viewModel.image, withConfiguration: configuration)
                informationImage.tintColor = viewModel.imageColour ?? .gdsPrimary
                informationImage.accessibilityIdentifier = "information-image"
                
                /// Minimum height constraint for the image view
                var heightConstraint: CGFloat {
                    if let value = viewModel.imageHeightConstraint {
                        /// The minimum height constraint for the image view configured plus an 11pt buffer
                        value + 11
                    } else {
                        /// The default minimum height constraint for the image view is 55pts
                        55
                    }
                }
                
                NSLayoutConstraint.activate([
                    informationImage.heightAnchor.constraint(greaterThanOrEqualToConstant: heightConstraint)
                ])
            }
        }
    }
    
    @IBOutlet private(set) var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold, design: .default)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityIdentifier = "information-title"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            if let bodyContent = viewModel.body {
                bodyLabel.text = bodyContent.value
            } else {
                bodyLabel.isHidden = true
            }
            bodyLabel.accessibilityIdentifier = "information-body"
        }
    }

    /// Stack View: `UIStackView`. Any `UIView` which is on the `GDSInformationViewModelWithChildView` view model's `childView` property.
    /// This will be added to the `stackView` below the existing `bodyLabel`
    @IBOutlet private var stackView: UIStackView! {
        didSet {
            if let viewModel = viewModel as? GDSInformationViewModelWithChildView {
                stackView.addArrangedSubview(viewModel.childView)
            }
            stackView.accessibilityIdentifier = "information-optional-stack-view"
        }
    }
    
    @IBOutlet private var footnoteLabel: UILabel! {
        didSet {
            if let viewModel = viewModel as? GDSInformationViewModelWithOptionalFootnote {
                footnoteLabel.font = .init(style: .footnote)
                footnoteLabel.text = viewModel.footnote?.value
            } else if let viewModel = viewModel as? GDSInformationViewModelWithFootnote {
                footnoteLabel.font = .init(style: .footnote)
                footnoteLabel.text = viewModel.footnote.value
            } else {
                footnoteLabel.isHidden = true
            }
            footnoteLabel.accessibilityIdentifier = "information-footnote"
        }
    }
    
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            if let buttonViewModel = viewModel as? GDSInformationViewModelWithOptionalPrimaryButton,
                let button = buttonViewModel.primaryButtonViewModel {
                primaryButton.setTitle(button.title.value, for: .normal)
            } else if let buttonViewModel = viewModel as? GDSInformationViewModelPrimaryButton {
                primaryButton.setTitle(buttonViewModel.primaryButtonViewModel.title.value, for: .normal)
            } else {
                primaryButton.isHidden = true
            }
            primaryButton.accessibilityIdentifier = "information-primary-button"
        }
    }
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
        if let buttonViewModel = viewModel as? GDSInformationViewModelWithOptionalPrimaryButton {
            buttonViewModel.primaryButtonViewModel?.action()
        } else if let buttonViewModel = viewModel as? GDSInformationViewModelPrimaryButton {
            buttonViewModel.primaryButtonViewModel.action()
        }
    }
    
    @IBOutlet private var secondaryButton: SecondaryButton! {
        didSet {
            if let buttonViewModel = viewModel as? GDSInformationViewModelWithOptionalSecondaryButton,
               let button = buttonViewModel.secondaryButtonViewModel {
                secondaryButton.setTitle(button.title, for: .normal)
                secondaryButton.titleLabel?.textAlignment = .center
                
                if let icon = button.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else if let buttonViewModel = viewModel as? GDSInformationViewModelWithSecondaryButton {
                secondaryButton.setTitle(buttonViewModel.secondaryButtonViewModel.title.value, for: .normal)
                secondaryButton.titleLabel?.textAlignment = .center
                
                if let icon = buttonViewModel.secondaryButtonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else {
                secondaryButton.isHidden = true
            }
            secondaryButton.accessibilityIdentifier = "information-secondary-button"
        }
    }

    @IBAction private func secondaryButtonAction(_ sender: Any) {
        if let buttonViewModel = viewModel as? GDSInformationViewModelWithOptionalSecondaryButton {
            buttonViewModel.secondaryButtonViewModel?.action()
        } else if let buttonViewModel = viewModel as? GDSInformationViewModelWithSecondaryButton {
            buttonViewModel.secondaryButtonViewModel.action()
        }
    }
}
