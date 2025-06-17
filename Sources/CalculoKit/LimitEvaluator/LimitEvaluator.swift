import Foundation

public struct LimitEvaluator {
    public init() {}

    public func evaluate(
        _ expression: MathExpr,
        approaching point: Double,
        variable: Variable = .x,
        tolerance: Double = 1e-8,
        maxIterations: Int = 5
    ) -> Double?
    {
        switch expression {
        case .constant(let value):
            return value

        case .variable(let name):
            return name == variable.rawValue ? point : nil

        case .addition(let lhs, let rhs):
            guard let l = evaluate(lhs, approaching: point, variable: variable),
                let r = evaluate(rhs, approaching: point, variable: variable)
            else { return nil }
            return l + r

        case .subtraction(let lhs, let rhs):
            guard let l = evaluate(lhs, approaching: point, variable: variable),
                let r = evaluate(rhs, approaching: point, variable: variable)
            else { return nil }
            return l - r

        case .multiplication(let lhs, let rhs):
            guard let l = evaluate(lhs, approaching: point, variable: variable),
                let r = evaluate(rhs, approaching: point, variable: variable)
            else { return nil }
            return l * r

        case .division(let lhs, let rhs):
<<<<<<< ours
            guard let l = evaluate(lhs, approaching: point, variable: variable),
                let r = evaluate(rhs, approaching: point, variable: variable) else {
                return nil
            }
            if r != 0 {
                return l / r
            } else if l == 0 {
                // Apply a single step of l'Hopital's rule
                let dLhs = Deriver().evaluate(lhs, withRespectTo: variable)
                let dRhs = Deriver().evaluate(rhs, withRespectTo: variable)
                return evaluate(dLhs / dRhs, approaching: point, variable: variable)
            } else {
                return nil
            }
=======
            var numerator = lhs
            var denominator = rhs
            for _ in 0..<maxIterations {
                guard let l = evaluate(numerator, approaching: point, variable: variable,
                                       tolerance: tolerance, maxIterations: maxIterations),
                      let r = evaluate(denominator, approaching: point, variable: variable,
                                       tolerance: tolerance, maxIterations: maxIterations) else {
                    return nil
                }

                if abs(r) > tolerance {
                    return l / r
                }

                if abs(l) > tolerance {
                    return nil
                }

                numerator = Deriver().evaluate(numerator, withRespectTo: variable)
                denominator = Deriver().evaluate(denominator, withRespectTo: variable)
            }
            return nil
>>>>>>> theirs

        case .sin(let inner):
            guard let v = evaluate(inner, approaching: point, variable: variable) else {
                return nil
            }
            return sin(v)

        case .cos(let inner):
            guard let v = evaluate(inner, approaching: point, variable: variable) else {
                return nil
            }
            return cos(v)

        case .tan(let inner):
            guard let v = evaluate(inner, approaching: point, variable: variable) else {
                return nil
            }
            return tan(v)

        case .ln(let inner):
            guard let v = evaluate(inner, approaching: point, variable: variable), v > 0 else {
                return nil
            }
            return log(v)

        case .log(let inner, let base):
            guard let v = evaluate(inner, approaching: point, variable: variable), v > 0 else {
                return nil
            }
            return log(v) / log(base)

        case .exp(let inner):
            guard let v = evaluate(inner, approaching: point, variable: variable) else {
                return nil
            }
            return exp(v)

        case .pow(let base, let exp):
            guard let b = evaluate(base, approaching: point, variable: variable),
                let e = evaluate(exp, approaching: point, variable: variable)
            else { return nil }
            return pow(b, e)
        }
    }
}
