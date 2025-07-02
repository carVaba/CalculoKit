import Testing
@testable import CalculoKit

struct SimplifyTests {
    @Test func testAdditionOfConstants() {
        let expr: MathExpr = 2 + 3
        #expect(expr.simplified() == 5)
    }

    @Test func testNestedSimplification() {
        let expr: MathExpr = (.x + 0) * 1
        #expect(expr.simplified() == .x)
    }

    @Test func testPowerSimplification() {
        let expr: MathExpr = (.x ** 1) + (.x ** 0)
        #expect(expr.simplified() == .x + 1)
    }

    @Test func testInverseTrigSimplification() {
        let expr: MathExpr = .asin(0)
        #expect(expr.simplified() == 0)
    }
}
