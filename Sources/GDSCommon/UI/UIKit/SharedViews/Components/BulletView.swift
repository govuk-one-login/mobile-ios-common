import UIKit

/// `BulletView` creates a bulleted list from an array of `String`
///  The title is an Optional `String`
///  The text is of type `[String]`
///  The titleFont is an Optional `UIFont`
public final class BulletView: NibView {
    private let title: String?
    private let text: [String]
    private let titleFont: UIFont
    
    /// Initialiser targets the nib file and requires an array of `String`. From this, the view
    /// constructs a vertical stack as a bulleted list (`bulletStack`)
    /// - Parameters:
    ///   - title: an optional bold formated title to `BulletView`
    ///   - titleFont: an optional font applied to `title`
    ///   - text: the array of `String` that is constructed into the list
    public init(title: String?,
                titleFont: UIFont?,
                text: [String]) {
        self.title = title
        self.text = text
        self.titleFont = titleFont ?? .init(style: .title3, weight: .semibold)
        super.init(bundle: .module)
        self.accessibilityIdentifier = "bullet-view"
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Convenience initaliser to initialise a `BulletView` directly from a ``BulletViewModel``
    /// - Parameter viewModel: ``BulletViewModel``
    public convenience init(viewModel: BulletViewModel) {
        self.init(title: viewModel.title, titleFont: viewModel.titleFont, text: viewModel.text)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = titleFont
            titleLabel.text = title
            titleLabel.isHidden = title == nil
            titleLabel.accessibilityIdentifier = "bullet-title"
        }
    }
    
    @IBOutlet private var bulletsStack: UIStackView! {
        didSet {
            text.forEach {
                let label = UILabel()
                label.adjustsFontForContentSizeCategory = true
                label.setBulletedList(strings: [$0])
                label.numberOfLines = 0
                bulletsStack.addArrangedSubview(label)
            }
            bulletsStack.accessibilityIdentifier = "bullet-stack"
        }
    }
}
