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
            titleFont: self.titleFont ?? .title3Bold
        )
        return result
    }
}

public struct BaseBulletViewModel: BulletViewModel {
    public var title: String?
    public var titleFont: UIFont? = .init(style: .body, weight: .bold)
    public var text: [String]
    
    public init(
        title: String? = nil,
        titleFont: UIFont? = nil,
        text: [String]
    ) {
        self.title = title
        self.titleFont = titleFont
        self.text = text
    }
}
