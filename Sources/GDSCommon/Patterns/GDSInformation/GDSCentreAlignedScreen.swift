import UIKit

public typealias GDSInformationViewController = GDSCentreAlignedScreen

// swiftlint: disable type_body_length
/// View controller for `GDSCentreALigned` screen
///     - `image` (type: `String`)
///     - `titleLabel` (type: `UILabel`)
///     - `bodyLabel` (type: `UILabel`)
///     - `footnoteLabel`  (type: `UILabel`)
///     - `primaryButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
///     - `secondaryButton`  (type: ``SecondaryButton`` inherits from ``UIButton``)
public final class GDSCentreAlignedScreen: BaseViewController, TitledViewControllerV2 {
    
    let defaultSpacing = 16.0 // Use Design system when available
    
    lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.font = UIFont(
            style: .largeTitle,
            weight: .bold,
            design: .default
        )
        result.text = viewModel.title.value
        result.accessibilityIdentifier = "centre-aligned-screen-title"
        result.accessibilityTraits = [.header]
        result.textAlignment = .center
        result.lineBreakMode = .byTruncatingTail
        result.numberOfLines = 0
        return result
    }()
    
    private lazy var bodyLabel: UILabel = {
        let result = UILabel()
        if let bodyContent = viewModel.body {
            result.text = bodyContent.value
        } else {
            result.isHidden = true
        }
        result.font = UIFont(style: .body)
        result.adjustsFontForContentSizeCategory = true
        result.accessibilityIdentifier = "centre-aligned-screen-body"
        result.textAlignment = .center
        result.lineBreakMode = .byTruncatingTail
        result.numberOfLines = 0
        return result
    }()
    
    private lazy var containerStackView: UIStackView = {
        let result = UIStackView(
            views: [
                scrollView,
                bottomStackView
            ],
            distribution: .fill
        )
        result.accessibilityIdentifier = "centre-aligned-screen-container-stack-view"
        return result
    }()
    
    private lazy var scrollView: UIScrollView = {
        let result = UIScrollView()
        result.contentLayoutGuide.widthAnchor.constraint(equalTo: result.widthAnchor).isActive = true
        result.addSubview(scrollViewOuterStackView)
        scrollViewOuterStackView.bindToSuperviewEdges()
        return result
    }()
    
    private lazy var scrollViewOuterStackView: UIStackView = {
        let result = UIStackView(
            views: [
                topSpacer,
                scrollViewInnerStackView,
                bottomSpacer
            ],
            distribution: .equalSpacing
        )
        return result
    }()
    
    private lazy var topSpacer: UIView = {
        let result = UIView()
        result.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return result
    }()
    
    private lazy var bottomSpacer: UIView = {
        let result = UIView()
        result.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return result
    }()
    
    private lazy var scrollViewInnerStackView: UIStackView = {
        let result = UIStackView(
            views: [
                imageView,
                titleLabel,
                bodyLabel
            ],
            spacing: defaultSpacing,
            distribution: .equalSpacing
        )
        
        if let viewModel = viewModel as? GDSCentreAlignedViewModelWithChildView {
            result.addArrangedSubview(viewModel.childView)
        }
        result.accessibilityIdentifier = "centre-aligned-screen-optional-stack-view"
        return result
    }()
    
    private lazy var imageView: UIImageView = {
        let result = UIImageView()
        
        if let viewModel = viewModel as? GDSCentreAlignedViewModelWithImage {
            let font = UIFont(style: .largeTitle, weight: viewModel.imageWeight ?? .semibold)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            
            result.image = UIImage(systemName: viewModel.image, withConfiguration: configuration)
            result.tintColor = viewModel.imageColour ?? .gdsPrimary
            result.contentMode = .scaleAspectFit
            
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
                result.heightAnchor.constraint(greaterThanOrEqualToConstant: heightConstraint)
            ])
        } else {
            result.isHidden = true
        }
        result.accessibilityIdentifier = "centre-aligned-screen-image"
        
        return result
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let result = UIStackView(
            views: [
                footnoteLabel,
                primaryButton,
                secondaryButton
            ],
            spacing: defaultSpacing
        )
        result.accessibilityIdentifier = "centre-aligned-screen-bottom-stack-view"
        return result
    }()
    
    private lazy var footnoteLabel: UILabel = {
        let result = UILabel()
        result.numberOfLines = 0
        result.textAlignment = .center
        
        if let viewModel = viewModel as? GDSInformationViewModelWithOptionalFootnote {
            result.font = UIFont(style: .footnote)
            result.text = viewModel.footnote?.value
        } else if let viewModel = viewModel as? GDSCentreAlignedViewModelWithFootnote {
            result.font = UIFont(style: .footnote)
            result.text = viewModel.footnote.value
        } else {
            result.isHidden = true
        }
        result.accessibilityIdentifier = "centre-aligned-screen-footnote"
        result.adjustsFontForContentSizeCategory = true
        result.textColor = .gdsDarkGrey
        return result
    }()
    
    // TODO: DCMAW-12110 - Revisit how we handle buttons to support a tertiary button, or array of buttons in ViewModel
    
    private lazy var primaryButton: RoundedButton = {
        let result = RoundedButton()
        
        if let buttonViewModel = viewModel as? GDSInformationViewModelWithOptionalPrimaryButton,
           let button = buttonViewModel.primaryButtonViewModel {
            result.setTitle(button.title.value, for: .normal)
        } else if let buttonViewModel = viewModel as? GDSCentreAlignedViewModelWithPrimaryButton {
            result.setTitle(buttonViewModel.primaryButtonViewModel.title.value, for: .normal)
            result.accessibilityHint = buttonViewModel.primaryButtonViewModel.accessibilityHint?.value
            if let icon = buttonViewModel.primaryButtonViewModel.icon {
                result.symbolPosition = icon.symbolPosition
                result.icon = icon.iconName
            }
        } else {
            result.isHidden = true
        }
        result.accessibilityIdentifier = "centre-aligned-screen-primary-button"
        result.addAction { [unowned self] in
            if let buttonViewModel = viewModel as? GDSCentreAlignedViewModelWithPrimaryButton {
                buttonViewModel.primaryButtonViewModel.action()
            }
        }
        return result
    }()
    
    private lazy var secondaryButton: SecondaryButton = {
        let result = SecondaryButton()
        
        if let buttonViewModel = viewModel as? GDSInformationViewModelWithOptionalSecondaryButton,
           let button = buttonViewModel.secondaryButtonViewModel {
            result.setTitle(button.title, for: .normal)
            result.titleLabel?.textAlignment = .center
            
            if let icon = button.icon {
                result.symbolPosition = icon.symbolPosition
                result.icon = icon.iconName
            }
        } else if let buttonViewModel = viewModel as? GDSCentreAlignedViewModelWithSecondaryButton {
            result.setTitle(buttonViewModel.secondaryButtonViewModel.title.value, for: .normal)
            result.titleLabel?.textAlignment = .center
            result.titleLabel?.textColor = .gdsGreen
            result.accessibilityHint = buttonViewModel.secondaryButtonViewModel.accessibilityHint?.value
            
            if let icon = buttonViewModel.secondaryButtonViewModel.icon {
                result.symbolPosition = icon.symbolPosition
                result.icon = icon.iconName
            }
        } else {
            result.isHidden = true
        }
        result.accessibilityIdentifier = "centre-aligned-screen-secondary-button"
        result.addAction { [unowned self] in
            if let buttonViewModel = viewModel as? GDSInformationViewModelWithOptionalSecondaryButton {
                buttonViewModel.secondaryButtonViewModel?.action()
            } else if let buttonViewModel = viewModel as? GDSCentreAlignedViewModelWithSecondaryButton {
                buttonViewModel.secondaryButtonViewModel.action()
            }
        }
        
        result.isUserInteractionEnabled = true
        return result
    }()
    
    private func setup() {
        self.view.addSubview(containerStackView)
        containerStackView.bindToSuperviewSafeArea(
            insetBy: UIEdgeInsets(
                top: 0,
                left: defaultSpacing,
                bottom: 0,
                right: defaultSpacing
            )
        )
        self.view.backgroundColor = .systemBackground
        addRelativeViewConstraints()
    }
    
    private func addRelativeViewConstraints() {
        scrollViewOuterStackView.heightAnchor.constraint(
            greaterThanOrEqualTo: scrollView.heightAnchor
        ).isActive = true
    }
    
    public private(set) var viewModel: GDSCentreAlignedViewModel
    
    public init(
        viewModel: GDSCentreAlignedViewModel
    ) {
        self.viewModel = viewModel
        super.init(
            viewModel: viewModel as? BaseViewModel,
            nibName: nil,
            bundle: Bundle.module
        )
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @available(*, unavailable, renamed: "init(viewModel:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal var isFootnoteInScrollView = false
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkBottomStackHeight()
    }
    
    private func checkBottomStackHeight() {
        let footnoteHeight = footnoteLabel.frame.height
        let bottomStackHeight = bottomStackView.frame.height
        let screenHeight = UIScreen.main.bounds.height
        
        // if bottom stack covers more than 1/3 of screen
        if bottomStackHeight >= screenHeight / 3,
           !(isFootnoteInScrollView) {
            moveFootnoteToScrollView()
        } else if (bottomStackHeight + footnoteHeight) < screenHeight / 3,
                  isFootnoteInScrollView {
            moveFootnoteToBottomStackView()
        }
    }
    
    private func moveFootnoteToScrollView() {
        if footnoteLabel.superview == bottomStackView {
            // remove footnote from bottom stack
            bottomStackView.removeArrangedSubview(footnoteLabel)
            footnoteLabel.removeFromSuperview()
            isFootnoteInScrollView = true
            
            // add to scroll view
            scrollViewInnerStackView.addArrangedSubview(footnoteLabel)
            footnoteLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func moveFootnoteToBottomStackView() {
        if  footnoteLabel.superview != bottomStackView {
            // remove from scroll view
            scrollViewInnerStackView.removeArrangedSubview(footnoteLabel)
            footnoteLabel.removeFromSuperview()
            isFootnoteInScrollView = false
            
            // add to stack
            bottomStackView.insertArrangedSubview(footnoteLabel, at: 0)
            view.layoutIfNeeded()
        }
    }
}
// swiftlint: enable type_body_length
