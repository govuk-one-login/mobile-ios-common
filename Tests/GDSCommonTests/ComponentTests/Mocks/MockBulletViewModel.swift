import GDSCommon
import UIKit

@MainActor
struct MockBulletViewModel: BulletViewModel {
    var title: String? = "test title"
    var titleFont: UIFont? = .title3
    var text = ["item 1", "item 2", "item 3"]
}
