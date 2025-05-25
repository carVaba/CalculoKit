import Foundation
import Testing

@testable import CalculoKit

struct TrigAndLogDerivativeTests {
    @Test func testDerivativeOfSinX() {
        let dx = Deriver().evaluate(.sin(.x), withRespectTo: .x)
        #expect(dx == .cos(.x))
    }

    @Test func testDerivativeOfCosX() {
        let dx = Deriver().evaluate(.cos(.x), withRespectTo: .x)
        #expect(dx == .constant(-1) * .sin(.x))
    }

    @Test func testDerivativeOfTanX() {
        let dx = Deriver().evaluate(.tan(.x), withRespectTo: .x)
        let expected = (1 + .tan(.x) * .tan(.x))
        #expect(dx == expected)
    }

    @Test func testDerivativeOfLnX() {
        let dx = Deriver().evaluate(.ln(.x), withRespectTo: .x)
        #expect(dx == 1 / .x)
    }

    @Test func testDerivativeOfExpX() {
        let dx = Deriver().evaluate(.exp(.x), withRespectTo: .x)
        #expect(dx == .exp(.x))
    }

    @Test func testDerivativeOfLogBase2() {
        let dx = Deriver().evaluate(.log(.x, base: 2), withRespectTo: .x)
        let ln2 = log(2.0)
        #expect(dx == 1 / (.x * Expression.constant(ln2)))
    }
}
