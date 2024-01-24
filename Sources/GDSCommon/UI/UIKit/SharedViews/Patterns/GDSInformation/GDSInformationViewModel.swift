import UIKit

public protocol GDSInformationViewModel {
    var image: String { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get } // do we need second body label? see Face ID screen
    var footnote: GDSLocalisedString? { get } // good name?
    var primaryButtonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
}
