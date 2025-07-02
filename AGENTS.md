# AGENTS.md

## Purpose
Guide Codex agents to implement, test, and maintain a Swift 6.0 symbolic math library using Swift Package Manager and swift‑testing.

## Project Structure
- `/Sources/`: Swift source files (`MathExpr.swift`, `Simplifier.swift`, etc.).
- `/Tests/`: Unit tests using `swift‑testing`, one test file per feature.

## Toolchain Instructions
- Use `swift build` to compile.
- Run tests: `swift test`.
- Lint/format with `swift-format` or `swiftlint` (if configured).

## Coding Style
- Follow [Swift API Design Guidelines].
- No force unwrapping (`!`).
- Prefer immutability and pure functions.
- Explicit method calls; no `callAsFunction`.

## Testing Requirements
- Each feature must include minimal unit tests (edge cases + core examples).
- Tests must pass (`swift test`) before PR submission.

## Prompting Advice
- Break tasks into small, single-purpose functions.
- Inline comments are fine; avoid excessive commentary.
- Use descriptive method names.

## Commit and PR Guidelines
- Title: `[Codex] <short description>`
- PR description must include: feature summary, testing strategy.
- Ensure all tests pass and formatting is consistent.

## Documentation
- Update the README.md if a new use case is added

## Examples
- Simplification: `x + 0 → x`, `x * 1 → x`
- Derivative: `d/dx sin(x) → cos(x)`


