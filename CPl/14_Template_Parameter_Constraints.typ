#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Template Parameter Constraints <constraints>
With Template Parameter Constraints, the _requirements_ of template parameter can be specified.
They allow for earlier detection of type violations in the template instantiation and lead to _better error messages_.

#grid(
  [
    As an example, the code to the right does not compile because the overload selection fails due to `int` not being a class
    #hinweis[(can't have member functions like `increment()`)].
    + Name `increment` is looked up\
      ```cpp increment(unsigned)``` or the `increment` Template
    + Template arguments are deduced
      ```cpp increment(unsigned)``` or ```cpp increment<int>(int)```
    + Best overload is selected\
      ```cpp increment(int)``` from the template

    `error: request for member 'increment' in 'value', which is of non-class type 'int'`
  ],
  [
    ```cpp
    auto increment(unsigned i) -> unsigned
      { return i++; }

    template <typename T>
    auto increment(T value) -> T
      { return value.increment(); }

    auto main() -> int
      { return increment(42); }
    ```
  ],
)

== SFINAE #hinweis[(Substitution Failure is not an Error)]
#grid(
  columns: (1.2fr, 1fr),
  [
    When searching for an overload, the template parameters are replaced with the deduced types.
    This may result in template instances that _cannot be compiled_ or otherwise suboptimal selection.
    If the substitution of template parameter fails that overload candidate is _discarded_.
    It only results in an error if there are no more remaining overloads. Errors in the function body still result in errors.
  ],
  [
    Substitution failure might happen in the
    + Function return type
    + Function parameter
    + Template parameter declaration
    + Expressions in the above
  ],
)

=== `std::is_class`
#hinweis[
  #cppr("types/is_class")[CPPReference: `std::is_class`],
  #cppr("types/enable_if")[CPPReference: `std::enable_if`]
]
#h(1fr) ```cpp #include <type_traits>```\
In the introductory example, the `increment` template should only be selected for class type arguments.
_`std::is_class_v<T>`_ is a variable template that returns `true` if `T` is a class.
It can be used as `V` in the type template _`std::enable_if_t<V, T>`_ that converts a boolean value `V` into
type `T` if `true`, or does nothing if `false`.

We can use it to provoke template substitution failures #hinweis[(e.g. in the parameter declaration)]:
```cpp
template <typename T>
auto increment(std::enable_if_t<std::is_class_v<T>, T> value) -> T {
  return value.increment();
}
```
This works, but it is the _ugly old-school way_ of specifying type constraints. The modern way are constraints & concepts.

== Constraints with a `requires` clause
#hinweis[#cppr("language/constraints")[CPPReference: Constraints and concepts]]\
`requires` clauses allow _constraining template parameters_.
A `require` keyword is followed by a compile-time constant boolean expression.
They are placed after the template parameter list or after the functions template declarator.

#definition[
  #grid(
    columns: (0.8fr, 1fr),
    [
      ```cpp
      // Declaration after template params
      template <typename T>
      requires true
      auto function(T argument) -> void {}
      ```
    ],
    [
      ```cpp
      // Declaration after function template declarator
      template <typename T>
      auto function(T argument) -> void requires true {}
      ```
    ],
  )
]

#pagebreak()

For example, a `requires` clause can be created with `std::is_class`.
The compiler error message it produces is much more specific about what went wrong.
#grid(
  columns: (0.8fr, 1fr),
  [
    ```cpp
    template <typename T>
    requires std::is_class_v<T>
    auto function(T argument) -> void {}

    function(1);
    ```
  ],
  [
    ```
    error: no matching function for call to 'function(int)'
    note: constraints not satisfied
    note: the expression 'is_class_v<T>' [with T = int] evaluated to 'false'
    ```
  ],
)

== `requires` Expression
#hinweis[#cppr("language/requires")[CPPReference: `requires` expression]]\
The `requires` keyword can also be used to create a _`requires` expression:_
A `requires` clause with _multiple statements_ that evaluates to _`bool`_.

#definition[
  #grid(
    [
      ```cpp
      requires {
        // Sequence of requirements
      }
      ```
    ],
    [
      ```cpp
      requires (<parameter-list>) {
        // Sequence of requirements
      }
      ```
    ],
  )
]

