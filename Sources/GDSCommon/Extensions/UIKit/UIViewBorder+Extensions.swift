import UIKit

extension UIView {
    @discardableResult
    func gdsBorders() -> [UIView] {
        self.bordersTo([.top, .bottom],
                       colour: .tertiaryLabel,
                       width: 0.25)
    }
    
    @discardableResult
    public func bordersTo(_ edges: [BorderEdge],
                          colour: UIColor = .label,
                          width: Double = 1) -> [UIView] {
        
        return edges.map { edge in
            addBorder(edge,
                      colour: colour,
                      width: width)
        }
    }
    
    private func addBorder(_ edge: BorderEdge,
                           colour: UIColor,
                           width: Double) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = colour
        addSubview(view)
        setConstraints(from: self, to: view, width: width, edge: edge)
        return UIView()
    }
    
    private func setConstraints(from: UIView, to: UIView, width: Double, edge: BorderEdge) {
        switch edge {
        case .top, .bottom:
            let anchor: NSLayoutConstraint = edge == .top ?
            from.topAnchor.constraint(equalTo: to.topAnchor) :
            from.bottomAnchor.constraint(equalTo: to.bottomAnchor)
            
            NSLayoutConstraint.activate([
                anchor,
                to.widthAnchor.constraint(equalToConstant: from.bounds.width),
                to.heightAnchor.constraint(equalToConstant: width)
            ])
            
        case .right, .left:
            let anchor: NSLayoutConstraint = edge == .right ?
            from.rightAnchor.constraint(equalTo: to.rightAnchor) :
            from.leftAnchor.constraint(equalTo: to.leftAnchor)
            
            NSLayoutConstraint.activate([
                anchor,
                to.heightAnchor.constraint(equalToConstant: from.bounds.height),
                to.widthAnchor.constraint(equalToConstant: width)
            ])
        }
    }
}

public enum BorderEdge: CaseIterable {
    case top
    case right
    case bottom
    case left
}
