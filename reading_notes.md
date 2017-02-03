# concepts techniques and methods in computer programming

## preface
- *study of computational models*: study computer programming as a unified discipline through "programming concepts and the techniques to use them", rather than programming languages themselves. these concepts are categorized by models of computation. computation model is a more precise idea than a programming paradigm.
- *kernel language*: simple core language defining computation model. clear definition used in text to draw parallels between different computation models (e.g., how adding destructive assignment to functional programming allows object-oriented programming)
- programming: act of extending or changing a system's functionality; in the context of software systems, programming is the step between a specification and an implementation; both a science and technology (science "gives a deep understanding that has predictive power")
- alternatives to the kernel language approach: foundational calculus (e.g., pi or lambda calculus), virtual machine, multiparadigm language -> argues kernel language combines features of all these approaches

## introduction to programming concepts
- syntax: curly brackets denote procedure or function calls
- `Browse` opens a browser windom
- declare a variable with `Declare` prior to declaration e.g., `V=9999*9999`; show result `{Browse V*V}`
- variables are immutable, but may be shadowed with new declarations
- list: *chain of links* created one element at a time, terminating in nil; H|T notation; `(H . T)`
- program correctness: the degree to which program semantics meet the specification
- inductive reasoning: extrapolating a general idea from observation; may be applied for partial verification
- optimizing pascal with binding of local value: recognize exploitable patterns to identify shortcuts
- time complexity: `pascal` is exponential, whereas `fast-pascal` is quadratic
- lazy evaluation: call-by-need; `future` in oz
- higher-order programming: generic definition of `pascal`, `generic-pascal`, that applies an arbitrary function to combine shifted lists
- concurrency: "several independent activities, each of which executes at its own pace"; communication between processes explicit
- explicit state: "memory is needed for functions that can change their behavior and learn from their past"; may be represented with variables (corresponding to memory cells);
- having concurrency and state in a program simultaneously is challenging because the order of thread execution is not gaurenteed
- non-determinism: variability in order of execution; "exists because we lack knowledge of the exact time when each basic operation executes"; message passing concurrency addresses this problem by allowing coordination between threads; race conditions: observable nondeterminism; interleaving of threads: threads take turns executing
- atomicity: means of managing program concurrency and state; an operation is atomic if no intermediate states can be observed (execution represents a one-step transition to the final state);
-
-
