import Foundation
import GDSCommon
import UIKit

struct MockContentTileViewModel: ExpandedContentTileViewModel {
    var image: UIImage = UIImage(named: "placeholder") ?? UIImage()
    var caption: GDSLocalisedString = "test caption"
    var title: GDSLocalisedString = "test title"
    var body: GDSLocalisedString = "test body"
    var showSeparatorLine: Bool = true
    var backgroundColour: UIColor?
    var secondaryButtonViewModel: ButtonViewModel
    var primaryButtonViewModel: ButtonViewModel
    var closeButtonAction: () -> Void
}
