import GDSAnalytics

extension NamedScreen where Self: RawRepresentable,
                            Self.RawValue == String {
    var name: String {
        rawValue
    }
}

enum MockScreen: String, NamedScreen {
    case welcome = "WELCOME_SCREEN"
    case error = "ERROR_SCREEN"
}
