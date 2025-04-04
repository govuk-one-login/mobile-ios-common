import GDSCommon
import UIKit

@MainActor
struct MockBulletViewModel: BulletViewModel {
    let title: String? = "test title"
    var titleFont: UIFont?
    let text = ["item 1", "item 2", "item 3"]
}
