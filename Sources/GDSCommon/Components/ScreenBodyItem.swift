import UIKit

public protocol ScreenBodyItem {
    @MainActor var uiView: UIView { get }
}
