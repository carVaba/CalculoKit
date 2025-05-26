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
}
