import Foundation
import UIKit

public final class GDSContentTileView: NibView {
    public let viewModel: GDSContentTileViewModel
    
    public init(viewModel: GDSContentTileViewModel) {
        self.viewModel = viewModel
        super.init(forcedNibName: "GDSContentTileView", bundle: .module)
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
            containerStackView.accessibilityIdentifier = "container-stack-view"
        }
    }
    
    @IBOutlet private var imageView: UIImageView! {
        didSet {
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
            imageView.accessibilityIdentifier = "content-tile-image"
        }
    }
    
    @IBOutlet private var captionLabel: UILabel! {
        didSet {
            if let viewModel = viewModel as? GDSContentTileViewModelWithCaption {
                captionLabel.text = viewModel.caption.value
                captionLabel.font = UIFont(style: .subheadline, weight: .regular)
            } else {
                captionLabel.isHidden = true
            }
            captionLabel.accessibilityIdentifier = "content-tile-caption"
        }
    }
    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.font = viewModel.titleFont
            titleLabel.accessibilityIdentifier = "content-tile-title"
            titleLabel.accessibilityLabel =  GDSLocalisedString(stringKey: "CardComponent",
                                                                viewModel.title.value,
                                                                bundle: .module).value
        }
    }
    
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            if let viewModel = viewModel as? GDSContentTileViewModelWithBody {
                bodyLabel.text = viewModel.body.value
                bodyLabel.font = .body
            } else {
                bodyLabel.isHidden = true
            }
            bodyLabel.accessibilityIdentifier = "content-tile-body"
        }
    }
    
    @IBOutlet private var separatorView: UIView! {
        didSet {
            if viewModel.showSeparatorLine {
                separatorView.backgroundColor = .separator
            } else {
                separatorView.isHidden = true
            }
            separatorView.accessibilityIdentifier = "content-tile-separator"
        }
    }
    
    @IBOutlet private var buttonStack: UIStackView! {
        didSet {
            if let viewModel = viewModel as? GDSContentTileViewModelWithSecondaryButton {
                let secondaryButton = SecondaryButton()
                secondaryButton.setTitle(
                    viewModel.secondaryButtonViewModel.title.value,
                    for: .normal
                )
                if let icon = viewModel.secondaryButtonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
                secondaryButton.setTitleColor(
                    .accent,
                    for: .normal
                )
                secondaryButton.addTarget(
                    self,
                    action: #selector(secondaryButtonTapped),
                    for: .touchUpInside
                )
                secondaryButton.contentHorizontalAlignment = .left
                secondaryButton.isUserInteractionEnabled = true
                secondaryButton.accessibilityIdentifier = "content-secondary-button"
                
                buttonStack.addArrangedSubview(secondaryButton)
            }
            
            if let viewModel = viewModel as? GDSContentTileViewModelWithPrimaryButton {
                let primaryButton = RoundedButton()
                primaryButton.setTitle(
                    viewModel.primaryButtonViewModel.title.value,
                    for: .normal
                )
                primaryButton.addTarget(
                    self,
                    action: #selector(primaryButtonTapped),
                    for: .touchUpInside
                )
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
        if viewModel is GDSContentTileViewModelWithDismissButton {
            let configuration = UIImage.SymbolConfiguration(
                font: .body,
                scale: .default
            )
            button.setImage(
                UIImage(
                    systemName: "xmark",
                    withConfiguration: configuration
                ),
                for: .normal
            )
            button.addTarget(
                self,
                action: #selector(close),
                for: .touchUpInside
            )
            button.tintColor = .accent
            button.translatesAutoresizingMaskIntoConstraints = false
            button.adjustsImageSizeForAccessibilityContentSizeCategory = true
            return button
        } else {
            button.isHidden = true
        }
        button.accessibilityIdentifier = "content-close-button"
        return button
    }()
    
    @objc private func close() {
        if let viewModel = viewModel as? GDSContentTileViewModelWithDismissButton {
            viewModel.closeButtonAction()
        }
    }
}
