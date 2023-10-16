import GDSCommon
import UIKit

struct MockLinkTheAppViewModel: LinkTheAppViewModel {
    let imageName: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "Link needed to continue"
    let subtitle: GDSLocalisedString = "To use the GOV.UK ID Check app, you must link it to the GOV.UK website."
    let contentViews: [UIStackView]
    
    init() {
        // MARK: Labels
        let firstLabel = UILabel()
        firstLabel.text = "Example Text"
        firstLabel.font = UIFont(style: .headline, weight: .semibold)
        let secondLabel = UILabel()
        secondLabel.text = "Second Example Text"
        secondLabel.font = UIFont(style: .body)
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .darkGray
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        let button = UIButton(type: .system)
        button.setTitle("Example Button Text", for: .normal)
        button.titleLabel?.font = UIFont(style: .body)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.contentHorizontalAlignment = .leading
        let labels = [firstLabel, secondLabel, divider, button]
        // MARK: Label Operations
        labels.forEach { view in
            if let label = view as? UILabel {
                label.adjustsFontForContentSizeCategory = true
                label.numberOfLines = 0
            }
        }

        
        // MARK: StackViews
        let firstStackView = UIStackView(arrangedSubviews: labels)
        let stackViews = [firstStackView]
        // MARK: StackView Operations
        stackViews.forEach { view in
            view.axis = .vertical
            view.spacing = 8
            view.isLayoutMarginsRelativeArrangement = true
            view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        }
        
        contentViews = stackViews
    }
}
