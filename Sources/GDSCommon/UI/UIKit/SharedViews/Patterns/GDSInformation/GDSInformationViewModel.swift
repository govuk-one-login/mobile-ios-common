import UIKit

/// Protocol for the view model required to initilise ``GDSInformationViewController``
public protocol GDSInformationViewModel {
    var image: String { get }
    var imageWeight: UIFont.Weight? { get }
    var imageColour: UIColor? { get }
    var imageHeightConstraint: CGFloat? { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
    var footnote: GDSLocalisedString? { get }
    var primaryButtonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
}
