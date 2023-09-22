import Foundation
import GDSCommon

class MockModalInfoViewModel: ModalInfoViewModel {
    var title: GDSCommon.GDSLocalisedString = "This is the modal view"
    var body: GDSCommon.GDSLocalisedString = "We can use this if we want the user to complete an action"
    var rightBarButtonTitle: GDSCommon.GDSLocalisedString = "Close"
    func didAppear() {}
    func didDismiss() {}
}
