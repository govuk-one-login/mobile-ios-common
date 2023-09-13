import UIKit

extension NSMutableParagraphStyle {
    static var bulletedList: NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.tabStops = [NSTextTab(textAlignment: .left, location: 14), NSTextTab(textAlignment: .left, location: 44)]
        style.headIndent = 44
        style.paragraphSpacing = 8
        style.lineSpacing = -4

        return style
    }
}
