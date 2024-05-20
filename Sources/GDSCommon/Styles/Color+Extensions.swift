import SwiftUI

extension Color {
    public init(_ color: UIColor.GDSColours) {
        self.init(color.rawValue, bundle: .module)
    }
}
