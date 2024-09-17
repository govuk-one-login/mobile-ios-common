import Foundation
import UIKit

public final class ContentTileView: UIView {
    private var leftConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var rightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var topConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.widthAnchor.constraint(equalToConstant: CGFloat(343)).isActive = true
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageContainerView: UIView = {
        let imageContainerView = UIView()
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.layer.masksToBounds = true
        return imageContainerView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = viewModel.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .secondarySystemBackground
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var captionLabel: UILabel = {
        let captionLabel = UILabel()
        captionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.font = UIFont(style: .subheadline, weight: .regular)
        captionLabel.text = viewModel.caption?.value
        captionLabel.numberOfLines = 0
        captionLabel.adjustsFontForContentSizeCategory = true
        return captionLabel
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .bodyBold
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = viewModel.title.value
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    lazy var bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.font = .body
        bodyLabel.text = viewModel.body?.value
        bodyLabel.numberOfLines = 0
        bodyLabel.adjustsFontForContentSizeCategory = true
        return bodyLabel
    }()
    
    lazy var linkButton: SecondaryButton = {
        let subtitleLabel = SecondaryButton()
        subtitleLabel.titleLabel?.textColor = .gdsGreen
        subtitleLabel.icon = "arrow.right"
        subtitleLabel.contentHorizontalAlignment = .left
        subtitleLabel.setTitle(viewModel.actionText?.title.value, for: .normal)
        subtitleLabel.isEnabled = false
        return subtitleLabel
    }()
    
    lazy var primaryButton: RoundedButton = {
        let primaryButton = RoundedButton()
        primaryButton.setTitle(viewModel.actionButton?.title.value, for: .normal)
        return primaryButton
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.contentHorizontalAlignment = .right
        button.tintColor = .gdsGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    @objc private func close() {
        viewModel.dismissButton?.action()
    }
    
    var viewModel: ContentTileViewModel
    
    public init(frame: CGRect, viewModel: ContentTileViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        addInitialViews()
        layoutStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addInitialViews() {
        leftConstraint = containerView.leftAnchor.constraint(equalTo: self.leftAnchor)
        rightConstraint = containerView.rightAnchor.constraint(equalTo: self.rightAnchor)
        topConstraint = containerView.topAnchor.constraint(equalTo: self.topAnchor)
        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        backgroundColor = .clear
        addSubview(shadowView)
        addSubview(containerView)
                
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: containerView.topAnchor),
            shadowView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            shadowView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            shadowView.leftAnchor.constraint(equalTo: containerView.leftAnchor)
        ])
        
        addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])

        leftConstraint.constant = 16
        rightConstraint.constant = -16
        topConstraint.constant = 16
        bottomConstraint.constant = -16
        
        addShadow()
    }
    
    private func layoutStackView() {
        containerView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            containerStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            containerStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor)
        ])
        
        labelStackView.spacing = 8
        labelStackView.layoutMargins = UIEdgeInsets(top: 8,
                                                    left: 16,
                                                    bottom: 16,
                                                    right: 0)
        labelStackView.isLayoutMarginsRelativeArrangement = true

        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.spacing = 8
        textStackView.layoutMargins = UIEdgeInsets(top: 0,
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 16)
        textStackView.isLayoutMarginsRelativeArrangement = true
        
        let topStackView = UIStackView()
        topStackView.axis = .horizontal
        
        topStackView.addArrangedSubview(captionLabel)
        topStackView.addArrangedSubview(closeButton)
        
        textStackView.addArrangedSubview(topStackView)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(bodyLabel)
        
        labelStackView.addArrangedSubview(textStackView)
        
        let separatorView = SeparatorView()
        let lineStackView = UIStackView()
        lineStackView.addArrangedSubview(separatorView)
        
        labelStackView.addArrangedSubview(lineStackView)
        addImage()
        addButtons()
        containerStackView.addArrangedSubview(labelStackView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
    }
    
    private func addShadow() {
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
    }
    
    
    private func addImage() {
        guard viewModel.image != nil else {
            return
        }
            imageContainerView.addSubview(imageView)
            imageContainerView.addSubview(closeButton)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: imageContainerView.safeAreaLayoutGuide.topAnchor),
                imageView.rightAnchor.constraint(equalTo: imageContainerView.rightAnchor),
                imageView.leftAnchor.constraint(equalTo: imageContainerView.leftAnchor),
                imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
                imageView.heightAnchor.constraint(equalTo: imageContainerView.heightAnchor)
            ])
            
            containerStackView.addArrangedSubview(imageContainerView)
            
            NSLayoutConstraint.activate([
                closeButton.topAnchor.constraint(equalTo: imageContainerView.safeAreaLayoutGuide.topAnchor, constant: 8),
                closeButton.rightAnchor.constraint(equalTo: imageContainerView.rightAnchor, constant: -16),
            ])
    }
    
    private func addButtons() {
        let buttonView = UIStackView()
        buttonView.axis = .vertical
        buttonView.spacing = 16
        buttonView.layoutMargins = UIEdgeInsets(top: 0,
                                                left: 0,
                                                bottom: 0,
                                                right: 16)
        buttonView.isLayoutMarginsRelativeArrangement = true
        
        if viewModel.actionText != nil {
            buttonView.addArrangedSubview(linkButton)
        }
        if viewModel.actionButton != nil {
            buttonView.addArrangedSubview(primaryButton)
        }
        labelStackView.addArrangedSubview(buttonView)
    }
}
