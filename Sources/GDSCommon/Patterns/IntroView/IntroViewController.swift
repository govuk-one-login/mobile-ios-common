import UIKit

/// View controller for `IntroView` screen.
///   - `introImage` (type: `UIImageView`)
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   - `introButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
///
/// A navigation item can be configured:
/// - Back button via setting the `hideBackButton` boolean property on the view controller
/// The `viewWillAppear` lifecycle event triggers the `didAppear` method in the viewModel.
/// The `introButton`'s action is set from the ``ButtonViewModel`` in the viewModel.
public final class IntroViewController: BaseViewController, TitledViewController {
    public override var nibName: String? { "IntroView" }
    
    private let viewModel: IntroViewModel

    public init(viewModel: IntroViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "IntroView", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(viewModel:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var introImage: UIImageView! {
        didSet {
            introImage.image = viewModel.image
            introImage.isAccessibilityElement = true
            introImage.accessibilityLabel = viewModel.accessibilityLabel?.value
            introImage.accessibilityTraits = .image
            introImage.accessibilityIdentifier = "intro-image"
        }
    }
    
    @IBOutlet private(set) var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold, design: .default)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityIdentifier = "intro-title"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body.value
            bodyLabel.accessibilityIdentifier = "intro-body"
        }
    }
    
    @IBOutlet private var introButton: RoundedButton! {
        didSet {
            introButton.setTitle(viewModel.introButtonViewModel.title, for: .normal)
            introButton.accessibilityIdentifier = "intro-button"
        }
    }

    @IBAction private func introButtonAction() {
        introButton.isLoading = true
        viewModel.introButtonViewModel.action()
    }
    
    public func enableIntroButton() {
        introButton.isLoading = false
    }
}
