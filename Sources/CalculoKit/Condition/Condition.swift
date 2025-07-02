//
//  Condition.swift
//  CalculoKit
//
//  Created by Carlos Baez Rojas on 2/07/25.
//

public enum Condition: Sendable, Equatable {
    case lessThan(Variable, Double)
    case lessThanOrEqual(Variable, Double)
    case equalTo(Variable, Double)
    case greaterThan(Variable, Double)
    case greaterThanOrEqual(Variable, Double)
    
    public func isSatisfied(at value: Double, for variable: Variable) -> Bool {
        switch self {
            case .lessThan(let v, let target) where v == variable:
                return value < target
            case .lessThanOrEqual(let v, let target) where v == variable:
                return value <= target
            case .equalTo(let v, let target) where v == variable:
                // TODO: Check if this is enough to compare or maybe we need to compare numerically
                return value == target
            case .greaterThan(let v, let target) where v == variable:
                return value > target
            case .greaterThanOrEqual(let v, let target) where v == variable:
                return value >= target
            default:
                return false
        }
    }
}

