import Foundation
import UIKit

public protocol BulletViewModel {
    var title: String? { get }
    var titleFont: UIFont? { get }
    var text: [String] { get }
}
