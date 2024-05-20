import UIKit

extension Dictionary where Key == NSAttributedString.Key {
    static var bulletAttributes: [NSAttributedString.Key: Any] {
        [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .caption2).scaledFont(for: .bulletFont),
            NSAttributedString.Key.paragraphStyle: NSMutableParagraphStyle.bulletedList
        ]
    }
    
    static var stringAttributes: [NSAttributedString.Key: Any] {
        [
            NSAttributedString.Key.font: UIFont(style: .body, weight: .regular),
            NSAttributedString.Key.baselineOffset: NSNumber(value: -4),
            NSAttributedString.Key.paragraphStyle: NSMutableParagraphStyle.bulletedList
        ]
    }
}
