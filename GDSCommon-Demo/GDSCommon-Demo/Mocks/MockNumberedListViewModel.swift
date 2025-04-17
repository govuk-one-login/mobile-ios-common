import GDSCommon
import UIKit

struct MockNumberedListViewModel: NumberedListViewModel {
    var title: GDSLocalisedString
    var titleFont: UIFont?
    var listItemStrings: [GDSLocalisedString]
}
