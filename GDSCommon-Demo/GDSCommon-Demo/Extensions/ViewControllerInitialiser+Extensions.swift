import GDSCommon
import UIKit

extension DatePickerScreenViewController {
    convenience init() {
        let datePickerVM = MockDatePickerViewModel(selectedDate: Date(),
                                                   minDate: nil,
                                                   maxDate: nil)
        
        let viewModel = MockDatePickerScreenViewModel(title: "Date picker screen",
                                                      datePickerViewModel: datePickerVM,
                                                      buttonViewModel: MockButtonViewModel(title: "Action Button",
                                                                                           shouldLoadOnTap: false,
                                                                                           action: {}))
        
        self.init(viewModel: viewModel)
    }
}

extension TextInputViewController<Double> {
    convenience init() {
        let textFieldVM = MockTextFieldViewModel<Double>()
        
        let viewModel = MockTextInputViewModel<Double>(textFieldViewModel: textFieldVM) { _ in
            // no result action
        } appearAction: {
            // no appear action
        } dismissAction: {
            // no dismiss action
        }

        self.init(viewModel: viewModel)
    }
}
