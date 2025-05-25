
import Testing
@testable import CalculoKit

struct DerivativeCoreTests {
    @Test func testDerivativeOfX() {
        let dx = Deriver().evaluate(.x, withRespectTo: .x)
        #expect(dx == 1)
    }

    @Test func testDerivativeOfConstant() {
        let dx = Deriver().evaluate(5, withRespectTo: .x)
        #expect(dx == 0)
    }

    @Test func testDerivativeOfXSquare() {
        let expr: Expression = .x * .x
        let dx = Deriver().evaluate(expr, withRespectTo: .x)
        #expect(dx == .x + .x)
    }

    @Test func testDerivativeOfXOverX() {
        let expr: Expression = .x / .x
        let dx = Deriver().evaluate(expr, withRespectTo: .x)
        #expect(dx == 0)
    }

    @Test func testDerivativeWithCustomVariable() {
        let a: Variable = "a"
        let expr = Expression.variable(a)
        let da = Deriver().evaluate(expr, withRespectTo: a)
        #expect(da == 1)
    }
}
