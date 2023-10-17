import UIKit

public final class IconScreenViewController: UIViewController {
    public override var nibName: String? { "IconScreenView" }
    
    let viewModel: IconScreenViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: IconScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "IconScreenView", bundle: .module)
    }
    
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            let font = UIFont(style: .largeTitle, weight: .light)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            let image = UIImage(systemName: viewModel.imageName, withConfiguration: configuration)
            imageView.image = image
            imageView.accessibilityIdentifier = "icon-screen-image"
        }
    }

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityTraits = .header
            titleLabel.accessibilityIdentifier = "icon-screen-title"
        }
    }

    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body.value
            bodyLabel.accessibilityIdentifier = "icon-screen-body"
        }
    }
    
    @IBOutlet private var contentView: UIStackView! {
        didSet {
            viewModel.childViews.forEach { contentView.addArrangedSubview($0) }
        }
    }
}
