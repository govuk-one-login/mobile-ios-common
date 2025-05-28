import UIKit

/// View Controller for the `GDSInstructions` storyboard XIB
/// It is initialised with a `viewModel` of type: `GDSInstructionsViewModel`
/// This screen includes the following views:
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   - `stackView` (type: `UIStackView`)
///   - `primaryButton`  (type: ``RoundedButton`` inherits from SecondaryButton)
///   - `secondaryButton`  (type: optional ``SecondaryButton`` inherits from UIButton)
///  This screen is typically used to provides bullet list instructions below a heading and body text.
///  Within the storyboard, these are within two `UIStackView`s which is
///  in turn within a `UIScrollView`.
///
///  The `titleLabel` and `bodyLabel` are within `stackView`. The view controller adds the `childView`
///  from the `viewModel`. The `childView` is of type `UIView` so this is flexible. Typically it is used with
///  ``BulletView`` to provide a bulleted list of instructions.
///
///  The `primaryButton` is within a
///  `UIStackView` constrained to the bottom of the screen. This is the main
///   Call To Action (CTA) on this screen.
public class GDSInstructionsViewController: BaseViewController, TitledViewController {
    public let viewModel: GDSInstructionsViewModel
    
    /// Initialiser for the `GDSInstructions` view controller.
    /// Requires a single parameter.
    /// - Parameter viewModel: `GDSInstructionsViewModel`
    public init(viewModel: GDSInstructionsViewModel
    ) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "GDSInstructions", bundle: .module)
    }
    
    @available(*, unavailable, renamed: "init(viewModel:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        primaryButton.isEnabled = true
        primaryButton.isLoading = false
    }
    
    /// Title label: `UILabel`
    @IBOutlet private(set) var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.font = .largeTitleBold
            titleLabel.accessibilityIdentifier = "instructions-title"
        }
    }
    
    /// Body label: `UILabel`
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.text = viewModel.body
            bodyLabel.accessibilityIdentifier = "instructions-body"
        }
    }
    
    /// Primary Button: ``RoundedButton``
    /// This is the primary CTA (Call To Action) for this screen.
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            primaryButton.setTitle(viewModel.buttonViewModel.title.value, for: .normal)
            primaryButton.accessibilityIdentifier = "instructions-button"
            if let buttonModel = viewModel.buttonViewModel as? ColoredButtonViewModel {
                primaryButton.backgroundColor = buttonModel.backgroundColor
            }
        }
    }
    
    /// Secondary button: ``SecondaryButton``. This is an optional property on the `viewModel`.
    /// If it is `nil` on `viewModel` then the button is not displayed
    @IBOutlet private var secondaryButton: SecondaryButton! {
        didSet {
            if let buttonViewModel = viewModel.secondaryButtonViewModel {
                secondaryButton.titleLabel?.textAlignment = .center
                secondaryButton.setTitle(buttonViewModel.title, for: .normal)
                secondaryButton.accessibilityIdentifier = "instructions-secondary-button"
                secondaryButton.isHidden = false
                
                if let icon = viewModel.secondaryButtonViewModel?.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
                
            } else {
                secondaryButton.isHidden = true
            }
        }
    }
    
    /// Stack View: `UIStackView`. Any `UIView` stored on the `viewModel` `childView` property
    /// will be added to the `stackView` below the `bodyLabel` which in tern is below `titleLabel` in this stack  .
    @IBOutlet private var stackView: UIStackView! {
        didSet {
            stackView.addArrangedSubview(viewModel.childView)
            stackView.accessibilityIdentifier = "instructions-stackView"
        }
    }
    
    @IBAction private func didTapPrimaryButton() {
        primaryButton.isLoading = viewModel.buttonViewModel.shouldLoadOnTap
        resetPrimaryButton()
        viewModel.buttonViewModel.action()
    }

    @IBAction private func didTapSecondaryButton() {
        if let buttonViewModel = viewModel.secondaryButtonViewModel {
            buttonViewModel.action()
        }
    }

    private func resetPrimaryButton() {
        if let viewModel = viewModel as? GDSInstructionsViewModelDisableButton {
            primaryButton.isEnabled = viewModel.shouldEnableOnTap
        }
    }
}
