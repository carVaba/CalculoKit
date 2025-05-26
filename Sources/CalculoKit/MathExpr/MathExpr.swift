import Foundation

public indirect enum MathExpr: Sendable {
    case constant(Double)
    case variable(String)
    case addition(MathExpr, MathExpr)
    case subtraction(MathExpr, MathExpr)
    case multiplication(MathExpr, MathExpr)
    case division(MathExpr, MathExpr)
    case pow(MathExpr, MathExpr)
    case ln(MathExpr)
    case log(MathExpr, base: Double)
    case exp(MathExpr)
    case sin(MathExpr)
    case cos(MathExpr)
    case tan(MathExpr)
}

// MARK: - Equatable
extension MathExpr: Equatable {
    public static func == (lhs: MathExpr, rhs: MathExpr) -> Bool {
        switch (lhs, rhs) {

        // ── Primitives ──────────────────────────────────────────────
        case (.constant(let a),          .constant(let b)):          return a == b
        case (.variable(let a),          .variable(let b)):          return a == b

        // ── Binary arithmetic ──────────────────────────────────────
        case (.addition(let a1, let a2),       .addition(let b1, let b2)),
             (.subtraction(let a1, let a2),    .subtraction(let b1, let b2)),
             (.multiplication(let a1, let a2), .multiplication(let b1, let b2)),
             (.division(let a1, let a2),       .division(let b1, let b2)),
             (.pow(let a1, let a2), .pow(let b1, let b2)):
            return a1 == b1 && a2 == b2

        // ── Unary trig ─────────────────────────────────────────────
        case (.sin(let a), .sin(let b)),
             (.cos(let a), .cos(let b)),
             (.tan(let a), .tan(let b)):
            return a == b

        // ── Log / Exp ──────────────────────────────────────────────
        case (.ln(let a),  .ln(let b)),
             (.exp(let a), .exp(let b)):
            return a == b

        case (.log(let a, let baseA), .log(let b, let baseB)):
            return baseA == baseB && a == b      // must match base and argument

        // Different cases ≠
        default:
            return false
        }
    }
}

// MARK: - Literal Support
extension MathExpr: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .constant(Double(value))
    }
}

extension MathExpr: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .constant(value)
    }
}
