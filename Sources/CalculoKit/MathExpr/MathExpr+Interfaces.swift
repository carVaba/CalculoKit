extension MathExpr {
    public func derivate(withRespectTo variable: Variable = .x) -> MathExpr {
        Deriver().evaluate(self, withRespectTo: variable)
    }

    public func limit(
        withRespectTo variable: Variable = .x,
        at point: Double,
        tolerance: Double = 1e-8,
        maxIterations: Int = 5
    ) -> Double? {
        LimitEvaluator().evaluate(
            self,
            approaching: point,
            variable: variable,
            tolerance: tolerance,
            maxIterations: maxIterations
        )
    }
}
