import Foundation
import UIKit

public final class GDSContentTileView2: NibView {
    public let viewModel: GDSContentTileViewModel
    
    public init(viewModel: GDSContentTileViewModel) {
        self.viewModel = viewModel
        super.init(forcedNibName: "GDSContentTileView", bundle: .module)
        self.accessibilityIdentifier = "containerView"
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var containerView: UIView! {
        didSet {
            containerView.backgroundColor = viewModel.backgroundColour
            containerView.addSubview(closeButton)
            
            NSLayoutConstraint.activate([
                closeButton.trailingAnchor.constraint(
                    greaterThanOrEqualTo: containerView.trailingAnchor,
                    constant: -16
                ),
                closeButton.topAnchor.constraint(
                    greaterThanOrEqualTo: containerView.topAnchor,
                    constant: 8
                )
            ])
            containerView.accessibilityIdentifier = "containerStackView"
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
    
    @IBOutlet private var separatorView: UIView! {
        didSet {
            if viewModel.showSeparatorLine {
                separatorView.backgroundColor = .gdsGrey
            } else {
                separatorView.isHidden = true
            }
            separatorView.accessibilityIdentifier = "content-tile-separator"
        }
    }
    
    @IBOutlet private var secondaryButton: SecondaryButton! {
        didSet {
            if let viewModel = viewModel as? GDSContentTileViewModelWithSecondaryButton {
                secondaryButton.setTitle(viewModel.secondaryButtonViewModel.title.value, for: .normal)
                secondaryButton.setTitleColor(.gdsGreen, for: .normal)
                if let icon = viewModel.secondaryButtonViewModel.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
            } else {
                secondaryButton.isHidden = true
            }
            secondaryButton.accessibilityIdentifier = "content-secondary-button"
        }
    }
    
    @IBAction private func secondaryButtonAction(_ sender: Any) {
        if let viewModel = viewModel as? GDSContentTileViewModelWithSecondaryButton {
            viewModel.secondaryButtonViewModel.action()
        }
    }
    
        
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            if let viewModel = viewModel as? GDSContentTileViewModelWithPrimaryButton {
                primaryButton.setTitle(viewModel.primaryButtonViewModel.title.value, for: .normal)
            } else {
                primaryButton.isHidden = true
            }
            primaryButton.accessibilityIdentifier = "content-primary-button"
        }
    }
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
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
