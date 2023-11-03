import UIKit

/// View Controller for the `InstructionsWithImage` storyboard XIB
/// This screen includes the following views:
///   - `titleLabel` (type: `UILabel`)
///   - `bodyLabel` (type: `UILabel`)
///   - `imageView` (type: `UIImageView`)
///   - `warningButton`  (type: ``SecondaryButton`` inherits from UIButton)
///   - `primaryButton`  (type: ``RoundedButton`` inherits from SecondaryButton)
/// This screen provides instructions below a heading and a full width image below the
/// instructions. Within the storyboard, these are within two `UIStackView`s which is
/// in turn within a `UIScrollView`. The `primaryButton` is within a
/// `UIStackView` constrained to the bottom of the screen. This is the main
/// Call To Action (CTA) on this screen.
public final class InstructionsWithImageViewController: UIViewController {
    public override var nibName: String? { "InstructionsWithImage" }
    
    public let viewModel: InstructionsWithImageViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initialiser for the `InstructionsWithImage` view controller.
    /// Requires a single parameter.
    /// - Parameter viewModel: `InstructionsWithImageViewModel`
    public init(viewModel: InstructionsWithImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "InstructionsWithImage", bundle: .module)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)

        if viewModel.rightBarButtonTitle != nil {
            self.navigationItem.rightBarButtonItem = .init(title: viewModel.rightBarButtonTitle?.value,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(dismissScreen))
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.didAppear()
    }
    
    /// Title label: ``UILabel``
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.font = .largeTitleBold
            titleLabel.accessibilityTraits = .header
            titleLabel.accessibilityIdentifier = "titleLabel"
        }
    }
    
    /// Body label: ``UILabel``
    @IBOutlet private var bodyLabel: UILabel! {
        didSet {
            bodyLabel.attributedText = viewModel.body
            bodyLabel.textColor = .gdsGrey
            bodyLabel.accessibilityIdentifier = "bodyLabel"
        }
    }
    
    /// Image view: ``UIImageView``
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.image = viewModel.image
            imageView.accessibilityIdentifier = "imageView"
        }
    }
    
    /// Warning button: ``SecondaryButton``. This is an optional property on the `viewModel`.
    /// If it is `nil` on `viewModel` then the button is not displayed
    @IBOutlet private var warningButton: SecondaryButton! {
        didSet {
            if let warningButtonViewModel = viewModel.warningButtonViewModel {
                warningButton.isHidden = false
                warningButton.setTitle(warningButtonViewModel.title, for: .normal)
                warningButton.accessibilityIdentifier = "warningButton"
            } else {
                warningButton.isHidden = true
            }
        }
    }
    
    /// Primary button: : ``RoundedButton``.
    /// It is constrained to the bottom of the screen.
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            
            if let icon = viewModel.primaryButtonViewModel.icon {
                primaryButton.symbolPosition = icon.symbolPosition
                primaryButton.icon = icon.iconName
            }
            
            primaryButton.setTitle(viewModel.primaryButtonViewModel.title, for: .normal)
            primaryButton.accessibilityIdentifier = "primaryButton"
        }
    }
    
    /// secondaryButton button: ``SecondaryButton``. This is an optional property on the `viewModel`.
    /// If it is `nil` on `viewModel` then the button is not displayed
    @IBOutlet private var secondaryButton: SecondaryButton! {
        didSet {
            if let secondaryButtonViewModel = viewModel.secondaryButtonViewModel {
                secondaryButton.isHidden = false
                
                if let icon = viewModel.secondaryButtonViewModel?.icon {
                    secondaryButton.symbolPosition = icon.symbolPosition
                    secondaryButton.icon = icon.iconName
                }
                
                secondaryButton.setTitle(secondaryButtonViewModel.title,
                                         for: .normal)
            } else {
                secondaryButton.isHidden = true
            }
            secondaryButton.accessibilityIdentifier = "secondaryButton"
        }
    }
    
    @IBAction private func warningButtonAction(_ sender: Any) {
        if let buttonViewModel = viewModel.warningButtonViewModel {
            buttonViewModel.action()
        }
    }
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
        viewModel.primaryButtonViewModel.action()
    }
    
    @IBAction private func secondaryButtonAction(_ sender: Any) {
        if let buttonViewModel = viewModel.secondaryButtonViewModel {
            buttonViewModel.action()
        }
    }
    
    @objc private func dismissScreen() {
        self.dismiss(animated: true)
        
        viewModel.didDismiss()
    }
}
