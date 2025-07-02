//
//  Evaluator.swift
//  CalculoKit
//
import Foundation

public struct Evaluator {
    public init() {}

    public func evaluate(_ expr: MathExpr, at value: Double, variable: Variable = .x) -> Double? {
        switch expr {
            case .constant(let c):
                return c
            case .variable(let name):
                return name == variable.rawValue ? value : nil
            case .addition(let lhs, let rhs):
                guard let l = evaluate(lhs, at: value, variable: variable),
                      let r = evaluate(rhs, at: value, variable: variable) else { return nil }
                return l + r
            case .subtraction(let lhs, let rhs):
                guard let l = evaluate(lhs, at: value, variable: variable),
                      let r = evaluate(rhs, at: value, variable: variable) else { return nil }
                return l - r
            case .multiplication(let lhs, let rhs):
                guard let l = evaluate(lhs, at: value, variable: variable),
                      let r = evaluate(rhs, at: value, variable: variable) else { return nil }
                return l * r
            case .division(let lhs, let rhs):
                guard let denom = evaluate(rhs, at: value, variable: variable),
                      denom != 0,
                      let num = evaluate(lhs, at: value, variable: variable) else { return nil }
                return num / denom
            case .sin(let inner):
                guard let v = evaluate(inner, at: value, variable: variable) else { return nil }
                return sin(v)
            case .cos(let inner):
                guard let v = evaluate(inner, at: value, variable: variable) else { return nil }
                return cos(v)
            case .tan(let inner):
                guard let v = evaluate(inner, at: value, variable: variable) else { return nil }
                return tan(v)
            case .asin(let inner):
                guard let v = evaluate(inner, at: value, variable: variable), v >= -1, v <= 1 else { return nil }
                return asin(v)
            case .acos(let inner):
                guard let v = evaluate(inner, at: value, variable: variable), v >= -1, v <= 1 else { return nil }
                return acos(v)
            case .atan(let inner):
                guard let v = evaluate(inner, at: value, variable: variable) else { return nil }
                return atan(v)
            case .ln(let inner):
                guard let v = evaluate(inner, at: value, variable: variable), v > 0 else { return nil }
                return log(v)
            case .log(let inner, let base):
                guard let v = evaluate(inner, at: value, variable: variable), v > 0, base > 0, base != 1 else { return nil }
                return log(v) / log(base)
            case .exp(let inner):
                guard let v = evaluate(inner, at: value, variable: variable) else { return nil }
                return exp(v)
            case .pow(let base, let exp):
                guard let b = evaluate(base, at: value, variable: variable),
                      let e = evaluate(exp, at: value, variable: variable) else { return nil }
                if b < 0 && abs(e - round(e)) > 1e-10 {
                    /*
                     This line means:
                     1. If the base is negative
                     2. And the exponent is not an integer (we check if it’s very close to a rounded value)
                     */
                    return nil
                }
                return pow(b, e)
        }
    }
}
