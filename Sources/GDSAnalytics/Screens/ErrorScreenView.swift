public struct ErrorScreenView<Screen: ScreenType>: ScreenViewProtocol, LoggableError {
    public let id: String?
    public let title: String
    public let screen: Screen
    public let reason: String?
    public let endpoint: String?
    public let statusCode: String?
    public let hash: String?
    
    public var parameters: [String: String] {
        [
            ScreenParameter.title.rawValue: title,
            ScreenParameter.id.rawValue: id,
            ScreenParameter.reason.rawValue: reason,
            ScreenParameter.endpoint.rawValue: endpoint,
            ScreenParameter.hash.rawValue: hash,
            ScreenParameter.status.rawValue: statusCode
        ]
        .compactMapValues(\.?.formattedAsParameter)
    }
    
    public init(id: String? = nil,
                screen: Screen,
                titleKey: String,
                reason: String? = nil,
                endpoint: String? = nil,
                statusCode: String? = nil,
                hash: String? = nil) {
        self.screen = screen
        self.title = titleKey.englishString()
        self.id = id
        self.reason = reason
        self.endpoint = endpoint
        self.statusCode = statusCode
        self.hash = hash
    }
    
    public init(id: String? = nil,
                screen: Screen,
                titleKey: String,
                error: LoggableError) {
       
        self.id = id
        self.screen = screen
        title = titleKey.englishString()
        reason = error.reason
        endpoint = error.endpoint
        statusCode = error.statusCode
        hash = error.hash
    }
}
