import UIKit

final public class GDSContentTileV2: UIView {
    public let viewModel: GDSContentTileViewModel
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: GDSContentTileViewModel, frame: CGRect = .zero) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp() {
        backgroundColor = viewModel.backgroundColour
        addSubview(containerStackView)
        containerStackView.bindToSuperviewEdges()
    }
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            views: [
                imageStackView
            ],
            spacing: 12,
            distribution: .fill
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 12
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(
            views: [
                imageView,
                captionLabel
            ],
            spacing: 12,
            distribution: .fill
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        if let viewModel = viewModel as? GDSContentTileViewModelWithImage {
            imageView.image = viewModel.image
            imageView.contentMode = .scaleAspectFill
            imageView.heightAnchor.constraint(equalToConstant: viewModel.image.size.height).isActive = true
        } else {
            imageView.isHidden = true
        }
        return imageView
    }()
    
    private lazy var captionLabel: UILabel = {
        let caption = UILabel()
        if let viewModel = viewModel as? GDSContentTileViewModelWithCaption {
            caption.text = viewModel.caption.value
            caption.font = UIFont(style: .subheadline, weight: .regular)
            caption.adjustsFontForContentSizeCategory = true
            caption.textAlignment = .left
            caption.numberOfLines = 0
        } else {
            caption.isHidden = true
        }
        caption.accessibilityIdentifier = "numbered-list-title"
        return caption
    }()
}
