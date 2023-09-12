public struct ErrorScreenView<Screen: NamedScreen>: ScreenViewProtocol, LoggableError {
    public let screen: Screen
    public let title: String
    public let reason: String?
    public let endpoint: String?
    public let statusCode: String?
    public let hash: String?
    
    public var parameters: [String: String] {
        [
            ScreenParameter.title.rawValue: title,
            ScreenParameter.reason.rawValue: reason,
            ScreenParameter.endpoint.rawValue: endpoint,
            ScreenParameter.hash.rawValue: hash,
            ScreenParameter.status.rawValue: statusCode
        ]
        .compactMapValues { $0 }
        .mapValues(\.formattedAsParameter)
    }
    
    public init(screen: Screen,
                titleKey: String,
                reason: String? = nil,
                endpoint: String? = nil,
                statusCode: String? = nil,
                hash: String? = nil) {
        self.screen = screen
        self.title = titleKey.englishString()
        
        self.reason = reason
        self.endpoint = endpoint
        self.statusCode = statusCode
        self.hash = hash
    }
    
    public init(screen: Screen,
                titleKey: String,
                error: LoggableError) {
        self.screen = screen
        title = titleKey.englishString()
        
        reason = error.reason
        endpoint = error.endpoint
        statusCode = error.statusCode
        hash = error.hash
    }
}
