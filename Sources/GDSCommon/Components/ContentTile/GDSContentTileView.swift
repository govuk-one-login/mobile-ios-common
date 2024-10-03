import Foundation
import UIKit

public final class GDSContentTileView: NibView {
    public let viewModel: GDSContentTileViewModel
    
    public init(viewModel: GDSContentTileViewModel) {
        self.viewModel = viewModel
        super.init(forcedNibName: "GDSContentTileView", bundle: .module)
        self.accessibilityIdentifier = "containerView"
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var containerStackView: UIStackView! {
        didSet {
            containerStackView.backgroundColor = viewModel.backgroundColour
            containerStackView.addSubview(closeButton)
            
            NSLayoutConstraint.activate([
                closeButton.trailingAnchor.constraint(
                    greaterThanOrEqualTo: containerStackView.trailingAnchor,
                    constant: -16
                ),
                closeButton.topAnchor.constraint(
                    greaterThanOrEqualTo: containerStackView.topAnchor,
                    constant: 8
                )
            ])
            containerStackView.accessibilityIdentifier = "containerStackView"
        }
    }
    
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.accessibilityIdentifier = "content-tile-image"
            if let viewModel = viewModel as? GDSContentTileViewModelWithImage,
               viewModel.image.size.height > 0 {
                imageView.image = viewModel.image
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(
                        equalTo: imageView.heightAnchor,
                        multiplier: viewModel.image.size.width / viewModel.image.size.height
                    )
                ])
            } else {
                imageView.isHidden = true
            }
        }
    }
    
    @IBOutlet private var textStack: UIStackView! {
        didSet {
            textStack.accessibilityIdentifier = "content-text-stack"
            textStack.backgroundColor = viewModel.backgroundColour
        }
    }
    
    @IBOutlet private var captionLabel: UILabel! {
        didSet {
            if let viewModel = viewModel as? GDSContentTileViewModelWithCaption {
                captionLabel.text = viewModel.caption.value
                captionLabel.font = UIFont(style: .subheadline, weight: .regular)
                captionLabel.numberOfLines = 0
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
            titleLabel.numberOfLines = 0
            titleLabel.accessibilityIdentifier = "content-tile-title"
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            if let viewModel = viewModel as? GDSContentTileViewModelWithBody {
                bodyLabel.text = viewModel.body.value
                bodyLabel.font = .body
                bodyLabel.numberOfLines = 0
            } else {
                bodyLabel.isHidden = true
            }
            bodyLabel.accessibilityIdentifier = "content-tile-body"
        }
    }
    
    @IBOutlet private var buttonStack: UIStackView! {
        didSet {
            if viewModel.showSeparatorLine {
                let separatorView = SeparatorView()
                separatorView.accessibilityIdentifier = "content-tile-separator"
                buttonStack.addArrangedSubview(separatorView)
                NSLayoutConstraint.activate([
                    separatorView.heightAnchor.constraint(equalToConstant: 1)
                ])
            }
            
            if let viewModel = viewModel as? GDSContentTileViewModelWithSecondaryButton {
                let secondaryButton = SecondaryButton()
                if let icon = viewModel.secondaryButtonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
                secondaryButton.setTitle(viewModel.secondaryButtonViewModel.title.value, for: .normal)
                secondaryButton.setTitleColor(.gdsGreen, for: .normal)
                secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
                secondaryButton.contentHorizontalAlignment = .left
                secondaryButton.isUserInteractionEnabled = true
                secondaryButton.accessibilityIdentifier = "content-secondary-button"
                buttonStack.addArrangedSubview(secondaryButton)
            }
            
            if let viewModel = viewModel as? GDSContentTileViewModelWithPrimaryButton {
                let primaryButton = RoundedButton()
                primaryButton.setTitle(viewModel.primaryButtonViewModel.title.value, for: .normal)
                primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
                primaryButton.isUserInteractionEnabled = true
                primaryButton.accessibilityIdentifier = "content-primary-button"
                buttonStack.addArrangedSubview(primaryButton)
            }
        }
    }
    
    @objc private func secondaryButtonTapped() {
        if let viewModel = viewModel as? GDSContentTileViewModelWithSecondaryButton {
            viewModel.secondaryButtonViewModel.action()
        }
    }
    
    @objc private func primaryButtonTapped() {
        if let viewModel = viewModel as? GDSContentTileViewModelWithPrimaryButton {
            viewModel.primaryButtonViewModel.action()
        }
    }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.accessibilityIdentifier = "content-close-button"
        
        if viewModel is GDSContentTileViewModelWithDismissButton {
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
        if let viewModel = viewModel as? GDSContentTileViewModelWithDismissButton {
            viewModel.closeButton.action()
        }
    }
}
