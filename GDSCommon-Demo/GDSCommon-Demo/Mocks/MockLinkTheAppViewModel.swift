import GDSCommon
import UIKit

struct MockLinkTheAppViewModel: LinkTheAppViewModel {
    var imageName: String = "exclamationmark.circle"
    var title: GDSLocalisedString = "Link the app title"
    var subtitle: GDSLocalisedString = "Link the app subtitle"
    var contentViews: [UIStackView]
    
    init() {
        let firstLabel = UILabel()
        firstLabel.text = "Example Text"
        let firstStackView = UIStackView(arrangedSubviews: [firstLabel])
        contentViews = [firstStackView]
    }
}
