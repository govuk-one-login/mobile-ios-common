public protocol LoggableError: Error {
    var reason: String? { get }
    var endpoint: String? { get }
    var statusCode: String? { get }
    var hash: String? { get }
}

extension LoggableError {
    public var statusCode: String? { nil }
}
