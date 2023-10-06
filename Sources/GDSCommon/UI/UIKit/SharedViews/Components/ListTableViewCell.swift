import UIKit

final class ListTableViewCell: UITableViewCell {
    var gdsLocalisedString: GDSLocalisedString {
        didSet {
            self.textLabel?.text = gdsLocalisedString.value
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    
    init(gdsLocalisedString: GDSLocalisedString) {
        self.gdsLocalisedString = gdsLocalisedString
        super.init(style: .default, reuseIdentifier: "listTableViewCell")
        self.textLabel?.text = gdsLocalisedString.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
