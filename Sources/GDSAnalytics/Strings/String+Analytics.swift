import Foundation

extension String {
    var formattedAsParameter: String {
        prefix(100)
            .lowercased()
    }
    
    func englishString(_ variableKeys: [String] = [], bundle: Bundle = .main) -> String {
        let tableName = "en.lproj/Localizable"
        
        return String(format: NSLocalizedString(key: self, tableName: tableName, bundle: bundle),
                      arguments: variableKeys.map { NSLocalizedString(key: $0, tableName: tableName, bundle: bundle) })
    }
    
}

// This is a wrapper function around NSLocalizedString that provides a default argument for the comment parameter to simplify the call site.
func NSLocalizedString(key: String, tableName: String? = nil, bundle: Bundle, value: String = "", comment: String = "") -> String {
    NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
}
