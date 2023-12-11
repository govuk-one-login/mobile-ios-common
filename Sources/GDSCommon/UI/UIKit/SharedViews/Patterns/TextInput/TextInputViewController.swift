import UIKit

/// `TextInputView` protocol to make the `TextInputViewController` generic with associatedType
public protocol TextInputView {
    associatedtype InputType
    var viewModel: any TextInputViewModel { get }
}

/// `TextInputViewController` provides a generic text input screen. A title with a text field below.
/// The view controller is configured with a  `TextInputViewModel` which includes a `textFieldViewModel`
/// property to configure the `textField`. The configuration includes a customisable `validator` method that
/// allows concrete implementations of `TextFieldViewModel` protocol to implement validation methods to
/// validate and constrain the input of the text field.
/// The validator method is called on every change of the text field.
public final class TextInputViewController<InputType>: BaseViewController, TitledViewController,
                                                       UITextFieldDelegate,
                                                       TextInputView {
    public override var nibName: String? { "TextInput" }
    
    public var viewModel: any TextInputViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: any TextInputViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "TextInput", bundle: .module)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        innerStackView.gdsBorders()
        textField.delegate = self
        primaryButton.isEnabled = false
        textField.isSelected = true
        
        if let keyboardDoneButton = viewModel.textFieldViewModel.keyboardDoneButton {
            barButton(keyboardDoneButton)
        }
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return viewModel.textFieldViewModel.validator(existingString: textField.text, range: range, replacementString: string)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if !text.isEmpty && Double(text) != nil {
                primaryButton.isEnabled = true
            } else {
                textField.text = ""
                primaryButton.isEnabled = false
            }
        } else {
            textField.text = ""
            primaryButton.isEnabled = false
        }
    }
    
    @IBOutlet private var scrollView: UIScrollView!
    
    @IBOutlet private(set) var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.font = .largeTitleBold
            titleLabel.accessibilityTraits = .header
            titleLabel.accessibilityIdentifier = "titleLabel"
        }
    }
    
    @IBOutlet private var innerStackView: UIStackView!
    
    @IBOutlet private var textField: UITextField! {
        didSet {
            textField.keyboardType = viewModel.textFieldViewModel.keyboardType
            textField.font = .body
            textField.placeholder = viewModel.textFieldViewModel.placeholder
            textField.accessibilityIdentifier = "textField"
        }
    }
    
    @IBOutlet private var textFieldFooter: UILabel! {
        didSet {
            textFieldFooter.text = viewModel.textFieldFooter
            textFieldFooter.font = .footnote
            textFieldFooter.textColor = .secondaryLabel
            textFieldFooter.numberOfLines = 0
            textFieldFooter.accessibilityIdentifier = "textFieldFooter"
            textFieldFooter.isHidden = viewModel.textFieldFooter == nil
        }
    }
    
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            primaryButton.setTitle(viewModel.buttonViewModel.title, for: .normal)
            primaryButton.accessibilityIdentifier = "primaryButton"
        }
    }
    
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
        guard let text = textField.text else {
            // Text property should not be nil becuase the button should be disabled if it is
            return
        }

        viewModel.updateResult(string: text)
        viewModel.buttonViewModel.action()
    }
    
    func barButton(_ keyboardDoneButton: String) {
        let bar = UIToolbar()
        let done = UIBarButtonItem(title: NSLocalizedString(key: keyboardDoneButton), style: .done, target: self, action: #selector(dismissKeyboard))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [space, done]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
    }
    
    @objc func dismissKeyboard() {
        textField.endEditing(true)
    }
}
