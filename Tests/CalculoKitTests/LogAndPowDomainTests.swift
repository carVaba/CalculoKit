//
//  LogAndPowDomainTests.swift
//  CalculoKit
//
import Testing
@testable import CalculoKit

struct LogAndPowDomainTests {
    
    @Test func testLogValid() {
        let expr = MathExpr.log(100, base: 10)
        let result = Evaluator().evaluate(expr, at: 0, variable: .x)
        #expect(abs(result! - 2.0) < 1e-6)
    }

    @Test func testLogOfNegativeBase() {
        let expr = MathExpr.log(-10, base: 10)
        let result = Evaluator().evaluate(expr, at: 0, variable: .x)
        #expect(result == nil)
    }

    @Test func testLogWithInvalidBase() {
        let expr = MathExpr.log(10, base: 1) // base cannot be 1
        let result = Evaluator().evaluate(expr, at: 0, variable: .x)
        #expect(result == nil)
    }

    @Test func testLogWithNegativeBase() {
        let expr = MathExpr.log(10, base: -2)
        let result = Evaluator().evaluate(expr, at: 0, variable: .x)
        #expect(result == nil)
    }

    @Test func testPowWithIntegerExponent() {
        let expr = MathExpr.pow(-2, 3)
        let result = Evaluator().evaluate(expr, at: 0, variable: .x)
        #expect(result == -8)
    }

    @Test func testPowWithNonIntegerExponent() {
        let expr = MathExpr.pow(-2, 0.5)
        let result = Evaluator().evaluate(expr, at: 0, variable: .x)
        #expect(result == nil)
    }

    @Test func testPowWithPositiveBaseAndFractionalExponent() {
        let expr = MathExpr.pow(4, 0.5)
        let result = Evaluator().evaluate(expr, at: 0, variable: .x)
        #expect(abs(result! - 2.0) < 1e-6)
    }
}
