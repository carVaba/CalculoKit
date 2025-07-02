// Simplification utilities for MathExpr
// Implements recursive simplification rules like x + 0 -> x, x * 1 -> x
import Foundation

extension MathExpr {
    /// Returns a simplified version of the expression by applying basic
    /// algebraic rules recursively.
    public func simplified() -> MathExpr {
        switch self {
        case .constant, .variable:
            return self

        case .addition(let lhs, let rhs):
            let l = lhs.simplified()
            let r = rhs.simplified()

            if case .constant(let lv) = l, case .constant(let rv) = r {
                return .constant(lv + rv)
            }
            if case .constant(let v) = l, v == 0 { return r }
            if case .constant(let v) = r, v == 0 { return l }
            return .addition(l, r)

        case .subtraction(let lhs, let rhs):
            let l = lhs.simplified()
            let r = rhs.simplified()

            if case .constant(let lv) = l, case .constant(let rv) = r {
                return .constant(lv - rv)
            }
            if case .constant(let v) = r, v == 0 { return l }
            return .subtraction(l, r)

        case .multiplication(let lhs, let rhs):
            let l = lhs.simplified()
            let r = rhs.simplified()

            if case .constant(let lv) = l, case .constant(let rv) = r {
                return .constant(lv * rv)
            }
            if case .constant(let v) = l, v == 0 { return .constant(0) }
            if case .constant(let v) = r, v == 0 { return .constant(0) }
            if case .constant(let v) = l, v == 1 { return r }
            if case .constant(let v) = r, v == 1 { return l }
            return .multiplication(l, r)

        case .division(let lhs, let rhs):
            let l = lhs.simplified()
            let r = rhs.simplified()

            if case .constant(let lv) = l, case .constant(let rv) = r, rv != 0 {
                return .constant(lv / rv)
            }
            if case .constant(let v) = l, v == 0 { return .constant(0) }
            if l == r { return .constant(1) }
            if case .constant(let v) = r, v == 1 { return l }
            return .division(l, r)

        case .pow(let base, let exp):
            let b = base.simplified()
            let e = exp.simplified()

            if case .constant(let bv) = b, case .constant(let ev) = e {
                return .constant(Foundation.pow(bv, ev))
            }
            if case .constant(let ev) = e {
                if ev == 1 { return b }
                if ev == 0 { return .constant(1) }
            }
            if case .constant(let bv) = b {
                if bv == 1 { return .constant(1) }
                if bv == 0 { return .constant(0) }
            }
            return .pow(b, e)

        case .ln(let inner):
            let simplifiedInner = inner.simplified()
            if case .constant(let v) = simplifiedInner, v > 0 {
                return .constant(Foundation.log(v))
            }
            return .ln(simplifiedInner)

        case .log(let inner, let base):
            let simplifiedInner = inner.simplified()
            if case .constant(let v) = simplifiedInner, v > 0 {
                return .constant(Foundation.log(v) / Foundation.log(base))
            }
            return .log(simplifiedInner, base: base)

        case .exp(let inner):
            let simplifiedInner = inner.simplified()
            if case .constant(let v) = simplifiedInner {
                return .constant(Foundation.exp(v))
            }
            return .exp(simplifiedInner)

        case .sin(let inner):
            let simplifiedInner = inner.simplified()
            if case .constant(let v) = simplifiedInner {
                return .constant(Foundation.sin(v))
            }
            return .sin(simplifiedInner)

        case .cos(let inner):
            let simplifiedInner = inner.simplified()
            if case .constant(let v) = simplifiedInner {
                return .constant(Foundation.cos(v))
            }
            return .cos(simplifiedInner)

        case .tan(let inner):
            let simplifiedInner = inner.simplified()
            if case .constant(let v) = simplifiedInner {
                return .constant(Foundation.tan(v))
            }
            return .tan(simplifiedInner)

        case .asin(let inner):
            let simplifiedInner = inner.simplified()
            if case .constant(let v) = simplifiedInner, v >= -1, v <= 1 {
                return .constant(Foundation.asin(v))
            }
            return .asin(simplifiedInner)

        case .acos(let inner):
            let simplifiedInner = inner.simplified()
            if case .constant(let v) = simplifiedInner, v >= -1, v <= 1 {
                return .constant(Foundation.acos(v))
            }
            return .acos(simplifiedInner)

        case .atan(let inner):
            let simplifiedInner = inner.simplified()
            if case .constant(let v) = simplifiedInner {
                return .constant(Foundation.atan(v))
            }
            return .atan(simplifiedInner)
        }
    }
}

