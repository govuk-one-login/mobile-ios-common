import SwiftUI

public struct Primary: ButtonStyle {
    // TODO: DCMAW-5316 need to fix focus state for full keyboard access
    public var isFocused: Bool = false
    @State private var backgroundColor = Color(.gdsGreen)
    @Environment(\.isEnabled) public var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .multilineTextAlignment(.center)
            .padding(.horizontal, 5)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(isFocused ?
                        Color(.gdsYellow) : Color(.gdsGreen).opacity(isEnabled ?
                                                                     1 : 0.5))
            .foregroundColor(isEnabled ?
                             Color.white.opacity(configuration.isPressed ?
                                                 0.75 : 1)
                             : Color.primary.opacity(isEnabled ?
                                                     1 : 0.6)
            )
            .font(Font.body.weight(.semibold))
            .cornerRadius(16)
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .fixedSize(horizontal: false, vertical: true)
    }
}

public struct Secondary: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, minHeight: 44)
            .foregroundColor(Color(.accent)
                .opacity(configuration.isPressed ? 0.75 : 1)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .fixedSize(horizontal: false, vertical: true)
    }
}

public struct Support: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .multilineTextAlignment(.leading)
            .frame(minHeight: 24, alignment: .leading)
            .foregroundColor(Color(.accent)
                .opacity(configuration.isPressed ? 0.75 : 1)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .fixedSize(horizontal: false, vertical: true)
    }
}
    
extension ButtonStyle where Self == Primary {
    public static var primary: Self { Self() }
}

extension ButtonStyle where Self == Secondary {
    public static var secondary: Self { Self() }
}

extension ButtonStyle where Self == Support {
    public static var support: Self { Self() }
}
