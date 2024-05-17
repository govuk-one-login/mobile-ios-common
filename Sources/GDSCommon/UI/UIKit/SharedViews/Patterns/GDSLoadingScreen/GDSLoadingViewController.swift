import Foundation
import UIKit

/// View controller for `GDSLoading` screen.
///   - `loadingLabel` (type: `UILabel`)
/// It is initialised with a `viewModel` of type: `GDSLoadingViewModel`
/// This screen is typically used to as a loading screen for asynchronous tasks to inform the user and prevent interaction with the app UI.
public final class GDSLoadingViewController: BaseViewController {
    public override var nibName: String? { "GDSLoading" }
    private let viewModel: GDSLoadingViewModel

    public init(viewModel: GDSLoadingViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "GDSLoading", bundle: .module)
    }

    @available(*, unavailable, renamed: "init(viewModel:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet private var loadingLabel: UILabel! {
        didSet {
            loadingLabel.text = viewModel.loadingLabelKey.value
            loadingLabel.accessibilityIdentifier = "loadingLabel"
        }
    }
}
