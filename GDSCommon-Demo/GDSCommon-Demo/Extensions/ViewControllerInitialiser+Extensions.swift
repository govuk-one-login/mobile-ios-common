import GDSCommon
import UIKit

extension DatePickerScreenViewController {
    convenience init() {
        let datePickerVM = MockDatePickerViewModel(selectedDate: Date(),
                                                   minDate: nil,
                                                   maxDate: nil)
        
        let viewModel = MockDatePickerScreenViewModel(title: "Date picker screen",
                                                      datePickerViewModel: datePickerVM,
                                                      buttonViewModel: MockButtonViewModel.primary)
        
        self.init(viewModel: viewModel)
    }
}

extension TextInputViewController<Double> {
    convenience init() {
        let textFieldVM = MockTextFieldViewModel<Double>()
        
        let viewModel = MockTextInputViewModel<Double>(result: {_ in }, appearAction: {}, dismissAction: {})

        self.init(viewModel: viewModel)
    }
}

extension GDSInstructionsViewController {
    convenience init(popToRoot: @escaping (UINavigationController) -> Void, navController: UINavigationController) {
        let viewModel = MockGDSInstructionsViewModel(buttonViewModel: MockButtonViewModel.primary,
                                                     secondaryButtonViewModel: MockButtonViewModel.secondaryQR) {
            popToRoot(navController)
        }
        self.init(viewModel: viewModel)
    }
}

extension IconScreenViewController {
    convenience init() {
        let viewModel = MockIconScreenViewModel()
        
        self.init(viewModel: viewModel)
    }
}

extension ResultsViewController {
    convenience init(popToRoot: ((UINavigationController) -> Void)?, navController: UINavigationController) {
        let viewModel = MockResultsViewModel(resultsButtonViewModel: MockButtonViewModel.primary, rightBarButtonTitle: "right bar button") {
            if let popToRoot {
                popToRoot(navController)
            } else {
                navController.dismiss(animated: true)
            }
        }
        self.init(viewModel: viewModel)
    }
}

extension ListOptionsViewController {
    convenience init(popToRoot: @escaping (UINavigationController) -> Void, navController: UINavigationController) {
        let viewModel = MockListViewModel(dismissAction: {
            popToRoot(navController)
        })
        self.init(viewModel: viewModel)
    }
}

extension GDSInformationController {
    convenience init() {
        let viewModel = MockGDSInformationViewModel()
        
        self.init(viewModel: viewModel)
    }
}
