import UIKit

public final class ErrorViewController: BaseViewController {
    public override var nibName: String? { "Error" }
    
    private let viewModel: ErrorViewModel

    public init(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "Error", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(coordinator:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.image = viewModel.image
            imageView.accessibilityIdentifier = "error-image"
        }
    }
}
