import Foundation

public struct Deriver {
    public init() {}

    public func evaluate(_ expression: MathExpr, withRespectTo variable: Variable = .x)
        -> MathExpr
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
                return deriveExponentiation(base, exponent, variable: variable)
            case .sin(let inner):
                return .cos(inner) * evaluate(inner, withRespectTo: variable)
                
            case .cos(let inner):
                return .constant(-1) * .sin(inner) * evaluate(inner, withRespectTo: variable)
                
            case .tan(let inner):
                return (1 + .tan(inner) * .tan(inner)) * evaluate(inner, withRespectTo: variable)
                
            case .asin(let inner):
                let innerPrime = evaluate(inner, withRespectTo: variable)
                return innerPrime / ((1 - inner * inner) ** 0.5)
                
            case .acos(let inner):
                let innerPrime = evaluate(inner, withRespectTo: variable)
                return .constant(-1) * innerPrime / ((1 - inner * inner) ** 0.5)
                
            case .atan(let inner):
                let innerPrime = evaluate(inner, withRespectTo: variable)
                return innerPrime / (1 + inner * inner)
            case .ln(let inner):
                return evaluate(inner, withRespectTo: variable) / inner
            case .exp(let inner):
                return .exp(inner) * evaluate(inner, withRespectTo: variable)
            case .log(let inner, let base):
                let lnBase = MathExpr.constant(log(base))
                let numerator = evaluate(inner, withRespectTo: variable)
                let denominator = inner * lnBase
                return numerator / denominator
            case .piecewise(let branches):
                let newBranches = branches.map { item in
                    let expression = evaluate(item.expression, withRespectTo: variable)
                    return PieceWiseItem(condition: item.condition,
                                         expression: expression)
                }
                return .piecewise(newBranches)
        }
    }

    // MARK: - Private helpers
    private func deriveExponentiation(
        _ base: MathExpr,
        _ exponent: MathExpr,
        variable: Variable
    ) -> MathExpr {

        // Case 1: f(x)^n  (constant exponent)
        if case .constant(let n) = exponent {
            return .constant(n) * (base ** .constant(n - 1))
                * evaluate(base, withRespectTo: variable)
        }

        // Case 2: a^g(x)  (constant base)
        if case .constant(let a) = base {
            return (base ** exponent) * .constant(log(a))
                * evaluate(exponent, withRespectTo: variable)
        }

        // Case 3: general f(x)^g(x)
        let prime_f = evaluate(base, withRespectTo: variable)
        let prime_g = evaluate(exponent, withRespectTo: variable)

        let term1 = prime_g * .ln(base)
        let term2 = exponent * prime_f / base
        return (base ** exponent) * (term1 + term2)
    }
}
