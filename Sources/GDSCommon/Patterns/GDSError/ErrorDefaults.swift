import UIKit

public struct ErrorDefaults {
    var image: String
    var voiceOverPrefix: String
    
    public init(
        image: String = "exclamationmark.circle",
        voiceOverPrefix: String? = nil
    ) {
        self.image = image
        self.voiceOverPrefix = voiceOverPrefix ?? NSLocalizedString(key: "GDSCommonVoiceOverErrorPrefix", bundle: .module)
    }
}
