import GDSCommon
import UIKit

internal struct MockGDSInstructionsViewModel: GDSInstructionsViewModel {
    let title: GDSLocalisedString = "test title"
    let body: String = "test body"
    let childView: UIView
    let buttonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel? = nil
    
    let screenView: () -> Void
    
    func didAppear() {
        screenView()
    }
}
