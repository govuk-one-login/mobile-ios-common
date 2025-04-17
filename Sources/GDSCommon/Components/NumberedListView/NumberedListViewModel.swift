import UIKit

@MainActor
public protocol NumberedListViewModel {
    var title: GDSLocalisedString? { get }
    var titleFont: UIFont? { get }
    var listItemStrings: [GDSLocalisedString] { get }
}
