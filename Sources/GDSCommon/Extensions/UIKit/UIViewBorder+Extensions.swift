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
        case .top:
            NSLayoutConstraint.activate([
                from.topAnchor.constraint(equalTo: to.topAnchor),
                to.widthAnchor.constraint(equalToConstant: from.bounds.width),
                to.heightAnchor.constraint(equalToConstant: width)
            ])
        case .right:
            NSLayoutConstraint.activate([
                from.rightAnchor.constraint(equalTo: to.rightAnchor),
                to.heightAnchor.constraint(equalToConstant: from.bounds.height),
                to.widthAnchor.constraint(equalToConstant: width)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                from.bottomAnchor.constraint(equalTo: to.bottomAnchor),
                to.widthAnchor.constraint(equalToConstant: from.bounds.width),
                to.heightAnchor.constraint(equalToConstant: width)
            ])
        case .left:
            NSLayoutConstraint.activate([
                from.leftAnchor.constraint(equalTo: to.leftAnchor),
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

//    case all
    
//    public var rawValue: UIRectEdge {
//        switch self {
//        case .top:
//            return .top
//        case .right:
//            return .right
//        case .bottom:
//            return .bottom
//        case .left:
//            return .left
//        case .all:
//            return .all
//        }
//    }
//    
//    public init?(rawValue: UIRectEdge) {
//        switch rawValue {
//        case .top:
//            self = .top
//        case .right:
//            self = .right
//        case .bottom:
//            self = .bottom
//        case .left:
//            self = .left
//        case .all:
//            self = .all
//        default:
//            return nil
//        }
//    }

