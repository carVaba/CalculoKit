extension MathExpr {
    public static func variable(_ v: Variable) -> MathExpr {
        .variable(v.rawValue)
    }
}

// MARK: - Common Variables
extension MathExpr {
    // swiftlint:disable identifier_name
    public static let x = MathExpr.variable("x")
    public static let y = MathExpr.variable("y")
    // swiftlint:enable identifier_name
}
