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
    case gdsListOptions = "List Options"
    case gdsIntroView = "Intro View"
    case gdsDatePicker = "Date Picker Screen"
    
    var isModal: Bool {
        switch self {
        case .gdsModalInfoView:
            return true
        default:
            return false
        }
    }
    
    private var mockButtonViewModel: ButtonViewModel {
        MockButtonViewModel(title: "Action Button", shouldLoadOnTap: false, action: {})
    }
    
    var view: UIViewController {
        switch self {
        case .gdsInstructions:
            let viewModel = MockGDSInstructionsViewModel(buttonViewModel: mockButtonViewModel)
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
        case .gdsListOptions:
            let viewModel = MockListViewModel()
            return ListOptionsViewController(viewModel: viewModel)
        case .gdsIntroView:
            let viewModel = MockIntroViewModel(introButtonViewModel: mockButtonViewModel)
            return IntroViewController(viewModel: viewModel)
        case .gdsDatePicker:
            return DatePickerScreenViewController()
        }
    }
}
