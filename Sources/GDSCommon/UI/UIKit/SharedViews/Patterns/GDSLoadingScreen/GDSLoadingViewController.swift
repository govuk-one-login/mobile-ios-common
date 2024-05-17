import Foundation
import UIKit

public final class GDSLoadingViewController: BaseViewController {
    public override var nibName: String? { "GDSLoading" }
    private let viewModel: GDSLoadingViewModel

    public init(viewModel: GDSLoadingViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "GDSLoading", bundle: .module)
    }

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
