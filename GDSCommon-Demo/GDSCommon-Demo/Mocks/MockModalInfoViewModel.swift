import Foundation
import GDSCommon
import UIKit

struct MockModalInfoViewModel: ModalInfoViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the modal view"
    let body: GDSLocalisedString = "We can use this if we want the user to complete an action"
    var bodyTextColour: UIColor? =
    var primaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.primary
    var secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = "Close"
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockAttributedModalInfoViewModel: ModalInfoViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the modal view"
    let body: GDSLocalisedString = .init(stringLiteral: "We can use this if we want the user to complete an action", attributes: [("We can use this", [.font: UIFont.bodyBold])])
    var bodyTextColour: UIColor? = nil
    var primaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.primary
    var secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = "Close"
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    func didDismiss() {}
}