*Types of requirements*
- _Simple requirements:_ Statements that evaluate to `true` when compiled
- _Type requirements:_ Check whether a specific type exists #hinweis[(typically for nested types)]
- _Compound requirements:_ Checks constraints on an expressions type
- _Nested requirements:_ Contain further (nested) requires expressions #hinweis[(not covered in CPl)]

==== A note on C++ grammar and the double `requires`
Most `requires` expressions are used within a `required` clause, meaning that you'll often see\
`requires requires (...) { ... }`.

_Why is the second `requires` necessary?_\
A `requires`-clause says "This function should be considered in overload resolution if this condition is true" --
it can take any constant boolean expression. It can be written as ```cpp requires(foo)```, where `foo` is a boolean expression.\
A `requires`-expression just asks the compiler "Are these expressions well-formed?".
```cpp requires(foo f)``` is a valid `requires` clause.
So from what point on can the parser be sure that it is a `requires`-clause and not a expression?

```cpp
void bar() requires (foo) {
  // content
}
```

If `foo` is a type, then `(foo)` is a parameter list of a `requires` expression and everything in the `{}` is
the body of this `requires` expression.
If `foo` is not a type, then `foo` is an expression in a `requires` clause and everything in the `{}` is
the regular function body of `bar()`.

While the compiler could theoretically clear up this ambiguity by figuring out if `foo` is a type or not,
the C++ committee decided to require two `requires` to _avoid this kind of context-sensitive parsing_.

=== Simple Requirements
Simple requirements are _statements that are `true` when they can be compiled_. In the example, code that calls this template
can only be compiled if `T` can be replaced with a type that has a `increment()` member function.

#grid(
  columns: (0.5fr, 1fr),
  [
    ```cpp
    requires (T v) {
      v.increment();
    }
    ```
  ],
  [
    ```cpp
    template <typename T>
    // Test if T has an increment() member function
    requires requires (T const v) { v.increment(); }
    // Actual code that gets run if the requirement passes
    auto increment(T value) -> T {
      return value.increment();
    }
    ```
  ],
)

=== Type Requirements
Type requirements _check whether a specific type exists_, typically for nested types. It starts with the `typename` keyword.
It can be used to _specify what kind of types can be passed_ as template arguments.
In the example, we see the `max_value` algorithm that gets the largest value between the `begin` and `end` iterators.
In its `requires` expression is specified that both arguments should be iterators that point to a value type.
#grid(
  columns: (0.3fr, 1fr),
  [
    ```cpp
    requires {
      typename $type$
    }
    ```
  ],
  [
    ```cpp
    template <typename FwdIter>
    requires requires {
      typename std::iterator_traits<FwdIter>::value_type;
    }
    auto max_value(FwdIter begin, FwdIter end)
      -> std::optional<typename std::iterator_traits<FwdIter>::value_type>
    {
      auto max_pos = std::max_element(begin, end);
      if (max_pos == end) { return {}; }
      return *max_pos;
    }
    ```
  ],
)

=== Compound Requirements
Compound requirements _check whether an expression is valid_ and can check constraints on the expression's type.
Similar to a simple requirement, but it can also optionally specify a return type requirement with a type requirement.
The type requirement must be a function from the #cppr("concepts")[Concepts library], regular return types don't work.

#grid(
  [
    ```cpp
    requires (T v) {
      { $expression$ } -> $type-constraint$;
    }

    // Example on the right compiles if the return
    // type of increment() is the same as T.
    // T can't be used here, it isn't a concept
    ```
  ],
  [
    ```cpp
    template <typename T>
    requires requires (T const v) {
      { v.increment() } -> std::same_as<T>;
    }
    auto increment(T value) -> T {
      return value.increment();
    }
    ```
  ],
)

=== Named constraints with the `concept` keyword
Specifies a type requirement with a _name that can be reused_.
Typically, a `requires` expression is part of a `bool` expression.
Conjunctions (`&&`) and disjunctions (`||`) can be used to combine multiple constraints.

