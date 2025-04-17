import GDSCommon
import UIKit

struct MockNumberedListViewModel: NumberedListViewModel {
    var title: GDSLocalisedString?
    var titleFont: UIFont?
    var listItemStrings: [GDSLocalisedString]
    
    init(
        title: GDSLocalisedString? = "Test numbered list view",
        titleFont: UIFont? = .body,
        listItemStrings: [GDSLocalisedString] = [
            "first numbered list element",
            GDSLocalisedString(
                stringLiteral: "second numbered list element",
                attributes: [("numbered list", [.font: UIFont.bodyBold])]
            ),
            "third numbered list element",
            "fourth numbered list element"
        ]
    ) {
        self.title = title
        self.titleFont = titleFont
        self.listItemStrings = listItemStrings
    }
}
