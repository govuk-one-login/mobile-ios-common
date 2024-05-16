import Foundation
import UIKit

public final class GDSLoadingViewController: BaseViewController {
    public override var nibName: String? { "GDSLoadingScreen" }
    private let viewModel: GDSLoadingViewModel

    public init(viewModel: GDSLoadingViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "GDSLoadingScreen", bundle: .module)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet private var loadingLabel: UILabel! {
        didSet {
            loadingLabel.text = NSLocalizedString(key: viewModel.loadingLabelKey)
            loadingLabel.accessibilityIdentifier = "loadingLabel"
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setBackButtonTitle()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