#grid(
  [
    ```cpp
    template <typename T>
    concept TypeRequirementName = $bool-expr$
    ```
  ],
  [
    ```cpp
    template <typename T>
    concept Incrementable = requires (T const v) {
      { v.increment() } -> std::same_as<T>
    };
    ```
  ],
)

Named constraints can be used in template parameter declarations or as part of a `requires` clause.
#grid(
  [
    ```cpp
    // Template parameter declaration
    template <Incrementable T>
    auto increment(T value) -> T {
      return value.increment();
    }
    ```
  ],
  [
    ```cpp
    // In requires clause
    template <typename T>
    requires Incrementable<T>
    auto increment(T value) -> T {
      return value.increment(); }
    ```
  ],
)

== Abbreviated Function Templates
Definitions of function templates can be _shortened_ by using `auto` as the generic parameter type.
With this, the `template` expression can be omitted.

#grid(
  [
    ```cpp
    // abbreviated template definition
    auto function(auto argument) -> void {}
    ```
  ],
  [
    ```cpp
    // equivalent "normal" definition
    template <typename T>
    auto function(T argument) -> void {}
    ```
  ],
)

This syntax can introduce conflicts when multiple function parameters are used.\
What function will ```cpp auto function(auto arg1, auto arg2) -> void``` pick?
#grid(
  [
    ```cpp
    template <typename T>
    auto function(T arg1, T arg2) -> void {}
    ```
  ],
  [
    ```cpp
    template <typename T1, typename T2>
    auto function(T1 arg1, T2 arg2) -> void {}
    ```
  ],
)

The problem can be avoided with the _Terse Syntax for Constrained Parameters:_
Abbreviated function template parameters can be constrained too.
#grid(
  [
    ```cpp
    // abbreviated template definition
    auto increment(Incrementable auto value) -> T {
      return value.increment();
    }
    ```
  ],
  [
    ```cpp
    // equivalent "normal" definition
    template <Incrementable T>
    auto increment(T value) -> T {
      return value.increment();
    }
    ```
  ],
)

=== Example Concepts for Output
Here are two concepts #hinweis[(not the template functions that implement them!)] that can be used to output values.
Templates constrained by `Printable` can be used with classes that have a ```cpp print(std::ostream&)``` member function, while
templates constrained by `LeftshiftOutputtable` can only be used with types that overload the `<<` operator
to work with `std::ostream`.

```cpp
template <typename T>
concept Printable = requires (T const v, std::ostream& os) {
  v.print(os);
};

template <typename T>
concept LeftshiftOutputtable = requires (T const v, std::ostream& os) {
  {os << v} -> std::same_as<std::ostream&>;
};
```

== Overloading on Constraints
Function overloads with _unsatisfied constraints_ are excluded from overload resolution as well.

In this example, we have a generic function `printAll()` with a variadic amount of parameters in `rest`.
Depending on whether the type in `first` has a ```cpp print(std::ostream&)``` member function or the `<<` operator overloaded
for outputting its value, the first or the second overload of `print()` overload will be called.

For example, `int` does not have a `print()` member function #hinweis[(because `int` is not a class type)], but it does have
the `<<` operator implemented, so the ```cpp print(LeftshiftOutputtable)``` overload will be called.

```cpp
auto print(Printable auto const& printable) {
  printable.print(std::cout);
}

auto print(LeftshiftOutputtable auto const& outputtable) {
  std::cout << outputtable
}

auto printAll(auto const& first, auto const&... rest) -> void {
  print(first);
  if constexpr (sizeof...(rest)) {
    std::cout << ", ";
    printAll(rest...);
  }
}
```

== Concepts in the standard library
#hinweis[#cppr("concepts")[CPPReference: Concepts library]] #h(1fr) ```cpp #include <concepts>```\
The standard library has many predefined type constraints:
- _`std::equality_comparable`:_ Whether a type can be #no-ligature[`==`] and #no-ligature[`!=`] compared
- _`std::default_initializable`:_ Whether a type can be default constructed
- _`std::floating_point`:_ Whether a type is a floating-point
- _`std::forward_iterator`:_ Whether a type is a forward iterator
