//
//  LimitLhopitalTests.swift
//  CalculoKit
//
//  Created by Carlos Baez Rojas on 22/06/25.
//


import Testing
@testable import CalculoKit

struct LimitLhopitalTests {
    @Test
    func testSinXOverX() {
        let expr = .sin(.x) / .x
        let limit = expr.limit(at: 0)
        #expect(limit != nil)
        #expect(abs(limit! - 1.0) < 1e-4)
    }

    @Test
    func testOneMinusCosOverX() {
        let expr = (1 - .cos(.x)) / .x
        let limit = expr.limit(at: 0)
        #expect(limit != nil)
        // Should be 0
        #expect(abs(limit!) < 1e-4)
    }

    @Test
    func testLnXOverXMinus1() {
        let expr = .ln(.x) / (.x - 1)
        let limit = expr.limit(at: 1.0)
        #expect(limit != nil)
        // Derivative of ln(x) is 1/x; derivative of x-1 is 1
        #expect(abs(limit! - 1.0) < 1e-4)
    }

    @Test
    func testXOverSinX() {
        let expr = .x / .sin(.x)
        let limit = expr.limit(at: 0.0)
        #expect(limit != nil)
        #expect(abs(limit! - 1.0) < 1e-4)
    }

    @Test
    func testFailureWhenDenominatorStaysZero() {
        // f(x) = x / 0 (denominator is constant 0, so L’Hôpital should fail)
        let expr = .x / .constant(0)
        let limit = expr.limit(at: 0)
        #expect(limit == nil)
    }
}
