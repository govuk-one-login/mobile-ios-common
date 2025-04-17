import UIKit

@MainActor
public protocol NumberedListViewModel {
    var title: GDSLocalisedString? { get }
    var titleFont: UIFont? { get }
    var listItemStrings: [GDSLocalisedString] { get }
}

extension NumberedListViewModel {
    var numberLabels: [UILabel] {
        listItemStrings
            .indices
            .map { index in
                let number = UILabel()
                number.text = "\(index + 1)."
                number.font = .body
                return number
            }
    }
}
