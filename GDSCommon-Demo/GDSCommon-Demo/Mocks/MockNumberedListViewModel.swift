import GDSCommon
import UIKit

struct MockNumberedListViewModel: NumberedListViewModel {
    var title: GDSLocalisedString = "Test numbered list view"
    var titleFont: UIFont? = .body
    var listItemStrings: [GDSLocalisedString] = [
        "first numbered list element",
        GDSLocalisedString(
            stringLiteral: "second numbered list element",
            attributes: [("numbered list", [.font: UIFont.bodyBold])]
        ),
        "third numbered list element",
        "fourth numbered list element"
    ]
}
