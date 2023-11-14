import Foundation
import GDSCommon
import UIKit

struct MockModalInfoViewModel: ModalInfoViewModel, BaseViewModel {
    var title: GDSLocalisedString = "This is the modal view"
    var body: GDSLocalisedString = "We can use this if we want the user to complete an action"
    var rightBarButtonTitle: GDSLocalisedString? = "Close"
    var backButtonIsHidden: Bool = false
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockAttributedModalInfoViewModel: ModalInfoViewModel, BaseViewModel {
    var title: GDSLocalisedString = "This is the modal view"
    var body: GDSLocalisedString = .init(stringLiteral: "We can use this if we want the user to complete an action", attributes: [("We can use this", [.font: UIFont.bodyBold])])
    var rightBarButtonTitle: GDSLocalisedString? = "Close"
    var backButtonIsHidden: Bool = false
    
    func didAppear() {}
    func didDismiss() {}
}
