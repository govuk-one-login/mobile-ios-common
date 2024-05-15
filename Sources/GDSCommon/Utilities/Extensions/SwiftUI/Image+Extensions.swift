import SwiftUI

// TODO: DCMAW-5307 Look into @BackDeployment (available in swift 5.8) to remove `if available` flags for iOS 13

extension Image {
    public func iconImage(size: CGFloat = 100, colour: Color? = nil, weight: Font.Weight = .light) -> some View {
        if #available(iOS 14.0, *) {
            return self
                .resizable()
                .scaledToFit()
                .frame(maxWidth: size)
                .imageScale(.large)
                .accessibilityHidden(true)
                .font(Font.body.weight(weight))
                .foregroundColor(colour)
        } else {
            return self
                .resizable()
                .scaledToFit()
                .frame(maxWidth: size)
                .imageScale(.large)
                .font(Font.body.weight(weight))
                // no accessibility features in iOS 13
        }
    }
}
