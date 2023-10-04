import Foundation
import GDSCommon

class MockModalInfoViewModel: ModalInfoViewModel {
    var title: GDSLocalisedString = "This is the modal view"
    var body: GDSLocalisedString = "We can use this if we want the user to complete an action"
    var rightBarButtonTitle: GDSLocalisedString = "Close"
    func didAppear() {}
    func didDismiss() {}
}
