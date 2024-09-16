import Foundation
import UIKit
import GDSCommon

struct MockContentTileViewModel: ContentTileViewModel {
    var image: UIImage? = UIImage(named: "placeholder")
    var caption: GDSLocalisedString? = "Example caption"
    var title: GDSLocalisedString = "Example title"
    var body: GDSLocalisedString? = "Example body"
    var actionText: ButtonViewModel? = MockButtonViewModel.secondary
    var actionButton: ButtonViewModel? = MockButtonViewModel.primary
    var dismissButton: ButtonViewModel?
    
//    init(image: UIImage? = nil,
//         caption: GDSLocalisedString?  = "Caption (optional)",
//         title: GDSLocalisedString = "Title",
//         body: GDSLocalisedString? = "Body (optional)") {
//        self.image = image
//        self.caption = caption
//        self.title = title
//        self.body = body
//    }
}
