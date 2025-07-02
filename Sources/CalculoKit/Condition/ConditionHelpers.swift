//
//  ConditionHelper.swift
//  CalculoKit
//
//  Created by Carlos Baez Rojas on 2/07/25.
//


public func < (lhs: Variable, rhs: Double) -> Condition {
    .lessThan(lhs, rhs)
}

public func <= (lhs: Variable, rhs: Double) -> Condition {
    .lessThanOrEqual(lhs, rhs)
}

public func == (lhs: Variable, rhs: Double) -> Condition {
    .equalTo(lhs, rhs)
}

public func > (lhs: Variable, rhs: Double) -> Condition {
    .greaterThan(lhs, rhs)
}

public func >= (lhs: Variable, rhs: Double) -> Condition {
    .greaterThanOrEqual(lhs, rhs)
}
