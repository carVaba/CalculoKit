//
//  PieceWiseItem.swift
//  CalculoKit
//
//  Created by Carlos Baez Rojas on 2/07/25.
//


public struct PieceWiseItem: Sendable {
    let condition: Condition
    let expression: MathExpr
    
    public init(condition: Condition, expression: MathExpr) {
        self.condition = condition
        self.expression = expression
    }
}