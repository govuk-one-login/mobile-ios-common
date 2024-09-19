import Foundation
import UIKit
import GDSCommon

struct MockContentTileViewModel: ContentTile {
    var image: UIImage = UIImage(named: "placeholder")!
    var caption: GDSLocalisedString = "Example caption"
    var title: GDSLocalisedString = "Example title"
    var body: GDSLocalisedString = "Example body"
    var showSeparatorLine: Bool = true
    var secondaryButtonViewModel: ButtonViewModel = MockButtonViewModel.secondary
    var primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    var closeButton: ButtonViewModel = MockButtonViewModel.icon
}
