import Foundation

public indirect enum Expression: Sendable {
    case constant(Double)
    case variable(String)
    case addition(Expression, Expression)
    case subtraction(Expression, Expression)
    case multiplication(Expression, Expression)
    case division(Expression, Expression)
    case ln(Expression)
    case log(Expression, Double)
    case exp(Expression)
    case sin(Expression)
    case cos(Expression)
    case tan(Expression)
}

// MARK: - Equatable
extension Expression: Equatable {
    public static func == (lhs: Expression, rhs: Expression) -> Bool {
        switch (lhs, rhs) {
        case (.constant(let a), .constant(let b)):
            return a == b

        case (.variable(let a), .variable(let b)):
            return a == b

        case (.addition(let a1, let a2), .addition(let b1, let b2)),
            (.subtraction(let a1, let a2), .subtraction(let b1, let b2)),
            (.multiplication(let a1, let a2), .multiplication(let b1, let b2)),
            (.division(let a1, let a2), .division(let b1, let b2)):
            return a1 == b1 && a2 == b2

        case (.sin(let a), .sin(let b)),
            (.cos(let a), .cos(let b)),
            (.tan(let a), .tan(let b)):
            return a == b

        // If you already added .exponentiation or .piecewise, compare them here too.

        default:
            return false  // different cases ≠
        }
    }
}

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

// MARK: - Operator Overloads

public func + (lhs: Expression, rhs: Expression) -> Expression {
    // Identity rule: x + 0 = x
    if case .constant(let v) = lhs, v == 0 { return rhs }
    if case .constant(let v) = rhs, v == 0 { return lhs }
    return .addition(lhs, rhs)
}

public func - (lhs: Expression, rhs: Expression) -> Expression {
    return .subtraction(lhs, rhs)
}

public func * (lhs: Expression, rhs: Expression) -> Expression {
    // Zero rule
    if case .constant(let v) = lhs, v == 0 { return 0 }
    if case .constant(let v) = rhs, v == 0 { return 0 }

    // Identity rule
    if case .constant(let v) = lhs, v == 1 { return rhs }
    if case .constant(let v) = rhs, v == 1 { return lhs }

    return .multiplication(lhs, rhs)
}

public func / (lhs: Expression, rhs: Expression) -> Expression {
    // Division by 1
    if lhs == rhs { return 1 }
    if case .constant(let v) = rhs, v == 1 { return lhs }
    if case .constant(let v) = lhs, v == 0 { return 0 }
    return .division(lhs, rhs)
}

// MARK: - Literal Support

extension Expression: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .constant(Double(value))
    }
}

extension Expression: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .constant(value)
    }
}
