import SwiftUI

// TODO: DCMAW-5307 Look into @BackDeployment (available in swift 5.8) to remove `if available` flags for iOS 13

extension Text {
    public func title(textAlignment: TextAlignment = .center) -> some View {
        if #available(iOS 14.0, *) {
            return self
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(textAlignment)
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityAddTraits(.isHeader)
        } else {
            return self
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(textAlignment)
                .fixedSize(horizontal: false, vertical: true)
            // no accessibility traits for iOS 13 :-(
        }
    }
}

// should this have a `Header` accessibility trait?
extension Text {
    public func subtitle() -> some View {
        if #available(iOS 14.0, *) {
            return self
                .font(.title3.weight(.bold))
                .fixedSize(horizontal: false, vertical: true)
        } else {
            return self
                .font(Font
                    .system(size: UIFontMetrics.default.scaledValue(for: 20))
                    .weight(.bold))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

extension Text {
    public func bodyCentreAligned() -> some View {
        self
            .font(.body)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
}

extension Text {
    public func bodyHeader() -> some View {
        if #available(iOS 14.0, *) {
            return self
                .bold()
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityAddTraits(.isHeader)
        } else {
            return self
                .bold()
                .fixedSize(horizontal: false, vertical: true)
            // no accessibility traits for iOS 13 :-(
        }
    }
}

extension Text {
    public func calloutBold() -> some View {
        self
            .bold()
            .font(.callout)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
    }
}
