extension MathExpr {
    public func derivate(withRespectTo variable: Variable = .x) -> MathExpr {
        Deriver().evaluate(self, withRespectTo: variable)
    }

    public func limit(withRespectTo variable: Variable = .x, at point: Double) -> Double? {
        LimitEvaluator().evaluate(self, approaching: point, variable: variable)
    }
}
