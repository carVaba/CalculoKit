import Testing
@testable import CalculoKit

struct ConditionTests {
    @Test func testIsSatisfiedMatchingVariable() {
        // Less than
        #expect(Condition.lessThan(.x, 5.0).isSatisfied(at: 4.0, for: .x) == true)
        #expect(Condition.lessThan(.x, 5.0).isSatisfied(at: 5.0, for: .x) == false)

        // Less than or equal
        #expect(Condition.lessThanOrEqual(.x, 5.0).isSatisfied(at: 5.0, for: .x) == true)
        #expect(Condition.lessThanOrEqual(.x, 5.0).isSatisfied(at: 6.0, for: .x) == false)

        // Equal to
        #expect(Condition.equalTo(.x, 5.0).isSatisfied(at: 5.0, for: .x) == true)
        #expect(Condition.equalTo(.x, 5.0).isSatisfied(at: 5.000000001, for: .x) == true)
        #expect(Condition.equalTo(.x, 5.0).isSatisfied(at: 5.1, for: .x) == false)

        // Greater than
        #expect(Condition.greaterThan(.x, 5.0).isSatisfied(at: 6.0, for: .x) == true)
        #expect(Condition.greaterThan(.x, 5.0).isSatisfied(at: 5.0, for: .x) == false)

        // Greater than or equal
        #expect(Condition.greaterThanOrEqual(.x, 5.0).isSatisfied(at: 5.0, for: .x) == true)
        #expect(Condition.greaterThanOrEqual(.x, 5.0).isSatisfied(at: 4.0, for: .x) == false)
    }

    @Test func testIsSatisfiedMismatchedVariable() {
        // Create conditions for .x, but evaluate for .y
        // All should return false regardless of the value

        let value = 5.0
        let target = 5.0

        #expect(Condition.lessThan(.x, target).isSatisfied(at: 2.0, for: .y) == false)
        #expect(Condition.lessThanOrEqual(.x, target).isSatisfied(at: 5.0, for: .y) == false)
        #expect(Condition.equalTo(.x, target).isSatisfied(at: 5.0, for: .y) == false)
        #expect(Condition.greaterThan(.x, target).isSatisfied(at: 8.0, for: .y) == false)
        #expect(Condition.greaterThanOrEqual(.x, target).isSatisfied(at: 5.0, for: .y) == false)
    }

    @Test func testHelperFunctions() {
        // Verify the operator overloads create the correct Condition
        #expect((Variable.x < 5.0) == Condition.lessThan(.x, 5.0))
        #expect((Variable.x <= 5.0) == Condition.lessThanOrEqual(.x, 5.0))
        #expect((Variable.x == 5.0) == Condition.equalTo(.x, 5.0))
        #expect((Variable.x > 5.0) == Condition.greaterThan(.x, 5.0))
        #expect((Variable.x >= 5.0) == Condition.greaterThanOrEqual(.x, 5.0))
    }
}
