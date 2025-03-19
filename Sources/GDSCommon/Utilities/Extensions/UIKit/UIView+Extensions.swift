import UIKit

extension UIView {
    public func addSubview(
        _ view: UIView,
        insetBy insets: UIEdgeInsets
    ) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: insets.top
            ),
            view.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: insets.left
            ),
            view.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -insets.right
            ),
            view.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -insets.bottom
            )
        ])
    }
    
    public func bindToSuperviewEdges(
        padding: CGFloat = 0
    ) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil, call `addSubview(view: UIView)` before calling `bindToSuperviewEdges()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(
                equalTo: superview.leadingAnchor,
                constant: padding
            ),
            self.trailingAnchor.constraint(
                equalTo: superview.trailingAnchor,
                constant: -padding
            ),
            self.topAnchor.constraint(
                equalTo: superview.topAnchor,
                constant: padding
            ),
            self.bottomAnchor.constraint(
                equalTo: superview.bottomAnchor,
                constant: -padding
            )
        ])
    }
    
    public func bindToSuperviewSafeArea(
        insetBy insets: UIEdgeInsets
    ) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil, call `addSubview(view: UIView)` before calling `bindToSuperviewSafeArea()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.leadingAnchor,
                constant: insets.left
            ),
            self.trailingAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.trailingAnchor,
                constant: -insets.right
            ),
            self.topAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.topAnchor,
                constant: insets.top
            ),
            self.bottomAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                constant: -insets.bottom
            )
        ])
        
    }
}
