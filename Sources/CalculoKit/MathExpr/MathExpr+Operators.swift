// MARK: - Operator Overloads
//https://nshipster.com/swift-operators/
precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}
infix operator ** : ExponentiationPrecedence

public func + (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    // Identity rule: x + 0 = x
    if case .constant(let v) = lhs, v == 0 { return rhs }
    if case .constant(let v) = rhs, v == 0 { return lhs }
    return .addition(lhs, rhs)
}

public func ** (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    if case .constant(let v) = rhs {
        if v == 1 { return lhs }
        if v == 0 { return 1 }
    }
    return .pow(lhs, rhs)
}

public func - (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    return .subtraction(lhs, rhs)
}

public func * (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    // Zero rule
    if case .constant(let v) = lhs, v == 0 { return 0 }
    if case .constant(let v) = rhs, v == 0 { return 0 }

    // Identity rule
    if case .constant(let v) = lhs, v == 1 { return rhs }
    if case .constant(let v) = rhs, v == 1 { return lhs }

    return .multiplication(lhs, rhs)
}

public func / (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    // Division by 1
    if lhs == rhs { return 1 }
    if case .constant(let v) = rhs, v == 1 { return lhs }
    if case .constant(let v) = lhs, v == 0 { return 0 }
    return .division(lhs, rhs)
}
