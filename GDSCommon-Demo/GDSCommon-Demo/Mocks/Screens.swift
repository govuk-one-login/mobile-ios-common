//
//  Screens.swift
//  GDSCommon-Demo
//
//  Created by McKillop, Ben on 22/09/2023.
//

import UIKit
import GDSCommon

enum Screens: CaseIterable {
    case GDSInstructions
    case GDSInstructionsWithImage
    case ModalInfoView
    
    var name: String {
        switch self {
        case .GDSInstructions:
            return "GDS Instructions View"
        case .GDSInstructionsWithImage:
            return "GDS Instructions View (with image)"
        case .ModalInfoView:
            return "Modal Info View"
        }
    }
    
    var isModal: Bool {
        switch self {
        case .GDSInstructions, .GDSInstructionsWithImage:
            return false
        case .ModalInfoView:
            return true
        }
    }
    
    var view: UIViewController {
        switch self {
        case .GDSInstructions:
            let viewModel = MockGDSInstructionsViewModel(buttonViewModel: MockButtonViewModel(title: "Action Button",
                                                                                              shouldLoadOnTap: false,
                                                                                              action: {}))
            return GDSInstructionsViewController(viewModel: viewModel)
        case .GDSInstructionsWithImage:
            let viewModel = MockInstructionWithImageViewModel(warningButtonViewModel: MockButtonViewModel(title: "Warning Button",
                                                                                                          shouldLoadOnTap: false,
                                                                                                          action: {}),
                                                              primaryButtonViewModel: MockButtonViewModel(title: "Action Button",
                                                                                                          shouldLoadOnTap: false,
                                                                                                          action: {}))
            return InstructionsWithImageViewController(viewModel: viewModel)
        case .ModalInfoView:
            let viewModel = MockModalInfoViewModel()
            let view = ModalInfoViewController(viewModel: viewModel)
            view.isModalInPresentation = true
            return view
        }
    }
}
