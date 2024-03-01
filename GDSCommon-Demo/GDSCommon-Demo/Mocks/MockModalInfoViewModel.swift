import Foundation
import GDSCommon
import UIKit

struct MockModalInfoViewModel: ModalInfoViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the Modal view"
    let body: GDSLocalisedString = "We can use this if we want the user to complete an action"
    let rightBarButtonTitle: GDSLocalisedString? = "Close"
    let backButtonIsHidden: Bool = true
    
    func didAppear() { }
    func didDismiss() { }
}

struct MockModalInfoButtonsViewModel: ModalInfoViewModel,
                                      ModalInfoExtraViewModel,
                                      PageWithPrimaryButtonViewModel,
                                      PageWithSecondaryButtonViewModel,
                                      BaseViewModel {
    let title: GDSLocalisedString = "This is the Modal Buttons view"
    let body: GDSLocalisedString = "We can use this if we want the user to complete an action with buttons"
    let bodyTextColour: UIColor = .label
    let primaryButtonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel
    let rightBarButtonTitle: GDSLocalisedString? = "Close"
    let backButtonIsHidden: Bool = false
    let preventModalDismiss: Bool = true
    
    func didAppear() { }
    func didDismiss() { }
}

struct MockAttributedModalInfoViewModel: ModalInfoViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is the Attributed Modal view"
    let body: GDSLocalisedString = .init(stringLiteral: "We can use this attribubted text if we want the user to complete an action",
                                         attributes: [("We can use this attribubted text", [.font: UIFont.bodyBold])])
    let rightBarButtonTitle: GDSLocalisedString? = "Close"
    let backButtonIsHidden: Bool = false
    
    func didAppear() { }
    func didDismiss() { }
}
