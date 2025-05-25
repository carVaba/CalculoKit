import Foundation

public struct Deriver {
    public init() {}

    public func evaluate(_ expression: Expression, withRespectTo variable: Variable = .x)
        -> Expression
    {
        switch expression {
        case .constant:
            return 0

        case .variable(let name):
            return name == variable.rawValue ? 1 : 0

        case .addition(let lhs, let rhs):
            return evaluate(lhs, withRespectTo: variable) + evaluate(rhs, withRespectTo: variable)

        case .subtraction(let lhs, let rhs):
            return evaluate(lhs, withRespectTo: variable) - evaluate(rhs, withRespectTo: variable)

        case .multiplication(let u, let v):
            let du = evaluate(u, withRespectTo: variable)
            let dv = evaluate(v, withRespectTo: variable)
            return du * v + u * dv

        case .division(let u, let v):
            let du = evaluate(u, withRespectTo: variable)
            let dv = evaluate(v, withRespectTo: variable)
            let numerator = du * v - u * dv
            let denominator = v * v
            return numerator / denominator

        case .pow(let base, let exponent):
            if case .constant(let n) = exponent {
                // d/dx [f^n] = n * f^(n - 1) * f'
                let powerMinusOne = Expression.constant(n - 1)
                return .constant(n) * (base ** powerMinusOne)
                    * evaluate(base, withRespectTo: variable)
            } else {
                // General case (f^g) not supported yet
                return .constant(0)  // or: .error("Unsupported exponent")
            }
        case .sin(let inner):
            return .cos(inner) * evaluate(inner, withRespectTo: variable)

        case .cos(let inner):
            return .constant(-1) * .sin(inner) * evaluate(inner, withRespectTo: variable)

        case .tan(let inner):
            return (1 + .tan(inner) * .tan(inner)) * evaluate(inner, withRespectTo: variable)
        case .ln(let inner):
            return evaluate(inner, withRespectTo: variable) / inner
        case .exp(let inner):
            return .exp(inner) * evaluate(inner, withRespectTo: variable)
        case .log(let inner, let base):
            let lnBase = Expression.constant(log(base))
            let numerator = evaluate(inner, withRespectTo: variable)
            let denominator = inner * lnBase
            return numerator / denominator
        }
    }
}
