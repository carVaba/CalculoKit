import Testing

@testable import CalculoKit

struct ExpressionTests {

    // MARK: - Literal & Variable Tests

    @Test func testConstantLiteral() {
        let expr: Expression = 5
        switch expr {
        case .constant(let value):
            #expect(value == 5.0)
        default:
            Issue.record("Expected .constant")
        }
    }

    @Test func testVariableX() {
        let expr = Expression.x
        switch expr {
        case .variable(let name):
            #expect(name == "x")
        default:
            Issue.record("Expected .variable")
        }
    }

    // MARK: - Operator Simplification Tests

    @Test func testAdditionWithZero() {
        let expr1 = .x + 0
        let expr2 = 0 + .x
        #expect(expr1 == .x)
        #expect(expr2 == .x)
    }

    @Test func testMultiplicationWithOne() {
        let expr1 = .x * 1
        let expr2 = 1 * .x
        #expect(expr1 == .x)
        #expect(expr2 == .x)
    }

    @Test func testMultiplicationWithZero() {
        let expr1 = .x * 0
        let expr2 = 0 * .x
        #expect(expr1 == 0)
        #expect(expr2 == 0)
    }

    @Test func testDivisionByOne() {
        let expr = .x / 1
        #expect(expr == .x)
    }

    // MARK: - Derivative Tests

    @Test func testDerivativeOfSinX() {
        let expr: Expression = .sin(.x)
        let dx = Deriver().evaluate(expr, withRespectTo: .x)

        switch dx {
        case .cos(.variable(let name)):
            #expect(name == "x")
        default:
            Issue.record("Expected simplified cos(x)")
        }
    }

    @Test func testDerivativeOfXOverX() {
        let expr: Expression = .x / .x
        let dx = Deriver().evaluate(expr, withRespectTo: .x)

        switch dx {
        case .constant(let value):
            #expect(value == 0.0)
        default:
            Issue.record("Expected derivative to simplify to 0")
        }
    }

    @Test func testDerivativeWithCustomVariable() {
        let a: Variable = "a"
        let expr = Expression.variable(a)
        let da = Deriver().evaluate(expr, withRespectTo: a)

        switch da {
        case .constant(let value):
            #expect(value == 1.0)
        default:
            Issue.record("Expected derivative with respect to same variable to be 1")
        }
    }

    @Test func testDerivativeOfLnX() {
        let dx = Deriver().evaluate(.ln(.x), withRespectTo: .x)
        switch dx {
        case .division(.constant(let num), .variable(let den)):
            #expect(num == 1 && den == "x")
        default: Issue.record("Expected 1 / x")
        }
    }

    @Test func testDerivativeOfExpX() {
        let dx = Deriver().evaluate(.exp(.x), withRespectTo: .x)
        // Should simplify to exp(x)
        switch dx {
        case .exp(.variable(let name)):
            #expect(name == "x")
        default: Issue.record("Expected exp(x)")
        }
    }
}

