import GDSCommon
import UIKit

struct MockWelcomeViewModel: WelcomeViewModel {
    var image: UIImage = UIImage(named: "badge")!
    var title: GDSLocalisedString = "This is a Welcome Screen"
    var body: GDSLocalisedString = "This is the body where we can give a brief description of the app"
    var welcomeButtonViewModel: ButtonViewModel
    
    func didAppear() { }
}
