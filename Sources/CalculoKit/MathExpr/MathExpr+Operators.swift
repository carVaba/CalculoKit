// MARK: - Operator Overloads
//https://nshipster.com/swift-operators/
precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}
infix operator ** : ExponentiationPrecedence

public func + (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    .addition(lhs, rhs).simplified()
}

public func ** (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    .pow(lhs, rhs).simplified()
}

public func - (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    .subtraction(lhs, rhs).simplified()
}

public func * (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    .multiplication(lhs, rhs).simplified()
}

public func / (lhs: MathExpr, rhs: MathExpr) -> MathExpr {
    .division(lhs, rhs).simplified()
}
