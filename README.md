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

---

### ✨ Example Usage

```swift
import CalculoKit

let expr = expression {
    .sin(.x) + .x ** 2
}

let derivative = expr.derivate()
print(derivative) // Output: cos(x) + 2x
```

---

### 🧱 Goals

> CalculoKit is just getting started. In the future, we aim to support:

- MathExpr evaluation
- LaTeX export

---

### 📦 Installation

CalculoKit supports **Swift Package Manager**.

Just add the following to your `Package.swift`:

```swift
.package(url: "https://github.com/carVaba/CalculoKit.git", from: "1.0.0")
```

And add `"CalculoKit"` to your target dependencies:

```swift
.target(
    name: "YourApp",
    dependencies: [
        "CalculoKit"
    ]
)
```

---

### 🤝 Contributing

This project is built for fun and learning. Contributions and ideas are welcome!

---

### © License

MIT License
