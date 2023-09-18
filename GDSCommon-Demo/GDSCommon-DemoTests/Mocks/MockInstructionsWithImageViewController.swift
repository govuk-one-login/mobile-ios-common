import GDSCommon
import UIKit

internal struct MockInstructionsWithImageViewController: InstructionsWithImageViewModel {
    let title: GDSLocalisedString = "test title"
    let body: NSAttributedString = NSAttributedString(string: "test body")
    let image: UIImage = UIImage(systemName: "photo")!
    let warningButtonViewModel: ButtonViewModel?
    let primaryButtonViewModel: ButtonViewModel
    let screenView: () -> Void
    
    func didAppear() {
        screenView()
    }
    
    init(screenView: @escaping () -> Void,
         buttonAction: @escaping () -> Void,
         warningButtonAction: @escaping () -> Void) {
        self.screenView = screenView
        
        self.warningButtonViewModel = MockButtonViewModel(title: GDSLocalisedString(stringLiteral: "button title")) {
            warningButtonAction()
        }
        
        self.primaryButtonViewModel = MockButtonViewModel(title: GDSLocalisedString(stringLiteral: "button title")) {
            buttonAction()
        }
    }
}
