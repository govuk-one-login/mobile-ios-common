import GDSAnalytics

extension ScreenType where Self: RawRepresentable,
                           Self.RawValue == String {
    var name: String {
        rawValue
    }
}

enum MockScreen: String, ScreenType {
    case welcome = "WELCOME_SCREEN"
    case error = "ERROR_SCREEN"
}
