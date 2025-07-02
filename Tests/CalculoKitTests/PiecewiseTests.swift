import Testing
@testable import CalculoKit

struct PiecewiseTests {
    @Test func testEvaluator() {
        let expr = piecewise {
            when(.x < 0, then: -1)
            when(.x == 0, then: 0)
            when(.x > 0, then: 1)
        }
        let eval = Evaluator()
        #expect(eval.evaluate(expr, at: -2) == -1)
        #expect(eval.evaluate(expr, at: 0) == 0)
        #expect(eval.evaluate(expr, at: 2) == 1)
    }

    @Test func testDerivative() {
        let expr = piecewise {
            when(.x < 0, then: -1 * .x)
            when(.x >= 0, then: .x)
        }
        let dx = expr.derivate()
        let expected = piecewise {
            when(.x < 0, then: -1)
            when(.x >= 0, then: 1)
        }
        #expect(dx == expected)
    }

    @Test func testLimit() {
        let expr = piecewise {
            when(.x < 1, then: .x ** 2)
            when(.x >= 1, then: .x)
        }
        let result = expr.limit(at: 1)
        #expect(result == 1)
    }
}
