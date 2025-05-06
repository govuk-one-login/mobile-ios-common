import GDSCommon
import UIKit

struct MockIntroViewModel: IntroViewModel, BaseViewModel {
    let image: UIImage = UIImage(named: "badge") ?? UIImage()
    let title: GDSLocalisedString = "This is a Intro Screen"
    let body: GDSLocalisedString = "This is the body where we can give a brief description of the app"
    let introButtonViewModel: ButtonViewModel
    let rightBarButtonTitle: GDSLocalisedString?
    let backButtonIsHidden: Bool = false
    let accessibilityLabel: GDSLocalisedString? = "Intro Screen"
    
    func didAppear() { }
    func didDismiss() { }
}
