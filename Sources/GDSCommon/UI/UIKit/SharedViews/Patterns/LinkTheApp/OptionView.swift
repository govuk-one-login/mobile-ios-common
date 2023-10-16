import UIKit

final public class OptionView: NibView {
    let viewModel: OptionViewModel
    
    public init(viewModel: OptionViewModel) {
        self.viewModel = viewModel
        super.init(forcedNibName: "OptionView", bundle: .module)
        self.accessibilityIdentifier = "optionView"
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.accessibilityTraits = .header
            titleLabel.accessibilityIdentifier = "option-title"
        }
    }
    
    @IBOutlet private var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.text = viewModel.subtitle.value
            subtitleLabel.textColor = .gdsGrey
            subtitleLabel.accessibilityIdentifier = "option-subtitle"
        }
    }
    
    
    @IBOutlet private var dividerOutlet: UIView! {
        didSet {
            dividerOutlet.backgroundColor = .gdsGrey
        }
    }
    
    @IBOutlet private var buttonOutlet: SecondaryButton! {
        didSet {
            buttonOutlet.setTitle(viewModel.buttonViewModel.title, for: .normal)
            buttonOutlet.accessibilityIdentifier = "option-button"
        }
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        viewModel.buttonViewModel.action()
    }
}
