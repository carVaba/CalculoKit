//
//  PiecewiseBuilder.swift
//  CalculoKit
//
//  Created by Carlos Baez Rojas on 2/07/25.
//


@resultBuilder
public enum PiecewiseBuilder {
    public static func buildBlock(_ components: PieceWiseItem...) -> [PieceWiseItem] {
        components
    }
}

public func when(_ condition: Condition, then expr: MathExpr) -> PieceWiseItem {
    .init(condition: condition, expression: expr)
}

public func otherwise(_ expr: MathExpr) -> PieceWiseItem {
    .init(condition: .greaterThanOrEqual(.x, -Double.infinity), expression: expr)
}

public func piecewise(@PiecewiseBuilder _ content: () -> [PieceWiseItem]) -> MathExpr {
    .piecewise(content())
}
