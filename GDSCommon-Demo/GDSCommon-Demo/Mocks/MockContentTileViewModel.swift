import Foundation
import UIKit
import GDSCommon

struct MockContentTileViewModel: ContentTileViewModel {
    var image: UIImage? = UIImage(named: "placeholder")
    var caption: GDSLocalisedString? = "Example caption"
    var title: GDSLocalisedString = "Example title"
    var body: GDSLocalisedString? = "Example body"
    var showSeparatorLine: Bool = true
    var secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    var primaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.primary
    var dismissButton: ButtonViewModel? = MockButtonViewModel(title: "", icon: MockButtonIconViewModel(iconName: "xmark",
                                                                                                       symbolPosition: .beforeTitle),
                                                              shouldLoadOnTap: false,
                                                              action: { print("button tapped")})

}
