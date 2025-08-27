import UIKit

public class GDSErrorScreen: BaseViewController, TitledViewControllerV2 {
    
    public private(set) var viewModel: GDSErrorViewModelV3
        
    let defaultSpacing = 16.0 // Use Design system when available
    
    private lazy var containerStackView: UIStackView = {
        let result = UIStackView(
            views: [
                scrollView,
                bottomStackView
            ],
            spacing: 0,
            distribution: .fill
        )
        result.accessibilityIdentifier = "error-screen-container-stack-view"
        return result
    }()
    
    private lazy var scrollView: UIScrollView = {
        let result = UIScrollView()
        result.contentLayoutGuide.widthAnchor.constraint(equalTo: result.widthAnchor).isActive = true
        result.addSubview(scrollViewOuterStackView)
        result.accessibilityIdentifier = "error-screen-container-scrollview"
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
        result.accessibilityIdentifier = "error-screen-outer-stack-view"
        return result
    }()
    
    private lazy var topSpacer: UIView = {
        let result = UIView()
        result.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return result
    }()
    
    private lazy var scrollViewInnerStackView: UIStackView = {
        let result = UIStackView(
            views: [
                scrollViewIconTitleStackView,
                bodyContentStackView
            ],
            spacing: defaultSpacing,
            distribution: .equalSpacing
        )
        result.isLayoutMarginsRelativeArrangement = true
        result.layoutMargins = UIEdgeInsets(top: 0, left: defaultSpacing, bottom: 0, right: defaultSpacing)
        result.accessibilityIdentifier = "error-screen-inner-stack-view"
        return result
    }()
    
    private lazy var scrollViewIconTitleStackView: UIStackView = {
        let result = UIStackView(
            views: [
                imageView,
                titleLabel
            ],
            spacing: defaultSpacing,
            distribution: .equalSpacing
        )
        result.accessibilityIdentifier = "error-screen-icon-title-stack-view"
        result.shouldGroupAccessibilityChildren = true
        result.accessibilityTraits = [.header]
        result.isAccessibilityElement = true
        result.accessibilityLabel = "\(viewModel.image.voiceoverPrefix): \(viewModel.title) :"
        return result
    }()
    
    private lazy var bottomSpacer: UIView = {
        let result = UIView()
        result.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return result
    }()
    
    private lazy var imageView: UIImageView = {
        let result = UIImageView()
        let font = UIFont(style: .largeTitle, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
        
        result.image = UIImage(
            systemName: viewModel.image.icon,
            withConfiguration: configuration
        )
        result.tintColor = .gdsPrimary
        result.contentMode = .scaleAspectFit
        result.adjustsImageSizeForAccessibilityContentSizeCategory = true
        NSLayoutConstraint.activate([
            result.heightAnchor.constraint(greaterThanOrEqualToConstant: 107)
        ])
        result.accessibilityIdentifier = "error-screen-image"
        return result
    }()
    
    lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.font = UIFont(
            style: .largeTitle,
            weight: .bold,
            design: .default
        )
        result.text = viewModel.title.value
        result.accessibilityIdentifier = "error-screen-title"
        result.adjustsFontForContentSizeCategory = true
        result.textAlignment = .center
        result.numberOfLines = 0
        return result
    }()
    
    private lazy var bodyContentStackView: UIStackView = {
        let result = UIStackView(
            views: bodyContentViews,
            spacing: defaultSpacing,
            distribution: .equalSpacing
        )
        result.accessibilityIdentifier = "error-screen-body-content-stack-view"
        return result
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let hasButtons = !viewModel.buttonViewModels.isEmpty
        let result = UIStackView(
            views: [
                buttonStackView
            ],
            spacing: defaultSpacing,
            distribution: hasButtons ? .fillProportionally : .equalCentering
        )
        result.isLayoutMarginsRelativeArrangement = true
        result.layoutMargins = UIEdgeInsets(top: 16, left: defaultSpacing, bottom: 16, right: defaultSpacing)
        result.accessibilityIdentifier = "error-screen-bottom-stack-view"
        return result
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let result = UIStackView(
            views: buttonViews,
            spacing: defaultSpacing
        )
        result.axis = .vertical
        result.spacing = defaultSpacing
        result.accessibilityIdentifier = "error-screen-button-stack-view"
        return result
    }()
    
    private var buttonViews: [UIView] {
        var views: [UIView] = []
        for (index, buttonViewModel) in viewModel.buttonViewModels.enumerated() {
            views.append(buttonForButtonViewModel(
                buttonViewModel,
                index
            ))
        }
        return views
    }
    
    public init(
        viewModel: GDSErrorViewModelV3
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
    
    private func buttonForButtonViewModel(
        _ buttonViewModel: ButtonViewModel,
        _ index: Int
    ) -> UIButton {
        let isPrimaryButton = index == 0
        let result = isPrimaryButton ? RoundedButton() : SecondaryButton()
        
        result.setTitle(buttonViewModel.title.value, for: .normal)
        result.titleLabel?.textAlignment = .center
        result.accessibilityHint = buttonViewModel.accessibilityHint?.value
        if let icon = buttonViewModel.icon {
            result.symbolPosition = icon.symbolPosition
            result.icon = icon.iconName
        }
        
        result.accessibilityIdentifier = "error-screen-button-\(index)"
        
        if !isPrimaryButton {
            result.setTitleColor(.accent, for: .normal)
        }
        
        result.addAction {
            if let result = result as? RoundedButton {
                result.isLoading = buttonViewModel.shouldLoadOnTap
                result.isEnabled = false
            }
            buttonViewModel.action()
        }
        return result
    }
    
    private func setup() {
        self.view.addSubview(containerStackView)
        containerStackView.bindToSuperviewSafeArea(insetBy: .zero)
        self.view.backgroundColor = .systemBackground
        addRelativeViewConstraints()
    }
    
    private func addRelativeViewConstraints() {
        scrollViewOuterStackView.heightAnchor.constraint(
            greaterThanOrEqualTo: scrollView.heightAnchor
        ).isActive = true
    }
    
    private lazy var bodyContentViews: [UIView] = {
        viewModel.bodyContent.map(\.uiView)
    }()
}
