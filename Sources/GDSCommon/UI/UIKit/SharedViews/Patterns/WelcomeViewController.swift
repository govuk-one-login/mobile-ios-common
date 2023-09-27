import UIKit

public final class WelcomeViewController: UIViewController {
    public override var nibName: String? { "Welcome" }
    
    private let viewModel: WelcomeViewModel
    private let appQualifyingService: AppQualifyingService

    public init(viewModel: WelcomeViewModel,
         appQualifyingService: AppQualifyingService) {
        self.viewModel = viewModel
        self.appQualifyingService = appQualifyingService
        super.init(nibName: "Welcome", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(coordinator:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var welcomeImage: UIImageView! {
        didSet {
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
            bodyLabel.accessibilityIdentifier = "welcome-subtitle"
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
        appQualifyingService.checkAvailabilityAndAppVersion()
        viewModel.welcomeButtonViewModel.action()
        welcomeButton.isLoading = false
    }
}
