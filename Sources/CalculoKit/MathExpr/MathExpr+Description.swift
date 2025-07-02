extension MathExpr: CustomStringConvertible {
    public var description: String {
        switch self {
            case .constant(let value):
                return String(format: "%g", value)
                
            case .variable(let name):
                return name
                
            case .addition(let lhs, let rhs):
                return "(\(lhs) + \(rhs))"
                
            case .subtraction(let lhs, let rhs):
                return "(\(lhs) - \(rhs))"
                
            case .multiplication(let lhs, let rhs):
                return "(\(lhs) * \(rhs))"
                
            case .division(let lhs, let rhs):
                return "(\(lhs) / \(rhs))"
                
            case .pow(let base, let exponent):
                return "(\(base) ^ \(exponent))"
                
            case .sin(let expr):
                return "sin(\(expr))"
                
            case .cos(let expr):
                return "cos(\(expr))"
                
            case .tan(let expr):
                return "tan(\(expr))"
                
            case .asin(let expr):
                return "asin(\(expr))"
                
            case .acos(let expr):
                return "acos(\(expr))"
                
            case .atan(let expr):
                return "atan(\(expr))"
                
            case .ln(let expr):
                return "ln(\(expr))"
                
            case .log(let expr, let base):
                return "log_\(base)(\(expr))"
                
            case .exp(let expr):
                return "exp(\(expr))"
                
            case .piecewise(let branches):
                return branches.map { item in
                    return "\(item.condition), \(item.expression.description)\n"
                }.joined(separator: ";")
        }
    }
}
