//
//  CalculoCanvasViewModel.swift
//  CalculoKit
//

#if canImport(SwiftUI)
import SwiftUI
import Foundation
import CalculoKit

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension CalculoCanvas {
    
    // MARK: – Private helpers
    struct Sample: Identifiable, Equatable {
        let id = UUID()
        let x: Double
        let y: Double
    }
    
    final class CalculoCanvasViewModel: ObservableObject, @unchecked Sendable {
      
        @Published var visiblePoints: [Sample] = []
        private(set) var allPoints: [Sample] = []

        
        init(expr: MathExpr,
             variable: Variable = .x,
             range: ClosedRange<Double>,
             samples: Int = 300)
        {
                // Build the full data set once
            let evaluator = Evaluator()
            let limiter   = LimitEvaluator()
            let dx = (range.upperBound - range.lowerBound) / Double(samples - 1)
            
            self.allPoints = (0..<samples).compactMap { i in
                let x = range.lowerBound + Double(i) * dx
                let y = evaluator.evaluate(expr, at: x, variable: variable)
                ?? limiter.evaluate(expr, approaching: x, variable: variable)
                guard let val = y, val.isFinite else { return nil }
                return Sample(x: x, y: val)
            }
        }
        
        func animate(duration: TimeInterval = 2.0) {
            visiblePoints = []                    // start empty
            
            let fps     = 60.0
            let total   = allPoints.count
            let step    = max(1, Int(Double(total) / (duration * fps)))
            
            Task {
                for idx in stride(from: 0, to: total, by: step) {
                    try? await Task.sleep(for: .milliseconds(Int(1000 / fps)))
                    let currentPoints = Array(allPoints.prefix(idx))
                    await updateVisiblePoints(with: currentPoints)
                }
                // Make sure we end with full data set
                await updateVisiblePoints(with: allPoints)
            }
        }
        
        @MainActor
        func updateVisiblePoints(with points: [Sample]) {
            //withAnimation(.linear) {
                visiblePoints = points
            //}
        }
        
    }
    
}
#endif
