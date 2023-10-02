import UIKit

public protocol TextInputView {
    associatedtype InputType
    var viewModel: any TextInputViewModel { get }
}

final class TextInputViewController<InputType>: UIViewController, UITextFieldDelegate, TextInputView {
    public override var nibName: String? { "TextInput" }
    
    public var viewModel: any TextInputViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: any TextInputViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "TextInput", bundle: .module)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerStackView.gdsBorders()
        textField.delegate = self
        primaryButton.isEnabled = false
        textField.isSelected = true
        
        barButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.rightBarButtonTitle != nil {
            self.navigationItem.rightBarButtonItem = .init(title: viewModel.rightBarButtonTitle?.value,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(dismissScreen))
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return viewModel.textFieldViewModel.validator(existingString: textField.text, range: range, replacementString: string)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
    
    @IBOutlet private var titleLabel: UILabel! {
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
            // failed to get text from text field
            return
        }

        viewModel.updateResult(string: text)
        viewModel.buttonViewModel.action()
    }
    
    func barButton() {
        let bar = UIToolbar()
        let done = UIBarButtonItem(title: NSLocalizedString(key: "doneButton"), style: .done, target: self, action: #selector(dismissKeyboard))
        bar.items = [done]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
    }
    
    @objc func dismissKeyboard() {
        textField.endEditing(true)
    }
    
    @objc private func dismissScreen() {
        self.dismiss(animated: true)
        
        viewModel.didDismiss()
    }
}
