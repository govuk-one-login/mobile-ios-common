import GDSCommon
import UIKit

struct MockLinkTheAppViewModel: LinkTheAppViewModel {
    var imageName: String = "exclamationmark.circle"
    var title: GDSLocalisedString = "Link the app title"
    var subtitle: GDSLocalisedString = "Link the app subtitle"
    var contentViews: [UIStackView]
    
    init() {
        // MARK: Labels
        let firstLabel = UILabel()
        firstLabel.text = "Example Text"
        let secondLabel = UILabel()
        secondLabel.text = "Second Example Text"
        let labels = [firstLabel, secondLabel]
        // MARK: Label Operations
        labels.forEach { view in
            
        }
        
        // MARK: StackViews
        let firstStackView = UIStackView(arrangedSubviews: labels)
        let stackViews = [firstStackView]
        // MARK: StackView Operations
        stackViews.forEach { view in
            view.axis = .vertical
        }
        
        contentViews = stackViews
    }
}
