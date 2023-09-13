import Foundation

public struct GDSLocalisedString {
    public let stringKey: String
    public let variableKeys: [String]
    let bundle: Bundle
    
    public var value: String {
        NSLocalizedString(key: stringKey,
                          parameters: variableKeys.map { NSLocalizedString(key: $0, bundle: bundle) },
                          bundle: bundle)
    }
    
    public init(stringKey: String,
                _ variableKeys: String...,
                bundle: Bundle = .main) {
        self.stringKey = stringKey
        self.variableKeys = variableKeys
        self.bundle = bundle
    }
    
    public init(stringKey: String,
                variableKeys: [String],
                bundle: Bundle = .main) {
        self.stringKey = stringKey
        self.variableKeys = variableKeys
        self.bundle = bundle
    }
}

extension GDSLocalisedString: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        stringKey = value
        variableKeys = []
        bundle = .main
    }
}

extension GDSLocalisedString: CustomStringConvertible {
    public var description: String {
        value
    }
}
