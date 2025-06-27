import UIKit

public struct DividerViewModel: ScreenBodyItem {
    var background: UIColor
    
    public init(background: UIColor) {
        self.background = background
    }
}

extension DividerViewModel {
    public var uiView: UIView {
        let result = UIView()
        result.accessibilityIdentifier = "divider"
        result.heightAnchor.constraint(equalToConstant: 1).isActive = true
        result.backgroundColor = background
        return result
    }
}
