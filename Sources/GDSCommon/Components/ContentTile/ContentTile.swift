import Foundation
import UIKit

public final class ContentTile: NibView {
    public let viewModel: ContentTileViewModel
    
    public init(frame: CGRect, viewModel: ContentTileViewModel) {
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
        }
    }
    
    @IBOutlet weak var containerStackView: UIStackView! {
        didSet {
            containerStackView.translatesAutoresizingMaskIntoConstraints = false
            containerStackView.accessibilityIdentifier = "containerStackView"
            
            containerStackView.addSubview(closeButton)
            NSLayoutConstraint.activate([
                closeButton.trailingAnchor.constraint(greaterThanOrEqualTo: containerStackView.trailingAnchor, constant: -16),
                closeButton.topAnchor.constraint(greaterThanOrEqualTo: containerStackView.topAnchor, constant: 8)
            ])
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            if viewModel.image != nil {
                imageView.image = viewModel.image
            }
            imageView.accessibilityIdentifier = "content-tile-image"
        }
    }
    
    @IBOutlet weak var textStack: UIStackView! {
        didSet {
            textStack.spacing = 8
            textStack.layoutMargins = UIEdgeInsets(top: 8, 
                                                   left: 16,
                                                   bottom: 0,
                                                   right: 16)
            textStack.isLayoutMarginsRelativeArrangement = true
            textStack.accessibilityIdentifier = "content-text-stack"
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
            captionLabel.accessibilityIdentifier = "content-tile-caption"
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
            titleLabel.accessibilityIdentifier = "content-tile-title"
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
            bodyLabel.accessibilityIdentifier = "content-tile-body"
        }
    }
    
    @IBOutlet weak var separatorStack: UIStackView! {
        didSet {
            let separatorView = SeparatorView()
            separatorStack.addArrangedSubview(separatorView)
            separatorStack.layoutMargins = UIEdgeInsets(top: 8,
                                                   left: 16,
                                                   bottom: 0,
                                                   right: 0)
            separatorStack.isLayoutMarginsRelativeArrangement = true
            separatorStack.accessibilityIdentifier = "content-tile-separator"
        }
    }
    
    
    @IBOutlet weak var buttonStack: UIStackView! {
        didSet {
            buttonStack.spacing = 16
            buttonStack.layoutMargins = UIEdgeInsets(top: 8,
                                                   left: 16,
                                                   bottom: 16,
                                                   right: 16)
            buttonStack.isLayoutMarginsRelativeArrangement = true
            
            buttonStack.backgroundColor = .yellow
        }
    }
    
    @IBOutlet weak var secondaryButton: SecondaryButton! {
        didSet {
            if let buttonViewModel = viewModel.secondaryButtonViewModel {
                secondaryButton.setTitle(buttonViewModel.title.value, for: .normal)
                secondaryButton.titleLabel?.textColor = .gdsGreen
                secondaryButton.contentHorizontalAlignment = .left
                if let icon = buttonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else {
                secondaryButton.isHidden = true
            }
            secondaryButton.accessibilityIdentifier = "content-tile-link"
            secondaryButton.backgroundColor = .white
        }
    }
    
    @IBAction func secondaryButtonAction(_ sender: Any) {
        viewModel.secondaryButtonViewModel?.action()
    }
    
    @IBOutlet weak var primaryButton: RoundedButton! {
        didSet {
            primaryButton.setTitle(viewModel.primaryButtonViewModel?.title.value, for: .normal)
            primaryButton.accessibilityIdentifier = "content-tile-button"
        }
    }
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
        primaryButton.isLoading = true
        viewModel.primaryButtonViewModel?.action()
        primaryButton.isLoading = false
    }
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        let font = UIFont(style: .body, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: font, scale: .default)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: configuration), for: .normal)
        button.tintColor = .gdsGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    @objc private func close() {
        viewModel.dismissButton?.action()
    }
}
