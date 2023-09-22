import GDSCommon
import UIKit

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
