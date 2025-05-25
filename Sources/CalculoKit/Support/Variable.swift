public struct Variable: RawRepresentable, ExpressibleByStringLiteral, Equatable, Sendable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        self.rawValue = value
    }

    //·swiftlint:disable·identifier_name¬
    public static let x: Variable = "x"
    public static let y: Variable = "y"
    public static let z: Variable = "z"
    public static let t: Variable = "t"
    // swiftlint:enable identifier_name
}
