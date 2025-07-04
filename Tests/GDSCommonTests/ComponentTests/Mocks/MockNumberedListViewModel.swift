import GDSCommon
import UIKit

struct MockNumberedListViewModel: ListViewModel {
    var title: GDSLocalisedString?
    var titleConfig: TitleConfig?
    var listItemStrings: [GDSLocalisedString]
    
    init(
        title: GDSLocalisedString? = "numbered list test title",
        titleConfig: TitleConfig? = (font: .body, isHeader: false),
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
        self.titleConfig = titleConfig
        self.listItemStrings = listItemStrings
    }
}
