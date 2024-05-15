import UIKit

extension UITableView {
    open override var intrinsicContentSize: CGSize {
        contentSize
    }
    
    open override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public func redraw() {
        invalidateIntrinsicContentSize()
        updateConstraints()
    }
}
