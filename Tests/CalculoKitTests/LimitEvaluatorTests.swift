import Testing

@testable import CalculoKit

struct LimitEvaluatorTests {
    @Test func testLimitOfConstant() {
        let result = MathExpr.constant(5).limit(at: 3)
        #expect(result == 5)
    }

    @Test func testLimitOfIdentity() {
        let result = MathExpr.variable(.x).limit(at: 2)
        #expect(result == 2)
    }

    @Test func testLimitOfXSquare() {
        let expr = MathExpr.x ** 2
        let result = expr.limit(at: 3)
        #expect(result == 9)
    }

    @Test func testLimitOfSinOverX() {
        let expr = MathExpr.sin(.x) / .x
        let result = expr.limit(at: 0)
        #expect(abs((result ?? 0) - 1) < 0.01)
    }

    @Test func testLimitOfLogWithInvalidBase() {
        // Base is 1
        let expr1 = MathExpr.log(.x, base: 1)
        #expect(expr1.limit(at: 10) == nil)

        // Base is <= 0
        let expr2 = MathExpr.log(.x, base: 0)
        #expect(expr2.limit(at: 10) == nil)

        let expr3 = MathExpr.log(.x, base: -2)
        #expect(expr3.limit(at: 10) == nil)

        // Valid base
        let expr4 = MathExpr.log(.x, base: 10)
        let result4 = expr4.limit(at: 10)
        #expect(result4 != nil)
        #expect(abs((result4 ?? 0) - 1) < 0.01)
    }
}
