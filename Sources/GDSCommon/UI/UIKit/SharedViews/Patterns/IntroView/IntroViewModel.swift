import UIKit

/// Protocol for the view model required to initilise a ``IntroViewController``
public protocol IntroViewModel: BaseViewModel {
    var image: UIImage { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var introButtonViewModel: ButtonViewModel { get }
}
