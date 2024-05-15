import UIKit

class PopoverTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.adjustsFontForContentSizeCategory = true
            titleLabel.accessibilityIdentifier = "title-label"
        }
    }
    @IBOutlet private var iconView: UIImageView! {
        didSet {
            iconView.adjustsImageSizeForAccessibilityContentSizeCategory = true
            iconView.accessibilityIdentifier = "icon-view"
        }
    }
    
    func setupView(item: PopoverItemViewModel) {
        self.iconView.image = UIImage(systemName: item.icon)?.withTintColor(item.tint, renderingMode: .alwaysOriginal)
        self.titleLabel.text = item.title
        self.titleLabel.font = item.titleFont
        self.titleLabel.textColor = item.tint
    }
}
