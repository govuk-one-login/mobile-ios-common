import Foundation
import UIKit

@MainActor
public protocol BulletViewModel: ScreenBodyItem {
    var title: String? { get }
    var titleFont: UIFont? { get }
    var text: [String] { get }
}

extension BulletViewModel {
    public var uiView: UIView {
        let result = BulletView(
            title: self.title,
            text: self.text,
            titleFont: self.titleFont ?? UIFont(
                style: .title2,
                weight: .bold
            )
        )
        return result
    }
}
