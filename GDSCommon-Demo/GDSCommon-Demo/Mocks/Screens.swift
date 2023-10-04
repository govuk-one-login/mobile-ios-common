import GDSCommon
import UIKit

/// Screens
///
/// To add a new `Screens` attribute
/// - add a new case for the view
/// - declare if it should be modal in presentation
/// - create a static var for the UIViewController to be presented 
///
/// - Returns: The view name as a `String`, isModal as a `Bool` to determin if it should be presented modally, and the view as a `UIViewController` to push/present on the navigation stack.
enum Screens: CaseIterable {
    case gdsInstructions
    case gdsInstructionsWithImage
    case gdsModalInfoView
    
    var name: String {
        switch self {
        case .gdsInstructions:
            return "GDS Instructions View"
        case .gdsInstructionsWithImage:
            return "GDS Instructions View (with image)"
        case .gdsModalInfoView:
            return "Modal Info View"
        }
    }
    
    var isModal: Bool {
        switch self {
        case .gdsInstructions, .gdsInstructionsWithImage:
            return false
        case .gdsModalInfoView:
            return true
        }
    }
    
    var view: UIViewController {
        switch self {
        case .gdsInstructions:
            let viewModel = MockGDSInstructionsViewModel(buttonViewModel: MockButtonViewModel(title: "Action Button",
                                                                                              shouldLoadOnTap: false,
                                                                                              action: {}))
            return GDSInstructionsViewController(viewModel: viewModel)
        case .gdsInstructionsWithImage:
            let viewModel = MockInstructionWithImageViewModel(warningButtonViewModel: MockButtonViewModel(title: "Warning Button",
                                                                                                          shouldLoadOnTap: false,
                                                                                                          action: {}),
                                                              primaryButtonViewModel: MockButtonViewModel(title: "Action Button",
                                                                                                          shouldLoadOnTap: false,
                                                                                                          action: {}))
            return InstructionsWithImageViewController(viewModel: viewModel)
        case .gdsModalInfoView:
            let viewModel = MockModalInfoViewModel()
            let view = ModalInfoViewController(viewModel: viewModel)
            view.isModalInPresentation = true
            return view
        }
    }
}
