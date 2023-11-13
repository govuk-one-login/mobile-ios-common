import GDSCommon
import UIKit

struct MockIntroViewModel: IntroViewModel {
    var image: UIImage = UIImage(named: "badge") ?? UIImage()
    var title: GDSLocalisedString = "This is a Intro Screen"
    var body: GDSLocalisedString = "This is the body where we can give a brief description of the app"
    var introButtonViewModel: ButtonViewModel
    var rightBarButtonTitle: GDSLocalisedString?
    var backButtonIsHidden: Bool = false
    
    func didAppear() { }
    func didDismiss() { }
}
