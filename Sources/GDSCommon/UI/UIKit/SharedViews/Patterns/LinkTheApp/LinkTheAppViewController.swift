import UIKit

public final class LinkTheAppViewController: UIViewController {
    public override var nibName: String? { "LinkTheApp" }
    
    let viewModel: LinkTheAppViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: LinkTheAppViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LinkTheApp", bundle: .module)
    }
    
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            let font = UIFont(style: .largeTitle, weight: .light)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            let image = UIImage(systemName: viewModel.imageName, withConfiguration: configuration)
            imageView.image = image
            imageView.accessibilityIdentifier = "error-image"
        }
    }

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityIdentifier = "error-title"
        }
    }

    @IBOutlet private var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.text = viewModel.subtitle.value
            subtitleLabel.accessibilityIdentifier = "error-subtitle"
        }
    }
    
    @IBOutlet var firstSectionTitleLabel: UILabel! {
        didSet {
            firstSectionTitleLabel.text = "Link the app manually"
        }
    }
    
    @IBOutlet var firstSectionSubtitleLabel: UILabel! {
        didSet {
            firstSectionSubtitleLabel.text = "Choose this option if you tried to link the app but it was unsuccessful."
        }
    }
    
    @IBOutlet var firstSectionButton: UIButton! {
        didSet {
            firstSectionButton.setTitle("Link GOV.UK ID Check", for: .normal)
            firstSectionButton.titleLabel?.adjustsFontForContentSizeCategory = true
        }
    }
    
    @IBOutlet var secondSectionTitleLabel: UILabel! {
        didSet {
            secondSectionTitleLabel.text = "Allow the app to link to GOV.UK"
        }
    }
    
    @IBOutlet var secondSectionSubtitleLabel: UILabel! {
        didSet {
            secondSectionSubtitleLabel.text = "Choose this option if you did not allow the app and website to share information."
        }
    }
    
    @IBOutlet var secondSectionButton: UIButton! {
        didSet {
            secondSectionButton.setTitle("Change your permissions", for: .normal)
            secondSectionButton.titleLabel?.adjustsFontForContentSizeCategory = true
        }
    }
    
    @IBOutlet private var contentView: UIStackView! {
        didSet {
            viewModel.contentViews.forEach { contentView.addArrangedSubview($0) }
        }
    }
}
