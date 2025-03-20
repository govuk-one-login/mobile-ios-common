import Foundation
import UIKit

public extension UIControl {
    func addAction(
        for controlEvents: UIControl.Event = .primaryActionTriggered,
        action: @escaping () -> Void
    ) {
        let sleeve = UIControl.ClosureSleeve(
            attached: action,
            to: self
        )
        
        addTarget(
            sleeve,
            action: #selector(UIControl.ClosureSleeve.invoke),
            for: controlEvents
        )
    }
    
    class ClosureSleeve {
        let closure: () -> Void
        init(
            attached closure: @escaping () -> Void,
            to object: AnyObject
        ) {
            self.closure = closure
            objc_setAssociatedObject(
                object,
                "[\(UInt64.random(in: 0..<UInt64.max))]",
                self,
                .OBJC_ASSOCIATION_RETAIN
            )
        }
        
        @objc
        func invoke() {
            closure()
        }
    }
}
