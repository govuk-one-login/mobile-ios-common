import Foundation
import UIKit

extension UILabel {
    public func setBulletedList(strings: [String]) {
        attributedText = strings.map {
            NSAttributedString([
                .bullet,
                NSAttributedString(string: $0, attributes: .stringAttributes)
            ])
        }.joined(separator: .newLine)
        
        accessibilityLabel = attributedText?.string
            .replacingOccurrences(of: "●", with: "Bullet Point, ")
    }
}
