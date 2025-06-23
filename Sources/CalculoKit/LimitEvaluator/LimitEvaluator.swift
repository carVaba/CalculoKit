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
            var numerator = lhs
            var denominator = rhs
            for _ in 0..<maxIterations {
                guard let l = evaluate(numerator, approaching: point, variable: variable,
                                       tolerance: tolerance, maxIterations: maxIterations),
                      let r = evaluate(denominator, approaching: point, variable: variable,
                                       tolerance: tolerance, maxIterations: maxIterations) else {
                    return nil
                }
                
                if abs(r) > tolerance { // we need to avoid the denominator gets close to zero
                    return l / r
                }
                
                if abs(l) > tolerance { // if the denominator is close to 0 , we need to avoid the numerator gets close to 0 , to avoid 0/0
                    return nil
                }
                
                numerator = Deriver().evaluate(numerator, withRespectTo: variable)
                denominator = Deriver().evaluate(denominator, withRespectTo: variable)
            }
            return nil

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
