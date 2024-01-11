import GDSCommon
import UIKit

struct MockBulletViewModel: BulletViewModel {
    var title: String?
    var titleFont: UIFont?
    var text: [String]
    
    init(title: String? = "This is the bullet view",
         titleFont: UIFont? = .init(style: .title2, weight: .bold),
         text: [String] = ["Here we can list things we want the user to know", "we can use this as a way to step them through an action", "or give details of a process"]) {
        self.title = title
        self.titleFont = titleFont
        self.text = text
    }
}
