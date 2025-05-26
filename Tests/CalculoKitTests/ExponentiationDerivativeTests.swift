import Foundation
import Testing

@testable import CalculoKit

struct ExponentiationDerivativeTests {

    // d/dx [x^2] = 2 * x
    @Test func testDerivativeOfXPower2() {
        let expr: MathExpr = .x ** 2
        let dx = Deriver().evaluate(expr, withRespectTo: .x)
        #expect(dx == 2 * .x)
    }

    // d/dx [2^x] = 2^x * ln 2
    @Test func testDerivativeOfConstantBase() {
        let expr: MathExpr = 2 ** .x  // 2 is an integer literal → .constant(2)
        let dx = Deriver().evaluate(expr, withRespectTo: .x)
        let expected = (2 ** .x) * MathExpr.constant(log(2.0))
        #expect(dx == expected)
    }

    // d/dx [x^x] = x^x * (ln x + 1)
    @Test func testDerivativeOfXPowerX() {
        let expr: MathExpr = .x ** .x
        let dx = Deriver().evaluate(expr, withRespectTo: .x)
        let expected = (.x ** .x) * (.ln(.x) + 1)
        #expect(dx == expected)
    }
}
