import Foundation
import GDSCommon
import UIKit

struct MockGDSContentTile: ExpandedContentTileViewModel {
    var cardTappedAction: () -> Void
    var closeButtonAction: () -> Void
    var image: UIImage = UIImage(named: "placeholder")!
    var caption: GDSLocalisedString = "test caption"
    var title: GDSLocalisedString = "test title"
    var body: GDSLocalisedString = "test body"
    var showSeparatorLine: Bool = true
    var backgroundColour: UIColor?
    var secondaryButtonViewModel: ButtonViewModel = MockButtonViewModel.secondary
    var primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
}
