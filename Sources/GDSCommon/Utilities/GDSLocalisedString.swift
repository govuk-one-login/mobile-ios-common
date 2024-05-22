import Foundation

public typealias Attributes = [(String, [NSAttributedString.Key: Any])]

public struct GDSLocalisedString {
    public let stringKey: String
    public let variableKeys: [String]
    let bundle: Bundle
    
    public var value: String {
        NSLocalizedString(key: stringKey,
                          parameters: variableKeys.map { NSLocalizedString(key: $0, bundle: bundle) },
                          bundle: bundle)
    }
    
    public var attributedValue: NSAttributedString? {
        guard let attributes, !attributes.isEmpty else {
            return nil
        }
        return GDSAttributedString(localisedString: value,
                                   attributes: attributes).attributedString
    }
    
    private let attributes: Attributes?
    
    public init(stringKey: String,
                _ variableKeys: String...,
                bundle: Bundle = .main,
                attributes: Attributes) {
        self.stringKey = stringKey
        self.variableKeys = variableKeys
        self.bundle = bundle
        self.attributes = attributes
    }
    
    public init(stringKey: String,
                variableKeys: [String],
                bundle: Bundle = .main,
                attributes: Attributes) {
        self.stringKey = stringKey
        self.variableKeys = variableKeys
        self.bundle = bundle
        self.attributes = attributes
    }
    
    public init(stringKey: String,
                _ variableKeys: String...,
                bundle: Bundle = .main) {
        self.stringKey = stringKey
        self.variableKeys = variableKeys
        self.bundle = bundle
        self.attributes = nil
    }
    
    public init(stringKey: String,
                variableKeys: [String],
                bundle: Bundle = .main) {
        self.stringKey = stringKey
        self.variableKeys = variableKeys
        self.bundle = bundle
        self.attributes = nil
    }
}

extension GDSLocalisedString: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        stringKey = value
        variableKeys = []
        bundle = .main
        self.attributes = nil
    }
    
    public init(stringLiteral value: StringLiteralType,
                attributes: Attributes) {
        stringKey = value
        variableKeys = []
        bundle = .main
        self.attributes = attributes
    }
}

extension GDSLocalisedString: CustomStringConvertible {
    public var description: String {
        value
    }
}

extension GDSLocalisedString: Equatable {
    public static func == (lhs: GDSLocalisedString, rhs: GDSLocalisedString) -> Bool {
        lhs.stringKey == rhs.stringKey &&
        lhs.variableKeys == rhs.variableKeys &&
        lhs.bundle == rhs.bundle &&
        compare(lhs: lhs.attributes, to: rhs.attributes)
    }
    
    private static func compare(lhs: Attributes?, to rhs: Attributes?) -> Bool {
        let isSameLength = lhs?.count == rhs?.count
        let zipped = zip(lhs ?? [], rhs ?? [])
        return zipped
            .allSatisfy { lhsAttribute, rhsAttribute in
                lhsAttribute.0 == rhsAttribute.0
            } && isSameLength
    }
}
