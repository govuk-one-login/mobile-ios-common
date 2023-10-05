import UIKit

/// Protocol for the view model required to initilise a ``ModalInfoViewController``
public protocol WelcomeViewModel {
    var image: UIImage { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var welcomeButtonViewModel: ButtonViewModel { get }
    
    func didAppear()
}
