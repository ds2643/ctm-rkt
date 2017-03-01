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
- atomicity: means of managing program concurrency and state; an operation is atomic if no intermediate states can be observed (execution represents a one-step transition to the final state)

## Declarative Computation Model
1. *computation model*: "formal system that defines a language and how [expressions and statements] are exectuated by an abstract machine"

2. *programming model*: "set of techniques and design principles" specific to a language in some computation model. by necessity built over some computation model.

3. *set of technqiues for reasoning about programs*

*declarative programming*: tentatively defined as evaluating functions over partial data structures... stateless programming as opposed to imperative programming... encompasses the ideas of functional and logic programming
### defining practical programming languages
- syntax: what constitutes a legal program?
- grammars: a set of rules that describes how to make sentences out of words, or statements out of tokens
- *tokenizer or lexical analyzer*: program that accepts a sequence of characters and returns a sequence of tokens
- *parser*: program that accepts a sequence of tokens and returns a parse tree
- Extended Backus-Naur Form (EBNF): common notation for defining grammar... distinguishes terminal from nonterminal symbols... terminal symbols are tokens, whereas a nonterminal symbol is a sequence of tokens... nonterminal sequences are defined by grammar rules, which dictate means of expansion into tokens
```
    <digit> ::= 0 | 1 | ... | 8 | 9
    <int> ::= digit { <digit> }
```
- `0` to `9` are terminal, whereas some int, `42`, is non-terminal
- context free grammars (e.g., EBNF) define a superset of a language, which is further restricted with a set of additional conditions (e.g., variables must be declared before use) (i.e., context sensitivity)
- _context free grammar_: expansion of a non-terminal (e.g., `<digit>`) is always the same regardless of where it is used
- "For most practical programming languages, there is usually no context-free grammar that generates all legal programs and no others. For example, in many languages a variable has to be declared before it is used. This condition cannot be expressed in a context-free grammar because the nonterminal that uses the variable must only allow using already-declared variables. This is a context dependency. A grammar that contains a nonterminal whose use depends on the context where it is used is called a _context-sensitive grammar_."
- _ambiguity_: "there can be several aprse trees that correspond to a given token sequence" for some context-free grammar. "ambiguity is usually an undesirable property of a grammar since it makes it unclear exactly what program is being written." extra conditions over context-free grammar disambiguate the grammar.
- examples of such conditions: precedence, associativity (left-, right-most)
- kernel language approach allows definition of semantics of "practical" language "in a simple mathematical structure that allows us to reason about the program (including its correctness, execution time, and memory use) without introducing any irrelevant details... without making the semantics too complicated"
- whereas a practical language should "provide useful abstracts for the programmer" and "be [extendable] with linguistic abstractions", the kernel language that the practical language is translated to should "contain a minimal set of intuitive concepts", be "easy for the programmer to understand and reason in", and have "a formal semantics (e.g., operational, axiomatic, or denotational semantics)"
- the kernel language approach requires that "all language constructs be defined in terms of translations into the core language known as the kernel language"
- translation schemes may be inguistic abstraction or syntactic sugar
- approaches to language semantics: (1) operational semantics: concerns how a stateent executes in terms of an abstract machine (2) axiomatic semantics: concerns definition of a statement's semantics as the relation between input and output state specified as a logical assertion (3) denotational semantics: defines a statement as a function over an abstract domain (gets complicated when applied to concurrent languages) (4) logical semantics: defines a statement as a model of logical theory
- linguistic abstraction refers to a new construct which serves as an addition to a language syntax
- addition of linguistic abstraction: define grammatical construct, then define its translation into the kernal language; the kernel language does not change.
- _gump_ parser generator tool used to add linguistic abstractions to Mozart
- syntatic sugar: provides short-cut notation for frequently-occuring idioms; not to be confused with linguistic abstraction, just reduces program size and improves readability
- interpreter approach as an approach altenrative to kernel language approach
single-assignment store: set of variables that are initially unbound and that can be bound to one value (e.g., `{x1 x2 x3}` -> `{x1=314 x2=[1 2 3] x3}`)
- each entry of a single value store is a declarative variable; not unbound through computation cycle
- value store is a persistent mapping from varliables to values
note that the declarative variable (e.g., `x1`) is not the name of the variable in the program; a variable identifier can refer to a bound or unbound declarative variable
_partial value_: data structure that may contain unbound variables; contrast to _complete value_
_equivalence set_: `x1 = x2`, where both `x1` and `x2` are declarative variables
_dataflow variables_: declarative variables that cause the program to wait until they are bound; introduced in the context of _variable use error_ and strategies to handle such errors
kernel language for the declarative model defined
- all programs of the model can be expressed in this language
```
    <s> ::=
        | skip                                          ;; empty statement
        | <s1> <s2>                                     ;; statement sequence
        | local <x> in <s> end                          ;; variable creation
        | <x1>=<x2>                                     ;; variable-variable binding
        | <x>=<v>                                       ;; value creation
        | if <x> then <s1> else <s2> end                ;; conditional
        | case <x> of <pattern> then <s1> else <s2> end ;; pattern matching
        | {<x> <y1> ... <yn>}                           ;; procedure application
```
type hierarchy of the declarative model
```
    <v>                 ::= <number> | <record> | <procedure>
    <number>            ::= <int> | <float>
    <record>, <pattern> ::= | <literal>
                            | <literal>(<feature>1: <x1> ... <feature>n: <xn>)
    <procedure>         ::= proc {$ <x1> ... <xn> }
    <literal>           ::= <atom> | <bool>
    <feature>           ::= <atom> | <bool> | <int>
    <bool>              ::= <true> | <false>
```
"the power of records": can be used to express most other data structures (e.g., lists, trees, queues, graphs, etc.)
why procedures?
- simpler than objects
- more appropriate than functions because they don't necessarily define entities that behave like mathematical functions
basic operations defined in 2.3.5
_lexical/static scoping_: value of an identifier is determined by the innermost local statement declaring that identifier
- "`p` uses the version of `q` that exists in `p`'s definition"
- consequence of lexical scoping: if value of some identifier `y` not declared, the value of `y` is `y`'s value at the time when the value is defined
- alternative: _dynamic scoping_: `p` uses definition of `q` that exists when `p` proceedure is called
- advantage of static scoping over dynamic scoping as a default is that static scoping will work the same for a given set of inputs regardless of where it is called
dataflow behavior underlies concurrency
_abstract machine_:
- kernel semantics defined operationally (i.e., kernel semantics define kernel language in terms of execution on abstact machine)
- basic concepts: environments, semantic statement, statement stack, execution state, and computation.
- a running program may be regarded as a sequence of execution states
abstract machine, explained:
- _semantic stack_: statement in execution
- _single assignment store_: σ, value store extended with dataflow variables
- _environment_: E, mapping from variable identifiers to store entities in σ;
- _semantic statement_: pair `(<s>,E)`, where `<s>` is a statement and `E` is an environment
- _execution state_: a pair `(ST, σ)`, where ST is a stack of semantic statements and σ is a single-assignment store
- _computation_: a sequence of execution states `(ST0, σ0) -> (ST1, σ1) -> ... (STn, σn)`; single transition in a computation is called a computation step; each computation step is atomic; the execution state contains exactly one statement stack, which is transformed by a linear sequence of computation steps
_fundemental operations on environents_: adjunction and restriction
_adjunction_: defines new environment by adding a mapping to an existing one e.g., `E' = E + {<x> -> x}`
_restriction_: defines new environment whose domain is a subset of an existing one
_`skip` statement_: `(skip, E)`: execution complete after this pair is popped from the semantic stack
_sequential composition_: `(<S1> <s2>, E)`: push `(<s2, E)` on the stack, and then push `(<s1>, E)` onto the stack
_local variable declaration_: `(local <x> in <s> end, E)`: create new variable `x` in the store, then let `E'` be `E + {<x> -> x}`, push `(<s>, E')` onto the stack
_variable-variable binding_: `(<x1> = <x2>, E)`: bind `E(<x1>)` and `E(<x2>)` in the store
_value creation_: `(<x> = <v>, E)`, where `<v>` is a partially constructed value (e.g., record, number, or procedure)
