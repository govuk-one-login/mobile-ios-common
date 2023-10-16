import Foundation
import GDSCommon
import UIKit

class MockModalInfoViewModel: ModalInfoViewModel {
    var title: GDSLocalisedString = "This is the modal view"
    var body: GDSLocalisedString? = "We can use this if we want the user to complete an action"
    var attributedBody: GDSAttributedString?
    var rightBarButtonTitle: GDSLocalisedString = "Close"
    func didAppear() {}
    func didDismiss() {}
}

class MockAttributedModalInfoViewModel: ModalInfoViewModel {
    var title: GDSLocalisedString = "This is the modal view"
    var body: GDSLocalisedString?
    var attributedBody: GDSAttributedString? = GDSAttributedString(localisedString: "We can use this if we want the user to complete an action",
                                                                   attributes: [.font: UIFont.bodyBold],
                                                                   stringToAttribute: "We can use this if")
    var rightBarButtonTitle: GDSLocalisedString = "Close"
    func didAppear() {}
    func didDismiss() {}
}
