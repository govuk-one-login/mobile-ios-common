import AVFoundation
import GDSAnalytics
import UIKit

protocol WelcomeScreenCoordinator: AnyObject {
    func presentUpdateAppView()
    func retrieveAuthSessionID(using sessionType: AuthenticationSession.Type)
    func showNetworkError(error: LoggableError)
    func showAnalyticsPermission()
    func presentAppUnavailableView()
    func showSomethingWentWrong(error: Error)
    func showLinkAppWithSafari()
}

final class WelcomeViewController: UIViewController {
    override var nibName: String? { "Welcome" }
    private weak var coordinator: WelcomeScreenCoordinator?
    private let updateService: AppInformationServicing

    var analyticsStatus: AnalyticsStatusProtocol

    init(coordinator: WelcomeScreenCoordinator,
         updateService: AppInformationServicing = AppInformationService(),
         analyticsStatus: AnalyticsStatusProtocol = UserDefaults.standard) {
        self.coordinator = coordinator
        self.updateService = updateService
        self.analyticsStatus = analyticsStatus
        super.init(nibName: "Welcome", bundle: nil)
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
            titleLabel.text = NSLocalizedString(key: "welcomeTitle")
            titleLabel.accessibilityIdentifier = "welcome-title"
        }
    }
    
    @IBOutlet private var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.text = NSLocalizedString(key: "welcomeSubtitle", NSLocalizedString(key: "appName"))
            subtitleLabel.accessibilityIdentifier = "welcome-subtitle"
        }
    }
    
    @IBOutlet private var button: RoundedButton! {
        didSet {
            button.setTitle(NSLocalizedString(key: "continueButton"), for: .normal)
            button.accessibilityIdentifier = "welcome-button"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        setBackButtonTitle()
    }

    @IBAction private func didTapContinueButton() {
        button.isLoading = true
        checkAvailabilityAndAppVersion()
    }
    
    private func checkAvailabilityAndAppVersion() {
        Task {
            do {
                let appInfo = try await updateService.fetchAppInfo()
                AppEnvironment.current.updateReleaseFlags(appInfo.releaseFlags)
                
                // Check if the app is available
                guard appInfo.allowAppUsage else {
                    coordinator?.presentAppUnavailableView()
                    button.isLoading = false
                    return
                }
                // Check if the app meets the minimum version requirements
                guard updateService.currentVersion >= appInfo.minimumVersion else {
                    coordinator?.presentUpdateAppView()
                    button.isLoading = false
                    return
                }
                checkAnalyticsStatus()
            } catch let error as URLError where error.code == .notConnectedToInternet {
                coordinator?.showNetworkError(error: error)
            } catch {
                coordinator?.showSomethingWentWrong(error: error)
            }
            button.isLoading = false
        }
    }
    
    private func checkAnalyticsStatus() {
        guard analyticsStatus.hasAcceptedAnalytics == nil else {
            coordinator?.retrieveSessionID()
            return
        }
        coordinator?.showAnalyticsPermission()
    }
}
