import UIKit

/// View Controller for the `OptionView` storyboard XIB
/// This view includes the following views:
///   - `titleLabel` (type: `UILabel`)
///   - `subtitleLabel` (type: `UILabel`)
///   - `dividerOutlet` (type: `UIView`)
///   - `buttonOutlet` (type: ``SecondaryButton``)
/// This view provides a title, subtitle, divider and button.
/// The title is a header `UILabel`, the subtitle is a plain text `UILabel`,
/// the divider is a `UIView` with a height of 1pt and grey,
/// the button is a ``SecondaryButton`` which inherits from `UIButton`
/// Typically this view would be used as a subview in the `IconScreenView` screen.
final public class OptionView: NibView {
    public let viewModel: OptionViewModel
    
    /// Initialiser for the `OptionView` view.
    /// Requires a single parameter.
    /// - Parameter viewModel: `OptionViewModel`
    public init(viewModel: OptionViewModel) {
        self.viewModel = viewModel
        super.init(forcedNibName: "OptionView", bundle: .module)
        self.accessibilityIdentifier = "optionView"
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Title label: ``UILabel``
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityTraits = .header
            titleLabel.accessibilityIdentifier = "option-title"
        }
    }
    
    /// Subtitle label: ``UILabel``
    @IBOutlet private var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.text = viewModel.subtitle.value
            subtitleLabel.textColor = .gdsGrey
            subtitleLabel.accessibilityIdentifier = "option-subtitle"
        }
    }
    
    /// Divider: ``UIView``
    @IBOutlet private var dividerOutlet: UIView! {
        didSet {
            dividerOutlet.backgroundColor = .gdsGrey
        }
    }
    
    /// Button: ``SecondaryButton``
    @IBOutlet private var buttonOutlet: SecondaryButton! {
        didSet {
            buttonOutlet.setTitle(viewModel.buttonViewModel.title.value, for: .normal)
            buttonOutlet.accessibilityIdentifier = "option-button"
        }
    }
    
    @IBAction private func buttonAction(_ sender: Any) {
        viewModel.buttonViewModel.action()
    }
}
