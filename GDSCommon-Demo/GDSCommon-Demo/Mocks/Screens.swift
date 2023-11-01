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
    case gdsModalInfoView = "Modal Info View"
    case gdsAttributedModalInfoView = "Attributed Modal Info View"
    case gdsListOptions = "List Options"
    case gdsIntroView = "Intro View"
    case gdsDatePicker = "Date Picker"
    case gdsTextInput = "Text Input"
    case gdsIconScreen = "Icon Screen"
    case gdsQRCodeScanner = "QR Scanner"
    case gdsQRCodeScannerModal = "QR Scanner (Modal)"
    
    var isModal: Bool {
        switch self {
        case .gdsModalInfoView,
                .gdsQRCodeScannerModal,
                .gdsAttributedModalInfoView:
            return true
        default:
            return false
        }
    }
    
    private var mockButtonViewModel: ButtonViewModel {
        MockButtonViewModel(title: "Action Button", shouldLoadOnTap: false, action: {})
    }
    
    private var mockSecondaryButtonViewModel: ButtonViewModel {
        MockButtonViewModel(title: "Secondary Button",
                            icon: MockButtonIconViewModel(iconName: "qrcode",
                                                          symbolPosition: .beforeTitle),
                            shouldLoadOnTap: false,
                            action: {})
    }
    
    private var dialogPresenter: DialogPresenter {
        DialogView<CheckmarkDialogAccessoryView>(title: "QR Scan Success",
                                                 isLoading: false)
    }
    
    func create(in navigationController: UINavigationController) -> UIViewController {
        switch self {
        case .gdsInstructions:
            let viewModel = MockGDSInstructionsViewModel(buttonViewModel: mockButtonViewModel,
                                                         secondaryButtonViewModel: mockSecondaryButtonViewModel)
            return GDSInstructionsViewController(viewModel: viewModel)
        case .gdsInstructionsWithImage:
            let viewModel = MockInstructionsWithImageViewModel(warningButtonViewModel: mockButtonViewModel,
                                                               primaryButtonViewModel: mockButtonViewModel,
                                                               screenView: {})
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
            let viewModel = MockListViewModel()
            return ListOptionsViewController(viewModel: viewModel)
        case .gdsIntroView:
            let viewModel = MockIntroViewModel(introButtonViewModel: mockButtonViewModel)
            return IntroViewController(viewModel: viewModel)
        case .gdsDatePicker:
            return DatePickerScreenViewController()
        case .gdsTextInput:
            return TextInputViewController()
        case .gdsIconScreen:
            return IconScreenViewController()
        case .gdsQRCodeScanner:
            let viewModel = MockQRScanningViewModel(dialogPresenter: dialogPresenter) {
                navigationController.popViewController(animated: true)
            }
            let vc = ScanningViewController(viewModel: viewModel)
            return vc
        case .gdsQRCodeScannerModal:
            let viewModel = MockQRScanningViewModel(dialogPresenter: dialogPresenter) {
                navigationController.dismiss(animated: true)
            }
            let vc = ScanningViewController(viewModel: viewModel)
            return vc
        }
    }
}
