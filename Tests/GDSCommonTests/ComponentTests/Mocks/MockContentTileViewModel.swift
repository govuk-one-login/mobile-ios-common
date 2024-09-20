import Foundation
import UIKit
import GDSCommon

struct MockContentTileViewModel: ContentTile {
    var image: UIImage = UIImage(named: "placeholder")!
    var caption: GDSLocalisedString = "test caption"
    var title: GDSLocalisedString = "test title"
    var body: GDSLocalisedString = "test body"
    var showSeparatorLine: Bool = true
    var backgroundColour: UIColor?
    var isTappable: Bool = false
    var secondaryButtonViewModel: ButtonViewModel = MockButtonViewModel(title: "test secondary button",
                                                                        icon:  ButtonIcon.arrowUpRight as? ButtonIconViewModel,
                                                                        action: {})
    
    var primaryButtonViewModel: ButtonViewModel = MockButtonViewModel(title: "test primary button",
                                                                      action: {})
    
    var closeButton: ButtonViewModel = MockButtonViewModel(title: "",
                                                           icon: ButtonIcon.xMark as? ButtonIconViewModel,
                                                           action: {})
}
