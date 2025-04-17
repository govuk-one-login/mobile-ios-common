import GDSCommon
import UIKit

struct MockNumberedListViewModel: NumberedListViewModel {
    var title: GDSLocalisedString = "numbered list test title"
    var titleFont: UIFont? = .body
    var listItemStrings: [GDSLocalisedString] = [
        "test numbered list element 1",
        GDSLocalisedString(
            stringLiteral: "test numbered list element 2",
            attributes: [("numbered list", [.font: UIFont.bodyBold])]
        ),
        "test numbered list element 3"
    ]
}
