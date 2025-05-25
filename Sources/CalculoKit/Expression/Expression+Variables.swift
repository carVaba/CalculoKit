extension Expression {
    public static func variable(_ v: Variable) -> Expression {
        .variable(v.rawValue)
    }
}

// MARK: - Common Variables
extension Expression {
    // swiftlint:disable identifier_name
    public static let x = Expression.variable("x")
    public static let y = Expression.variable("y")
    // swiftlint:enable identifier_name
}
