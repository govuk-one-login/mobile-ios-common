import Foundation
import UIKit

@MainActor
public protocol BulletViewModel: ScreenBodyItem {
    var title: String? { get }
    var titleFont: UIFont? { get }
    var text: [String] { get }
}
