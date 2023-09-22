import UIKit
import GDSCommon

class MockInstructionWithImageViewModel: InstructionsWithImageViewModel {
    var title: GDSCommon.GDSLocalisedString
    var body: NSAttributedString
    var image: UIImage
    var warningButtonViewModel: GDSCommon.ButtonViewModel?
    var primaryButtonViewModel: GDSCommon.ButtonViewModel
    func didAppear() {}
    
    init(title: GDSCommon.GDSLocalisedString = "This is the Instructions with image view",
         body: NSAttributedString = NSAttributedString("We can use this body to provide details or context as to what we want the users to do"),
         image: UIImage = UIImage(named: "licence")!,
         warningButtonViewModel: GDSCommon.ButtonViewModel? = nil,
         primaryButtonViewModel: GDSCommon.ButtonViewModel) {
        self.title = title
        self.body = body
        self.image = image
        self.warningButtonViewModel = warningButtonViewModel
        self.primaryButtonViewModel = primaryButtonViewModel
    }
}
