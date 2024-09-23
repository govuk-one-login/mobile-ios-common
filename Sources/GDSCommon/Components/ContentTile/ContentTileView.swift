import Foundation
import UIKit

public final class ContentTileView: NibView {
    public let viewModel: ContentTileViewModel
    
    public init(frame: CGRect, viewModel: ContentTileViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame, bundle: .module)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 16
            containerView.layer.masksToBounds = true
            containerView.accessibilityIdentifier = "containerView"
        }
    }
    
    @IBOutlet private var containerStackView: UIStackView! {
        didSet {
            containerStackView.accessibilityIdentifier = "containerStackView"
            
            containerStackView.addSubview(closeButton)
            NSLayoutConstraint.activate([
                closeButton.trailingAnchor.constraint(greaterThanOrEqualTo: containerStackView.trailingAnchor, constant: -16),
                closeButton.topAnchor.constraint(greaterThanOrEqualTo: containerStackView.topAnchor, constant: 8)
            ])
        }
    }
    
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.accessibilityIdentifier = "content-tile-image"
            if let viewModel = viewModel as? ContentTileViewModelWithImage {
                guard view.image.size.height > 0 else {
                    return
                }
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: view.image.size.width / view.image.size.height)
                ])
                imageView.image = view.image
            } else {
                imageView.isHidden = true
            }
        }
    }
    
    @IBOutlet private var textStack: UIStackView! {
        didSet {
            textStack.spacing = 8
            textStack.layoutMargins = UIEdgeInsets(top: 8,
                                                   left: 16,
                                                   bottom: 0,
                                                   right: 16)
            textStack.isLayoutMarginsRelativeArrangement = true
            textStack.accessibilityIdentifier = "content-text-stack"
            textStack.backgroundColor = viewModel.backgroundColour
        }
    }
    
    @IBOutlet private var captionLabel: UILabel! {
        didSet {
            if let view = viewModel as? ContentTileViewModelWithCaption {
                captionLabel.text = view.caption.value
                captionLabel.font = UIFont(style: .subheadline, weight: .regular)
                captionLabel.numberOfLines = 0
                captionLabel.adjustsFontForContentSizeCategory = true
                captionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
                captionLabel.translatesAutoresizingMaskIntoConstraints = false
            } else {
                captionLabel.isHidden = true
            }
            captionLabel.accessibilityIdentifier = "content-tile-caption"
        }
    }
    
    @IBOutlet private var titleLabel: UILabel! {
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
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            if let view = viewModel as? ContentTileViewModelWithBody {
                bodyLabel.text = view.body.value
                bodyLabel.font = .body
                bodyLabel.numberOfLines = 0
                bodyLabel.adjustsFontForContentSizeCategory = true
                bodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)
                bodyLabel.translatesAutoresizingMaskIntoConstraints = false
            } else {
                bodyLabel.isHidden = true
            }
            bodyLabel.accessibilityIdentifier = "content-tile-body"
        }
    }
    
    @IBOutlet private var separatorStack: UIStackView! {
        didSet {
            separatorStack.isHidden = !viewModel.showSeparatorLine
            
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
    
    
    @IBOutlet private var buttonStack: UIStackView! {
        didSet {
            buttonStack.spacing = 16
            buttonStack.layoutMargins = UIEdgeInsets(top: 8,
                                                     left: 16,
                                                     bottom: 16,
                                                     right: 16)
            buttonStack.isLayoutMarginsRelativeArrangement = true
            buttonStack.backgroundColor = viewModel.backgroundColour
            
            buttonStack.addArrangedSubview(secondaryButton)
            buttonStack.addArrangedSubview(primaryButton)
        }
    }
    
    private lazy var secondaryButton: SecondaryButton = {
        let secondaryButton = SecondaryButton()
        secondaryButton.accessibilityIdentifier = "content-secondary-button"

        if let view = viewModel as? ContentTileViewModelWithSecondaryButton {
            secondaryButton.titleLabel?.textColor = .gdsGreen
            if let icon = view.secondaryButtonViewModel.icon {
                secondaryButton.symbolPosition = icon.symbolPosition
                secondaryButton.icon = icon.iconName
            }
            secondaryButton.contentHorizontalAlignment = .left
            secondaryButton.setTitle(view.secondaryButtonViewModel.title.value, for: .normal)
            secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
            secondaryButton.isUserInteractionEnabled = true
            return secondaryButton
        } else {
            secondaryButton.isHidden = true
        }
        return secondaryButton
    }()
    
    @objc private func secondaryButtonTapped() {
        (viewModel as? ContentTileViewModelWithSecondaryButton)?.secondaryButtonViewModel.action()
    }
    
    private lazy var primaryButton: RoundedButton = {
        let primaryButton = RoundedButton()
        primaryButton.accessibilityIdentifier = "content-primary-button"

        if let view = viewModel as? ContentTileViewModelWithPrimaryButton {
            primaryButton.setTitle(view.primaryButtonViewModel.title.value, for: .normal)
            primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
            primaryButton.isUserInteractionEnabled = true
            return primaryButton
        } else {
            primaryButton.isHidden = true
        }
        return primaryButton
    }()
    
    @objc private func primaryButtonTapped() {
        (viewModel as? ContentTileViewModelWithPrimaryButton)?.primaryButtonViewModel.action()
    }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.accessibilityIdentifier = "content-close-button"
        
        if ((viewModel as? ContentTileViewModelWithDismissButton) != nil) {
            let font = UIFont(style: .body, weight: .regular)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .default)
            button.setImage(UIImage(systemName: "xmark", withConfiguration: configuration), for: .normal)
            button.tintColor = .gdsGreen
            button.translatesAutoresizingMaskIntoConstraints = false
            button.adjustsImageSizeForAccessibilityContentSizeCategory = true
            button.addTarget(self, action: #selector(close), for: .touchUpInside)
            return button
        } else {
            button.isHidden = true
        }
        return button
    }()
    
    @objc private func close() {
        (viewModel as? ContentTileViewModelWithDismissButton)?.closeButton.action()
    }
}
