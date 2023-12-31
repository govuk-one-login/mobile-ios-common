import GDSCommon
import UIKit

/// Screens
///
/// To add a new `Screens` attribute
/// - add a new case for the view
/// - declare if it should be modal in presentation
/// - create a static var for the UIViewController to be presented
///
/// - Returns: - The view name as a `String`
///             isModal as a `Bool` to determine if it should be presented modally, the default is false
///             the view as a `UIViewController` to push/present on the navigation stack.
enum Screens: String, CaseIterable {
    case gdsInstructions = "GDS Instructions View"
    case gdsInstructionsWithImage = "GDS Instructions View (with image)"
    case gdsInstructionsWithImageModally = "GDS Instructions View (with image) - modal"
    case gdsModalInfoView = "Modal Info View"
    case gdsAttributedModalInfoView = "Attributed Modal Info View"
    case gdsListOptions = "List Options"
    case gdsIntroView = "Intro View"
    case gdsDatePicker = "Date Picker"
    case gdsTextInput = "Text Input"
    case gdsIconScreen = "Icon Screen"
    case gdsQRCodeScanner = "QR Scanner"
    case gdsQRCodeScannerModal = "QR Scanner (Modal)"
    case gdsResultsView = "Results View"
    case gdsResultsViewModal = "Results View (Modal)"
    case gdsErrorView = "Error View"
    
    var isModal: Bool {
        switch self {
        case .gdsModalInfoView,
                .gdsQRCodeScannerModal,
                .gdsResultsViewModal,
                .gdsAttributedModalInfoView,
                .gdsInstructionsWithImageModally:
            return true
        default:
            return false
        }
    }
    
    private var dialogPresenter: DialogPresenter {
        DialogView<CheckmarkDialogAccessoryView>(title: "QR Scan Success",
                                                 isLoading: false)
    }
    
    func create(in navigationController: UINavigationController) -> UIViewController {
        switch self {
        case .gdsInstructions:
            return GDSInstructionsViewController(popToRoot: popToRoot, navController: navigationController)
        case .gdsInstructionsWithImage:
            let viewModel = MockInstructionsWithImageViewModel(warningButtonViewModel: MockButtonViewModel.primary,
                                                               primaryButtonViewModel: MockButtonViewModel.primary,
                                                               screenView: {}, dismissAction: {})
            return InstructionsWithImageViewController(viewModel: viewModel)
        case .gdsInstructionsWithImageModally:
            let viewModel = MockInstructionsWithImageViewModel(warningButtonViewModel: MockButtonViewModel.primary,
                                                               primaryButtonViewModel: MockButtonViewModel.primary,
                                                               secondaryButtonViewModel: MockButtonViewModel.secondaryQR,
                                                               rightBarButtonTitle: "Close",
                                                               screenView: {}, dismissAction: {})
            return InstructionsWithImageViewController(viewModel: viewModel)
        case .gdsModalInfoView:
            let viewModel = MockModalInfoViewModel()
            let view = ModalInfoViewController(viewModel: viewModel)
            view.isModalInPresentation = true
            return view
        case .gdsAttributedModalInfoView:
            let viewModel = MockAttributedModalInfoViewModel()
            let view = ModalInfoViewController(viewModel: viewModel)
            view.isModalInPresentation = true
            return view
        case .gdsListOptions:
            return ListOptionsViewController(popToRoot: popToRoot, navController: navigationController)
        case .gdsIntroView:
            let viewModel = MockIntroViewModel(introButtonViewModel: MockButtonViewModel.primary, rightBarButtonTitle: nil)
            return IntroViewController(viewModel: viewModel)
        case .gdsDatePicker:
            return DatePickerScreenViewController()
        case .gdsTextInput:
            return TextInputViewController()
        case .gdsIconScreen:
            return IconScreenViewController()
        case .gdsQRCodeScanner:
            let viewModel = MockQRScanningViewModel(dialogPresenter: dialogPresenter) { navigationController.popViewController(animated: true) } dismissAction: {}
            return ScanningViewController(viewModel: viewModel)
        case .gdsQRCodeScannerModal:
            let viewModel = MockQRScanningViewModel(dialogPresenter: dialogPresenter) {  navigationController.dismiss(animated: true) } dismissAction: {}
            return ScanningViewController(viewModel: viewModel)
        case .gdsResultsView, .gdsResultsViewModal:
            return ResultsViewController(popToRoot: self == .gdsResultsView ? popToRoot : nil, navController: navigationController)
        case .gdsErrorView:
            let viewModel = MockErrorViewModel()
            return GDSErrorViewController(viewModel: viewModel)
        }
    }
    
    func popToRoot(_ navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
