import Foundation
import UIKit

/// Protocol for the view model required to initilise a ``ListOptionsViewController``
public protocol ListOptionsViewModel {
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
