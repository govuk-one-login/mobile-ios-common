import UIKit

public protocol ScreenBodyItem {
    var horizontalPadding: CGFloat? { get }
    
    @MainActor var uiView: UIView { get }
}

extension ScreenBodyItem {
    public var horizontalPadding: CGFloat? { nil }
}
