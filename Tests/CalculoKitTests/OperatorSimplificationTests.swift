
import Testing
@testable import CalculoKit

struct OperatorSimplificationTests {
    @Test func testAdditionWithZero() {
        let expr1 = .x + 0
        let expr2 = 0 + .x
        #expect(expr1 == .x)
        #expect(expr2 == .x)
    }

    @Test func testMultiplicationWithOne() {
        let expr1 = .x * 1
        let expr2 = 1 * .x
        #expect(expr1 == .x)
        #expect(expr2 == .x)
    }

    @Test func testMultiplicationWithZero() {
        let expr1 = .x * 0
        let expr2 = 0 * .x
        #expect(expr1 == 0)
        #expect(expr2 == 0)
    }

    @Test func testDivisionByOne() {
        let expr = .x / 1
        #expect(expr == .x)
    }

    @Test func testExponentiationRules() {
        let expr1 = .x ** 1
        let expr2 = .x ** 0
        #expect(expr1 == .x)
        #expect(expr2 == 1)
    }
}
