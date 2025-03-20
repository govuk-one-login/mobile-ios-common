import UIKit

extension UIStackView {
    public convenience init(
        views: UIView...,
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 24,
        alignment: UIStackView.Alignment = .leading
    ) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
    }
    
    public convenience init(
        views: [UIView],
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 24,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually
    ) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
