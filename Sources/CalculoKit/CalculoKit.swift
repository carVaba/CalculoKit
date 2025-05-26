// The Swift Programming Language
// https://docs.swift.org/swift-book

@resultBuilder
public struct MathExprBuilder {
    public static func buildBlock(_ components: MathExpr...) -> MathExpr {
        components.count == 1 ? components[0] : components.dropFirst().reduce(components[0], +)
    }
}

public func expression(@MathExprBuilder _ builder: () -> MathExpr) -> MathExpr {
    builder()
}
