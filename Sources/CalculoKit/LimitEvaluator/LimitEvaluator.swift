import Foundation

public struct LimitEvaluator {
    public init() {}

    public func evaluate(_ expression: MathExpr, approaching point: Double, variable: Variable = .x)
        -> Double?
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
            guard let l = evaluate(lhs, approaching: point, variable: variable),
                let r = evaluate(rhs, approaching: point, variable: variable), r != 0
            else { return nil }
            return l / r

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
