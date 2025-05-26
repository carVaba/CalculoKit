
import Testing
@testable import CalculoKit

struct LiteralsTests {
    @Test func testConstantLiteral() {
        let expr: MathExpr = 5
        switch expr {
        case .constant(let value):
            #expect(value == 5.0)
        default:
            Issue.record("Expected .constant")
        }
    }

    @Test func testVariableX() {
        let expr = MathExpr.x
        switch expr {
        case .variable(let name):
            #expect(name == "x")
        default:
            Issue.record("Expected .variable")
        }
    }

    @Test func testCustomNamedVariable() {
        let theta: Variable = "theta"
        let expr = MathExpr.variable(theta)
        switch expr {
        case .variable(let name):
            #expect(name == "theta")
        default:
            Issue.record("Expected .variable")
        }
    }
}
