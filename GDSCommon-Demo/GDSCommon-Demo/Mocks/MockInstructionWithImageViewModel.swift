import GDSCommon
import UIKit

struct MockInstructionsWithImageViewModel: InstructionsWithImageViewModel {
    var title: GDSLocalisedString
    var body: NSAttributedString
    var image: UIImage
    var warningButtonViewModel: ButtonViewModel?
    var primaryButtonViewModel: ButtonViewModel
    
    let screenView: () -> Void
    
    func didAppear() {
        screenView()
    }
    
    init(title: GDSLocalisedString = "This is the Instructions with image view",
         body: NSAttributedString = NSAttributedString("We can use this body to provide details or context as to what we want the users to do"),
         image: UIImage = UIImage(named: "licence")!,
         warningButtonViewModel: ButtonViewModel? = nil,
         primaryButtonViewModel: ButtonViewModel,
         screenView: @escaping () -> Void) {
        self.title = title
        self.body = body
        self.image = image
        self.warningButtonViewModel = warningButtonViewModel
        self.primaryButtonViewModel = primaryButtonViewModel
        self.screenView = screenView
    }
}
