// The Swift Programming Language
// https://docs.swift.org/swift-book
import CalculoKit

let expr = expression {
    .sin(.x) + .x ** 2
}

print("Expression: \(expr)")
print("Derivative: \(expr.derivate())")
print("Limit as x -> 2: \(expr.limit(at: 2))")
