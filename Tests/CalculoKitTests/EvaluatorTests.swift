//
//  EvaluatorTests.swift
//  CalculoKit
//
import Testing
@testable import CalculoKit

struct EvaluatorTests {
    @Test func testConstant() {
        #expect(Evaluator().evaluate(5, at: 0) == 5)
    }

    @Test func testVariable() {
        #expect(Evaluator().evaluate(.x, at: 3) == 3)
    }

    @Test func testPolynomial() {
        let expr = .x ** 2 + 2 * .x + 1
        #expect(Evaluator().evaluate(expr, at: 2) == 9)
    }

    @Test func testTrig() {
        let expr = MathExpr.sin(.x)
        let res = Evaluator().evaluate(expr, at: Double.pi/2)
        #expect(abs((res ?? 0) - 1) < 1e-6)
    }

    @Test func testDivisionByZero() {
        let expr = 1 / .x
        #expect(Evaluator().evaluate(expr, at: 0) == nil)
    }
}
