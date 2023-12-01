import UIKit

/// Available for iOS 13.4 and later.
/// DatePicker screen displays a standard iOS date picker in a scrollview with a bold LargeTitle above
/// and a single CTA button at the button of the screen.
@available(iOS 13.4, *)
public final class DatePickerScreenViewController: BaseViewController {
    public override var nibName: String? { "DatePicker" }
    
    public var viewModel: DatePickerScreenViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: DatePickerScreenViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "DatePicker", bundle: .module)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.datePickerViewModel.selectedDate == nil {
            primaryButton.isEnabled = false
        }
    }
    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = viewModel.title.value
            titleLabel.font = .largeTitleBold
            titleLabel.accessibilityTraits = .header
            titleLabel.accessibilityIdentifier = "titleLabel"
        }
    }
    
    @IBOutlet private var datePicker: UIDatePicker! {
        didSet {
            datePicker.preferredDatePickerStyle = viewModel.datePickerViewModel.pickerStyle
            
            if let selectedDate = viewModel.datePickerViewModel.selectedDate {
                datePicker.date = selectedDate
                datePicker.isSelected = true
            }
            
            datePicker.minimumDate = viewModel.datePickerViewModel.minDate
            datePicker.maximumDate = viewModel.datePickerViewModel.maxDate
            
            datePicker.accessibilityTraits = .adjustable
            datePicker.accessibilityIdentifier = "datePicker"
        }
    }
    
    @IBOutlet private var footerLabel: UILabel! {
        didSet {
            footerLabel.text = viewModel.datePickerFooter
            footerLabel.font = .footnote
            footerLabel.textColor = .secondaryLabel
            footerLabel.numberOfLines = 0
            footerLabel.accessibilityIdentifier = "datePickerFooter"
            footerLabel.isHidden = viewModel.datePickerFooter == nil
        }
    }
    
    @IBOutlet private var primaryButton: RoundedButton! {
        didSet {
            primaryButton.setTitle(viewModel.buttonViewModel.title, for: .normal)
            primaryButton.accessibilityIdentifier = "primaryButton"
        }
    }
    
    @IBAction private func selectedDate(_ sender: Any) {
        viewModel.datePickerViewModel.setSelectedDate(datePicker.date)
        primaryButton.isEnabled = true
    }
    
    @IBAction private func primaryButtonAction(_ sender: Any) {
        guard let selectedDate = viewModel.datePickerViewModel.selectedDate else { return }
        viewModel.result(selectedDate)
        viewModel.buttonViewModel.action()
    }
}
