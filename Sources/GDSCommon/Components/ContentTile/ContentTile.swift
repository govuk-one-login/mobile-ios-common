import Foundation
import UIKit

public final class ContentTile: NibView {
    public let viewModel: ContentTileViewModel
    
    public init(frame: CGRect, viewModel: ContentTileViewModel
    ) {
        self.viewModel = viewModel
        super.init(frame: frame, bundle: .module)
        self.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        @IBOutlet var containerView: UIView! {
        didSet {
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.layer.cornerRadius = 16
            containerView.widthAnchor.constraint(equalToConstant: CGFloat(343)).isActive = true
            containerView.layer.masksToBounds = true
            containerView.accessibilityIdentifier = "containerView"
            
            containerView.backgroundColor = .blue
        }
    }
    
    @IBOutlet weak var containerStackView: UIStackView! {
        didSet {
            containerStackView.translatesAutoresizingMaskIntoConstraints = false
            containerStackView.accessibilityIdentifier = "containerStackView"
            
            containerStackView.backgroundColor = .red
        }
    }
    
    @IBOutlet weak var imageContainerView: UIView! {
        didSet {
            imageContainerView.backgroundColor = .green
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = viewModel.image
            imageView.backgroundColor = .black
        }
    }
    
    @IBOutlet weak var bottomStackView: UIStackView! {
        didSet {
            bottomStackView.backgroundColor = .orange
        }
    }
    
    @IBOutlet weak var textStack: UIStackView! {
        didSet {
//            let topStackView = UIStackView()
//            topStackView.axis = .horizontal
//            topStackView.addArrangedSubview(captionLabel)
//            topStackView.addArrangedSubview(closeButton)
//            textStack.addSubview(topStackView)
            textStack.spacing = 8
        }
    }
    
    @IBOutlet weak var captionLabel: UILabel! {
        didSet {
            captionLabel.text = viewModel.caption?.value
            captionLabel.font = UIFont(style: .subheadline, weight: .regular)
            captionLabel.numberOfLines = 0
            captionLabel.adjustsFontForContentSizeCategory = true
            captionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            captionLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.font = .bodyBold
            titleLabel.adjustsFontForContentSizeCategory = true
            titleLabel.numberOfLines = 0
            titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body?.value
            bodyLabel.font = .body
            bodyLabel.numberOfLines = 0
            bodyLabel.adjustsFontForContentSizeCategory = true
            bodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var separatorStack: UIStackView! {
        didSet {
            let separatorView = SeparatorView()
            separatorStack.addArrangedSubview(separatorView)
        }
    }
    
    
    @IBOutlet weak var buttonStack: UIStackView! {
        didSet {
            buttonStack.backgroundColor = .purple
        }
    }
    
    @IBOutlet weak var linkButton: SecondaryButton! {
        didSet {
            linkButton.titleLabel?.text = viewModel.actionText?.title.value
//            linkButton.icon = viewModel.actionText?.icon?.iconName
//            linkButton.symbolPosition = .afterTitle
            linkButton.titleLabel?.textColor = .gdsGreen
            linkButton.contentHorizontalAlignment = .left
        }
    }
    
    @IBOutlet weak var primaryButton: RoundedButton! {
        didSet {
            primaryButton.titleLabel?.text = viewModel.actionButton?.title.value
        }
    }
    
    
}
