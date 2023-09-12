import Foundation

// This is a wrapper function around NSLocalizedString that provides a default argument for the comment parameter to simplify the call site.
public func NSLocalizedString(key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String = "") -> String {
    NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
}

// This is a wrapper function around NSLocalizedString that provides a default argument for the comment parameter to simplify the call site.
public func NSLocalizedString(key: String, _ parameters: CVarArg..., bundle: Bundle = .main) -> String {
    String(format: NSLocalizedString(key: key, tableName: nil, bundle: bundle),
           arguments: parameters)
}

func NSLocalizedString(key: String, parameters: [CVarArg], bundle: Bundle = .main) -> String {
    String(format: NSLocalizedString(key: key, tableName: nil, bundle: bundle),
           arguments: parameters)
}
