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
            case .ln(let inner):
                guard let v = evaluate(inner, at: value, variable: variable), v > 0 else { return nil }
                return log(v)
            case .log(let inner, let base):
                guard let v = evaluate(inner, at: value, variable: variable), v > 0 else { return nil }
                return log(v) / log(base)
            case .exp(let inner):
                guard let v = evaluate(inner, at: value, variable: variable) else { return nil }
                return exp(v)
            case .pow(let base, let exp):
                guard let b = evaluate(base, at: value, variable: variable),
                      let e = evaluate(exp, at: value, variable: variable) else { return nil }
                return pow(b, e)
        }
    }
}
