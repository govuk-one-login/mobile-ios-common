import UIKit

/// View controller for `ResultsView` screen.
public final class ResultsViewController: UIViewController {
    public override var nibName: String? { "ResultsView" }
    
    public let viewModel: ResultsViewModel

    public init(viewModel: ResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ResultsView", bundle: .module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            let font = UIFont(style: .largeTitle, weight: .medium)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            let image = UIImage(systemName: viewModel.image, withConfiguration: configuration)
            imageView.image = image
            imageView.accessibilityIdentifier = "results-image"
        }
    }
    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold, design: .default)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityIdentifier = "results-title"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body?.value
            bodyLabel.accessibilityIdentifier = "results-body"
        }
    }
    
    @IBOutlet private var resultsButton: RoundedButton! {
        didSet {
            resultsButton.setTitle(viewModel.resultsButtonViewModel.title, for: .normal)
            resultsButton.accessibilityIdentifier = "results-button"
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        setBackButtonTitle()
        viewModel.didAppear()
    }

    @IBAction func didTapDoneButton() {
        resultsButton.isLoading = true
        viewModel.resultsButtonViewModel.action()
        resultsButton.isLoading = false
    }
}
