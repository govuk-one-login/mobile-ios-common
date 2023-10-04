import GDSCommon
import UIKit

class MockInstructionWithImageViewModel: InstructionsWithImageViewModel {
    var title: GDSLocalisedString
    var body: NSAttributedString
    var image: UIImage
    var warningButtonViewModel: ButtonViewModel?
    var primaryButtonViewModel: ButtonViewModel
    func didAppear() {}
    
    init(title: GDSLocalisedString = "This is the Instructions with image view",
         body: NSAttributedString = NSAttributedString("We can use this body to provide details or context as to what we want the users to do"),
         image: UIImage = UIImage(named: "licence")!,
         warningButtonViewModel: ButtonViewModel? = nil,
         primaryButtonViewModel: ButtonViewModel) {
        self.title = title
        self.body = body
        self.image = image
        self.warningButtonViewModel = warningButtonViewModel
        self.primaryButtonViewModel = primaryButtonViewModel
    }
}
