public enum ErrorScreenImage {
    case error
    case warning
    case appUpdate
    
    var icon: String {
        switch self {
        case .error, .warning:
            "exclamationmark.circle"
        case .appUpdate:
            "exclamationmark.arrow.trianglehead.counterclockwise.rotate.90"
        }
    }
    
    var voiceoverPrefix: String {
        switch self {
        case .error, .appUpdate:
            NSLocalizedString(key: "GDSCommonVoiceOverErrorPrefix", bundle: .module)
        case .warning:
            NSLocalizedString(key: "GDSCommonVoiceOverWarningPrefix", bundle: .module)
        }
    }
}
