import UIKit

public final class ListTableViewCell: UITableViewCell {
    public var gdsLocalisedString: GDSLocalisedString {
        didSet {
            self.textLabel?.text = gdsLocalisedString.value
        }
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    
    public init(gdsLocalisedString: GDSLocalisedString) {
        self.gdsLocalisedString = gdsLocalisedString
        super.init(style: .default, reuseIdentifier: "listTableViewCell")
        self.textLabel?.text = gdsLocalisedString.value
    }

    public init(gdsLocalisedString: GDSLocalisedString,
                accessibilityLabel: String,
                accessibilityHint: String,
                accessibilityTraits: UIAccessibilityTraits) {
        self.gdsLocalisedString = gdsLocalisedString
        super.init(style: .default, reuseIdentifier: "listTableViewCell")
        self.textLabel?.text = gdsLocalisedString.value
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
        self.accessibilityTraits = accessibilityTraits
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
