import UIKit

public final class LinkTheAppViewController: UIViewController {
    public override var nibName: String? { "LinkTheApp" }
    
    let viewModel: LinkTheAppViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: LinkTheAppViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LinkTheApp", bundle: .module)
    }
    
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            let font = UIFont(style: .largeTitle, weight: .light)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            let image = UIImage(systemName: viewModel.imageName, withConfiguration: configuration)
            imageView.image = image
            imageView.accessibilityIdentifier = "error-image"
        }
    }

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityIdentifier = "error-title"
        }
    }

    @IBOutlet private var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.text = viewModel.subtitle.value
            subtitleLabel.accessibilityIdentifier = "error-subtitle"
        }
    }
}
