#if canImport(SwiftUI)
import SwiftUI
import Charts
import CalculoKit

    /// Draws `MathExpr` using Apple Charts with optional animation.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public struct CalculoCanvas: View {
    
    @StateObject var viewModel: CalculoCanvasViewModel
    private let animate: Bool
    
    public init(expr: MathExpr, variable: Variable, xRange: ClosedRange<Double>,
                samples: Int, animate: Bool = true) {
        let vm = CalculoCanvasViewModel(expr: expr,
                                        variable: variable,
                                        range: xRange,
                                        samples: samples)
        _viewModel = .init(wrappedValue: vm)
        self.animate = animate
    }
    
        // MARK: – Body
    public var body: some View {
        Chart(viewModel.visiblePoints) { point in
            LineMark(
                x: .value("x", point.x),
                y: .value("y", point.y)
            )
            .interpolationMethod(.cardinal)
        }
        .chartXAxis(.automatic)
        .chartYAxis(.automatic)
        .onAppear {
            viewModel.animate(duration: 2.0)
        }
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview {
    CalculoCanvas(expr: .sin(.exp(.sin(.x))) + .cos(.ln(.x)),
                  variable: .x,
                  xRange: 0...100,
                  samples: 100)
}

#endif
