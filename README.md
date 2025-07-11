<p align="center">
  <img src="Logo-CalculoKit.png" width="160" alt="CalculoKit Logo" />
</p>

<h1 align="center">CalculoKit</h1>

<p align="center">
  A lightweight Swift framework for symbolic calculus — starting with derivatives!
</p>

---

### 🚀 Features

- ✅ Symbolic **derivation** of mathematical expressions  
  > From `sin(x) + x^2` ➡️ to `cos(x) + 2x`
- 🧠 **Evaluation** of expressions at specific points
- 📈 **SwiftUI chart support** with smooth curve animations

---

### ✨ Example Usage

```swift
import CalculoKit

let x = variable("x")
let expression: MathExpr = MathExpr {
    sin(x) + pow(x, 2)
}

let derivative = expression.derivate
print(derivative) // Output: cos(x) + 2x
```

---

### 🖼 SwiftUI Animation Example

```swift
    Group {
        CalculoCanvas(expre: .sin(.exp(.sin(.x))) + .cos(.ln(.x)),
                      domain: 0...100)
    }
    Group {
        CalculoCanvas(expre: .sin(.x),
                      domain: 0...20)
    }
    Group {
        CalculoCanvas(expre: piecewise {
            when( .x < 10, then: 4)
            when( .x == 10, then: 5)
            when( .x > 10, then: 10)
        },domain: 0...20)
    }
```

<p>
  <img src="Example-Canvas.png" width="240" height="160" alt="Example Canvas" />
</p>

---

### 🧱 Goals

> CalculoKit is just getting started. In the future, we aim to support:

- MathExpr evaluation
- LaTeX export
- Integration
- Limits
- Simplification
- Factorization

---

### 📦 Installation

CalculoKit supports **Swift Package Manager**.

Add the following to your `Package.swift`:

```swift
.package(url: "https://github.com/carVaba/CalculoKit.git", from: "1.0.0")
```

And add `"CalculoKit"` and optionally `"CalculoKitSwiftUI"` to your dependencies:

```swift
.target(
    name: "YourApp",
    dependencies: [
        "CalculoKit",
        "CalculoKitSwiftUI"
    ]
)
```

---

### 🤝 Contributing

This project is built for fun and learning. Contributions and ideas are welcome!

---

### © License

MIT License
