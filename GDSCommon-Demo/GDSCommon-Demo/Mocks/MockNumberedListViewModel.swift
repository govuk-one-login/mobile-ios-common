import GDSCommon
import UIKit

struct MockNumberedListViewModel: NumberedListViewModel {
    var title: GDSLocalisedString?
    var titleConfig: TitleConfig?
    var listItemStrings: [GDSLocalisedString]
    
    init(
        title: GDSLocalisedString? = "Test numbered list view",
        titleConfig: TitleConfig? = (font: .body, isHeader: true),
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
        self.titleConfig = titleConfig
        self.listItemStrings = listItemStrings
    }
}
