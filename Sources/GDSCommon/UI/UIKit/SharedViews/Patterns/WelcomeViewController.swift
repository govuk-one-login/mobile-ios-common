import UIKit

/// View controller for `WelcomeView` screen.
///   - `welcomeImage` (type: `UIImageView`)
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   - `welcomeButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
///
/// A navigation item can be configured:
/// - Back button via setting the `hideBackButton` boolean property on the view controller
/// The `viewWillAppear` lifecycle event triggers the `didAppear` method in the viewModel.
/// The `welcomeButton`'s action is set from the ``ButtonViewModel`` in the viewModel.
public final class WelcomeViewController: UIViewController {
    public override var nibName: String? { "WelcomeView" }
    
    private let viewModel: WelcomeViewModel

    public init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "WelcomeView", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(coordinator:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var welcomeImage: UIImageView! {
        didSet {
            welcomeImage.image = viewModel.image
            welcomeImage.accessibilityIdentifier = "welcome-image"
        }
    }
    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold, design: .default)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityIdentifier = "welcome-title"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body.value
            bodyLabel.accessibilityIdentifier = "welcome-body"
        }
    }
    
    @IBOutlet private var welcomeButton: RoundedButton! {
        didSet {
            welcomeButton.setTitle(viewModel.welcomeButtonViewModel.title, for: .normal)
            welcomeButton.accessibilityIdentifier = "welcome-button"
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        setBackButtonTitle()
        viewModel.didAppear()
    }

    @IBAction private func didTapContinueButton() {
        welcomeButton.isLoading = true
        viewModel.welcomeButtonViewModel.action()
        welcomeButton.isLoading = false
    }
}
