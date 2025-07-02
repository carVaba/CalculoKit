#if canImport(SwiftUI)
import SwiftUI
import Charts
import CalculoKit

    /// Draws `MathExpr` using Apple Charts with optional animation.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public struct CalculoCanvas: View {
    
    var expre: MathExpr
    var domain: ClosedRange<Double> = 0...0
    
    init(expre: MathExpr, domain: ClosedRange<Double>) {
        self.expre = expre
        self.domain = domain
    }
    
    init(@MathExprBuilder expre: ()->MathExpr, domain: ClosedRange<Double>) {
        self.expre = expre()
        self.domain = domain
    }
    
    // MARK: – Body
    public var body: some View {
        Chart {
            LinePlot(x: "X", y: expre.description, domain: domain) { double in
                let evaluator = Evaluator()
                return evaluator.evaluate(expre, at: double) ?? 0.0
            }
        }
        .chartXAxis(.automatic)
        .chartYAxis(.automatic)
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview {
    Group {
        CalculoCanvas(expre: .sin(.exp(.sin(.x))) + .cos(.ln(.x)),
                      domain: 0...100)
    }
    Group {
        CalculoCanvas(expre: .sin(.x),
                      domain: 0...20)
    }
    Group {
        CalculoCanvas(expre: piecewise {
            when( .x < 10, then: 4)
            when( .x == 10, then: 5)
            when( .x > 10, then: 10)
        },domain: 0...20)
    }
}

#endif

