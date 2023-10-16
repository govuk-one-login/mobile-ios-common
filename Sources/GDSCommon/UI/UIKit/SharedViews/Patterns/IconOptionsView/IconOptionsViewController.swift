import UIKit

public final class IconOptionsViewController: UIViewController {
    public override var nibName: String? { "IconOptionsView" }
    
    let viewModel: IconOptionsViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: IconOptionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "IconOptionsView", bundle: .module)
    }
    
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            let font = UIFont(style: .largeTitle, weight: .light)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            let image = UIImage(systemName: viewModel.imageName, withConfiguration: configuration)
            imageView.image = image
            imageView.accessibilityIdentifier = "options-image"
        }
    }

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityTraits = .header
            titleLabel.accessibilityIdentifier = "options-title"
        }
    }

    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body.value
            bodyLabel.accessibilityIdentifier = "options-body"
        }
    }
    
    @IBOutlet private var contentView: UIStackView! {
        didSet {
            viewModel.contentViews.forEach { contentView.addArrangedSubview($0) }
        }
    }
}
