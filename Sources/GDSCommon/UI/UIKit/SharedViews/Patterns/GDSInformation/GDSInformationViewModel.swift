import UIKit

public protocol GDSInformationViewModel {
    var image: String { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var footnote: GDSLocalisedString? { get } // good name?
    var primaryButtonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
}
