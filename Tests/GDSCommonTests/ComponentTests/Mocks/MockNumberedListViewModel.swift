import GDSCommon
import UIKit

@MainActor
struct MockNumberedListViewModel: NumberedListViewModel {
    var title: GDSLocalisedString = "numbered list test title"
    var titleFont: UIFont? = .body
    var listItemStrings: [GDSLocalisedString] = [
        "test numbered list element 1",
        "test numbered list element 2",
        "test numbered list element 3"
    ]
}
