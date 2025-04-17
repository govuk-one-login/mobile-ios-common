import GDSCommon
import UIKit

struct MockNumberedListViewModel: NumberedListViewModel {
    var title: GDSLocalisedString?
    var titleFont: UIFont?
    var listItemStrings: [GDSLocalisedString]
    
    init(
        title: GDSLocalisedString? = "numbered list test title",
        titleFont: UIFont? = .body,
        listItemStrings: [GDSLocalisedString] = [
            "test numbered list element 1",
            GDSLocalisedString(
                stringLiteral: "test numbered list element 2",
                attributes: [("numbered list", [.font: UIFont.bodyBold])]
            ),
            "test numbered list element 3"
        ]
    ) {
        self.title = title
        self.titleFont = titleFont
        self.listItemStrings = listItemStrings
    }
}
