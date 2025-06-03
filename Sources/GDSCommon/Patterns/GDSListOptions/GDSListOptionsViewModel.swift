import Foundation
import UIKit

/// Protocol for the view model required to initilise a ``ListOptionsViewController``
@available(*, deprecated, renamed: "GDSListOptionsViewModelV2", message: "Please use GDSListOptionsViewModelV2 for accessibility enhancements") // depreciated 3/6/2025
@MainActor
public protocol GDSListOptionsViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
    var childView: UIView? { get }
    var listTitle: GDSLocalisedString? { get }
    var listRows: [GDSLocalisedString] { get }
    var listFooter: GDSLocalisedString? { get }
    var buttonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
    var resultAction: (GDSLocalisedString) -> Void { get }
}

/// Protocol for the view model to initialise ``GDSListOptionsViewController`` with TableView Cell accessibility enhancements
/// `accessibilityTraits` sets `cell.accessibiltyTraits` and tells VoiceOver if it is a button, link
///    - note: if the option can be selected, the trait will also be set to `.selected` and announced.
///    - As of iOS18, the unselected state is not announced.
/// `accessibilityLabel` sets `cell.accessibilityLabel`. This is usually the value you have in the cell
/// `accessibilityHint` sets `cell.accessibilityHint`. This is extra content if the label is too long
///     - i.e "option 1 of 3"
/// Order of VoiceOver announcing accessibility seems to be:
/// - "`accessibiltyLabel`, `accessibilityTraits`, `accessibilityHint`"
@MainActor
public protocol GDSListOptionsViewModelV2  {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
    var childView: UIView? { get }
    var listTitle: GDSLocalisedString? { get }
    var listRows: [GDSListCellViewModel] { get }
    var listFooter: GDSLocalisedString? { get }
    var buttonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
    var resultAction: (GDSLocalisedString) -> Void { get }
}

public protocol GDSListCellViewModel {
    var title: GDSLocalisedString { get }
    var accessibilityLabel: String { get }
    var accessibilityHint: String { get }
    var accessibilityTraits: UIAccessibilityTraits { get }
}
