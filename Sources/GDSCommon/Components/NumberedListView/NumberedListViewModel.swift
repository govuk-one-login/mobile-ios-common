import UIKit

@MainActor
public protocol NumberedListViewModel {
    var title: GDSLocalisedString { get }
    var titleFont: UIFont? { get }
    var listItemStrings: [GDSLocalisedString] { get }
}

extension NumberedListViewModel {
    var numberLabels: [UILabel] {
        listItemStrings
            .enumerated()
            .map { index, _ in
                let number = UILabel()
                number.text = "\(index + 1)."
                number.font = .body
                return number
            }
    }
    
    var maxNumberWidth: CGFloat {
        numberLabels.max {
            $0.intrinsicContentSize.width < $1.intrinsicContentSize.width
        }?.intrinsicContentSize.width ?? 0
    }
}
