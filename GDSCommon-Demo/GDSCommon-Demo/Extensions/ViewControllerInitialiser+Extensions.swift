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
