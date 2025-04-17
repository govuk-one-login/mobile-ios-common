import UIKit

@MainActor
public protocol NumberedListViewModel {
    var title: GDSLocalisedString? { get }
    var titleFont: UIFont? { get }
    var listItemStrings: [GDSLocalisedString] { get }
}

extension NumberedListViewModel {
    private var numberLabels: [UILabel] {
        listItemStrings
            .indices
            .map { index in
                let number = UILabel()
                number.text = "\(index + 1)."
                number.font = .body
                return number
            }
    }
    
    var maxNumberWidth: CGFloat {
        numberLabels.map(\.intrinsicContentSize.width).max() ?? 0
    }
}
