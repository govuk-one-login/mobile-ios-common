import UIKit

public enum BorderEdge: CaseIterable {
    case top
    case right
    case bottom
    case left
}

extension Collection where Element == BorderEdge {
    static var all: Set<BorderEdge> {
        Set(BorderEdge.allCases)
    }
    
    static var vertical: Set<BorderEdge> {
        [.right, .left]
    }
    
    static var horizontal: Set<BorderEdge> {
        [.top, .bottom]
    }
}

extension UIView {
    func gdsBorders() {
        self.bordersTo(.horizontal,
                       colour: .tertiaryLabel,
                       width: 0.25)
    }
    
    public func bordersTo(_ edges: Set<BorderEdge>,
                          colour: UIColor = .label,
                          width: Double = 1) {
        
        edges.forEach { edge in
            addBorder(edge,
                      colour: colour,
                      width: width)
        }
    }
    
    private func addBorder(_ edge: BorderEdge,
                           colour: UIColor,
                           width: Double) {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = colour
        addSubview(view)
        setConstraints(from: self, to: view, width: width, edge: edge)
    }
    
    private func setConstraints(from: UIView,
                                to: UIView,
                                width: Double,
                                edge: BorderEdge) {
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
