import UIKit

class PopoverTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet private var iconView: UIImageView! {
        didSet {
            iconView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        }
    }
    
    func setupView(item: PopoverItemViewModel) {
        self.iconView.image = UIImage(systemName: item.icon)?.withTintColor(item.tint, renderingMode: .alwaysOriginal)
        self.titleLabel.text = item.title
        self.titleLabel.font = item.titleFont
        self.titleLabel.textColor = item.tint
    }
}
