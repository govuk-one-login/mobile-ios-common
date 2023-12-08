import UIKit

/// View Controller for the `IconScreenView` storyboard XIB
/// This screen includes the following views:
///   - `imageView` (type: `UIImageView`)
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   - `contentView` (type: `UIStackView`)
/// This screen allows for additional subviews to be added below a top stack view
/// containing an icon, title and subtitle.
/// Typically the subviews would be further `UIStackView`s, a good implementation of which sits within this same directory, `OptionView`
public final class IconScreenViewController: BaseViewController, TitledScreen {
    public override var nibName: String? { "IconScreenView" }
    
    public let viewModel: IconScreenViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initialiser for the `IconScreenView` view controller.
    /// Requires a single parameter.
    /// - Parameter viewModel: `IconScreenViewModel`
    public init(viewModel: IconScreenViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "IconScreenView", bundle: .module)
    }
    
    /// Image view: ``UIImageView``
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            let font = UIFont(style: .largeTitle, weight: .light)
            let configuration = UIImage.SymbolConfiguration(font: font, scale: .large)
            let image = UIImage(systemName: viewModel.imageName, withConfiguration: configuration)
            imageView.image = image
            imageView.accessibilityIdentifier = "icon-screen-image"
        }
    }

    /// Title label: ``UILabel``
    @IBOutlet internal var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .largeTitle, weight: .bold)
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityTraits = .header
            titleLabel.accessibilityIdentifier = "icon-screen-title"
        }
    }

    /// Body label: ``UILabel``
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body.value
            bodyLabel.accessibilityIdentifier = "icon-screen-body"
        }
    }
    
    /// Content view: ``UIStackView``
    @IBOutlet private var contentView: UIStackView! {
        didSet {
            viewModel.childViews.forEach { contentView.addArrangedSubview($0) }
        }
    }
}
