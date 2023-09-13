import UIKit

/// `BulletView` creates a bulleted list from an array of `String`
///  The title is an Optional `String`
public final class BulletView: NibView {
    private let title: String?
    private let text: [String]
    
    /// Initialiser targets the nib file and requires an array of `String`. From this, the view
    /// constructs a vertical stack as a bulleted list (`bulletStack`)
    /// - Parameters:
    ///   - title: an optional bold formated title to `BulletView`
    ///   - text: the array of `String` that is constructed into the list
    public init(title: String?, text: [String]) {
        self.title = title
        self.text = text
        super.init(bundle: .module)
        self.accessibilityIdentifier = "bullet-view"
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Convenience initaliser to initialise a `BulletView` directly from a ``BulletViewModel``
    /// - Parameter viewModel: ``BulletViewModel``
    public convenience init(viewModel: BulletViewModel) {
        self.init(title: viewModel.title, text: viewModel.text)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .init(style: .title3, weight: .semibold)
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
