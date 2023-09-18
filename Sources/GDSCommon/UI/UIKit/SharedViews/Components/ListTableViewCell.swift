import UIKit

final class ListTableViewCell: UITableViewCell {
    var gdsLocalisedString: GDSLocalisedString? {
        didSet {
            self.textLabel?.text = gdsLocalisedString?.value
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}
