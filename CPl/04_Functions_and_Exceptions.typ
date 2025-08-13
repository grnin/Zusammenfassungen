#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Functions and Exceptions
#v(-0.5em)
== Functions
#table(
  columns: (1fr, auto, auto),
  table.header(
    [],
    [
      `const`\
      Parameter cannot be changed
    ],
    [
      `non-const`\
      Parameter can be changed
    ],
  ),
  [
    _`reference`_\
    Argument on call-site is accessed \
  ],
  [
    ```cpp
    auto f(std::string const & s) -> void {
      // no modification
      // efficient for large objects
    }
    ```
    #hinweis[For non-copyable objects like Streams]
  ],
  [
    ```cpp
    auto f(std::string & s) -> void {
      // modification possible
      // side-effect also at call-site
    }
    ```
    #hinweis[When side-effect is required at call-site]
  ],

  [
    _`copy`_\
    Function has its own copy of the parameter
  ],
  [
    ```cpp auto f(std::string const s) -> void {
      // no modification
      // used for maximum constness
    }
    ```
    #hinweis[Could prevent changing the parameter inadvertently]
  ],
  [
    ```cpp auto f(std::string s) -> void {
      // modification possible
      // side-effect only locally
    }
    ```
    #hinweis[Default for Parameters]
  ],
)

The _call-site_ always looks the same: ```cpp std::string name{"John"}; f(name);```

It is _not possible_ to pass a `const` argument to a non-`const` reference, because the compiler can't guarantee
that the object will not be changed in the non-`const` function!

=== Function Return Type
Use _by value_. The default for return types. This creates a temporary at the call-site.\
#definition[```cpp auto f() -> type;``` ]
#grid(
  [
    ```cpp
    auto create() -> std::string {
      std::string name{"John"};
      return name;
    }
    ```
  ],
  [
    ```cpp
    auto main() -> int {
      std::string name = create();
      // Temporary stored in the name of 'create'
    }
    ```
  ],
)

_Other ways_ to specify a return type:
- _Const value return type_ ```cpp auto f() -> type const;```\
  Annoying to deal with: The value that the caller owns cannot be modified. This should be avoided!
- _Reference return type:_ ```cpp auto f() -> type &;```\
  Modifiable reference, i.e. for accessing elements in a container
- _Const reference return type:_ ```cpp auto f() -> type const &;```\
  Read-only view of an object

Never return a reference to a _local variable_
#hinweis[(Variable goes out of scope when method ends, leads to undefined behavior)]!

_The trailing return-type could be omitted._ The actual return type will then be deduced from the return statements
in the function's body.

```cpp
auto plusFour(int x) {
    return x + 4;
}
```

#pagebreak()

=== Call Sequence in argument evaluation
Within a single expression #hinweis[(i.e. function call)] the sequence of evaluation is _undefined behavior_!
A later function call could be executed before an earlier one.

```cpp
auto sayGreeting(std::ostream &out, std::string name1, std::string name2) -> void {
  out << name1 << " says Hello to " << name2;
}

int main() { // the second inputName() call could be run before the first
  sayGreeting(std::cout, inputName(std::cin), inputName(std::cin));
}
```

== Function Overloading
The _same function name_ can be used for _different functions_ if the functions have _different parameter numbers_ or _types_.
Just different _return types_ does not count and leads to _ambiguity_. The resolution of overloaded methods
happens at compile time #hinweis[(Ad hoc polymorphism)]

For Overloading in Templates, see chapter @overloading-template.

```cpp
auto incr(int & var) -> void;
auto incr(int & var, unsigned delta) -> void;
```

==== Overloading Ambiguity
```cpp
auto factorial(int n) -> int { ... }
auto factorial(double n) -> double { ... }
factorial(3); factorial(1e2);    // OK
factorial(10u); factorial(1e1L); // Compiler doesn't know what to cast to
```

=== Default Arguments
A _function declaration_ can provide _default arguments_ for its parameters _from the right_
#hinweis[(It is not valid to have a non-default argument after a default argument)].
Default arguments can be _omitted_ when calling the function.
The default value _must be known at compile-time_.

```cpp
// declaration with default value
auto incr(int & var, unsigned delta = 1) -> void;
// definition without default value
auto incr(int & var, unsigned delta) -> void;

int counter{0};
// function calls, the first uses the default value for 'delta'
incr(counter); incr(counter, 5);
```

== Functions as Parameters
Functions are _"first class" objects_ in C++. This means, they can be _passed as arguments_ to
other #hinweis[(higher-order)] functions and they can be _kept in reference variables_.\
*Drawback:* A function parameter declared in this way does _not accept_ a _lambda with a capture_
#hinweis[(the variables in brackets from outside the lambda)].

```cpp
// 2nd Parameter: function 'f' with a 'double' parameter and 'double' as return type
auto applyAndPrint(double x, auto f(double) -> double) -> void {
  std::cout << "f(" << x << ") = " << f(x) << '\n';
}

// reference variables
auto (&ref)(double) -> double // modern C++ with trailing return type
double (&ref)(double) // classic style with return type in front

auto square(double x) -> double { return x * x; }
auto (&referenceVar)(double) -> double = square; // Bind a function to the reference variable
double result = referenceVar(5); // Call the function via the reference variable
```

#pagebreak()

=== Modern approach: `std::function` Template
#hinweis[#cppr("utility/functional/function")[CPPReference: std::function]] #h(1fr) ```cpp #include <functional>``` \
This also allows passing _lambdas with captures_.

```cpp
// 2nd Parameter: function 'f' with a 'double' parameter and 'double' as return type
auto applyAndPrint(double x, std::function<auto(double) -> double> f) -> void {
  std::cout << "f(" << x << ") = " << f(x) << '\n';
}
```

#grid(
  [
    ```cpp
    auto main() -> int {
      double factor{3.0};
      auto const multiply = [factor](double value){
        return factor * value;
      };
      applyAndPrint(1.5, multiply);
    }
    ```
  ],
  [
    Function template methods can also be _stored in variables_ with these types:
    ```cpp
    std::function<auto(double) -> double>
    std::function<double(double)>
    ```
  ],
)

The _type definition_ could also be written in a shorter syntax:

```cpp
auto applyAndPrint(double x, std::function<auto(double) -> double> f) -> void { ... } // old
auto applyAndPrint(double x, std::function<double(double))> -> void { ... } // new
// new syntax: std::function< return-type ( parameter-list ) >
```

== Lambda Functions <lambda-functions>
#hinweis[#cppr("language/lambda")[CPPReference: Lambda expressions]\ ]
Lambda Functions are _inline_ functions.
#grid(
  columns: (2fr, 1fr),
  [
    - _`auto`:_ Type for function variable to store Lambda function in
    - _`[]`:_ introduces the Lambda function
      #hinweis[(can contain captures to access specific or all variables from scope: see below)]
    - _`(Parameters)`:_ as with other functions, but optional if empty.
    - _Trailing return type:_ Usually deduced and thus optional, but can be explicitly specified to automatically cast the return value
    - _Body:_ Statement(s) inside a `{}` block.
  ],
  [
    ```cpp
    auto g = [](char c) -> char {
      return std::toupper(c);
    };
    g('a'); // Returns 'A'
    ```
  ],
)

#grid(
  columns: (2fr, 1fr),
  [
    ==== Capturing a local variable by value: `[x]`
    Local copy _lives as long as the lambda lives_. It is _immutable_, unless the lambda is declared `mutable`.
    The lambda can be passed to other functions, as the captured variable is bound to the lambda.
  ],
  [
    ```cpp
    int x = 5;  // stays 5
    auto l = [x]() mutable {
      std::cout << ++x;
    };
    ```
  ],
)

#grid(
  columns: (2fr, 1fr),
  [
    ==== Capturing a local variable by reference: `[&x]`
    _Allows modification_ of the captured variable. _Side-effect is visible_ in the surrounding scope,
    but referenced variable _must live at least as long_ as the lambda lives, else null-reference possible.
    The _mutability_ depends on if the referenced object is mutable. If the captured variable is a local variable,
    problems are caused when this lambda is passed to other functions #hinweis[(variable out of scope)].
  ],
  [
    ```cpp
    int x = 5; // changed by l
    auto const l = [&x]() {
      std::cout << ++x;
    };
    ```
  ],
)

#grid(
  columns: (2fr, 1fr),
  [
    ==== Capturing all (referenced) local variables by value: `[=]`
    Variables used in the lambda will be _copied_. The copied variables cannot be modified unless the lambda is `mutable`.
  ],
  [
    ```cpp
    int x = 5;  // stays 5
    auto l = [=]() mutable {
      std::cout << ++x;
    };
    ```
  ],
)

#grid(
  columns: (2fr, 1fr),
  [
    ==== Capturing all (referenced) local variables by reference: `[&]`
    Variables used in the lambda will be _accessible_ in the lambda. Will allow modification of the variables if the lambda
    is declared `mutable`, unless the variables are originally declared `const`.
  ],
  [
    ```cpp int x = 5; // changed by l
    auto const l = [&]() {
      std::cout << ++x;
    };
    ```
  ],
)

It is possible to mix and match these types:\
```cpp auto const l = [=, &x]() { ... } // Capture all variables by value, except 'x' by reference```

#pagebreak()

#grid(
  columns: (2fr, 1fr),
  [
    ==== Specify new local variable inside capture
    Create a new variable in capture. It has type `auto` and needs to be initialized in the capture.
    Can be modified if lambda is `mutable`.
    The _specified value_ is only used in the _definition_, _not_ in the _function call_.
    In this example, the variable is multiplied each time the lambda is called.
  ],
  [
    ```cpp
    auto squares = [x=1]() mutable {
      std::cout << (x *= 2);
    };
    ```
  ],
)
#v(1em)
#grid(
  columns: (2fr, 1fr),
  [
    ==== Capturing `this` pointer
    Allows accessing and modifying members of the current class.
  ],
  [
    ```cpp
    struct S {
      auto foo() -> void {
        auto square = [this] {
          member *= 2;
        };
      }
    private: int member{};
    };
    ```
  ],
)

== Failing Functions / Error Handling
Functions can fail when _a contract cannot be fullfilled:_
- _Precondition is violated: _ Negative index, divisor is zero, etc. Usually caller provided wrong arguments.
- _Postcondition could not be satisfied:_ Resources for computation not available, cannot open a file, ...

=== Functionality Guarantees (Contract)
What to do if a function cannot fulfill its purpose?
+ _Ignore the error_ and provide potentially undefined behavior
  #hinweis[(Relies on the caller to satisfy all preconditions. Viable only if not dependent on other resources.
  Most efficient and no checks needed but hard to handle for the caller. Should be done carefully!])

+ _Return a standard result_ to cover the error
  #hinweis[(Reliefs the caller, can hide underlying problems. Often better if caller can specify its own default value)]
  ```cpp
  auto inputNameWithDefault(std::istream & in, std::string const & def = "anon") -> std::string {
    std::string name{}; in >> name; return name.size() ? name : def;
  }
  ```

+ _Return an error code_ or error value
  #hinweis[(Only feasible if result domain is smaller than return type. POSIX: Error Code `'-1'`.
  Burden on the caller to check the result.)]
  ```cpp
  auto contains(std::string const & s, int number) -> bool { // "artificial" npos value
    auto substring = std::to_string(number); return s.find(substring) != std::string::npos;
  }
  ```
  A _more graceful way_ to handle this situation is to use _`std::optional<T>`_: It can either _contain a value or not_.
  It encodes the possibility of failure in the type system. Requires explicit access of the value at the call site
  #hinweis[(checking the boolean `has_value()`)]
  ```cpp
  std::optional<std::string> name = inputName(std::cin);
  if (name.has_value()) { std::cout << "Name: " << name.value(); }
  ```

+ _Provide an error status_ as a side-effect
  #hinweis[(Requires reference parameter, annoying because error variable must be provided)]
  ```cpp
  auto connect(std::string url, bool& error) -> int {
    // set error when an error occurred
  }
  ```

+ _Throw an exception_
  #hinweis[(Prevent execution of invalid logic by throwing an exception)]
  ```cpp
  void sayGreeting(std::ostream & out, std::string name) {
    if (name.empty()) { throw std::invalid_argument{"Empty name"}; }
    out << "Hello " << name << ", how are you?\n";
  }
  ```

#pagebreak()

=== Function with "Narrow Contract"
#grid(
  [
    Functions that have a _precondition_ on their caller. When not all possible argument values are useful for the function
    #hinweis[(i.e. only positive numbers can be processed)]. Do _not_ use exceptions as a second means to return values.
  ],
  [
    ```cpp
    auto squareRoot(double x) -> double {
      if (x < 0) {
        throw std::invalid_argument
          {"square root is imaginary"}; }
      return std::sqrt(x);
    }
    ```
  ],
)

== Exceptions
#hinweis[
  #cppr("error")[CPPReference: Diagnostics library],
  #cppr("header/stdexcept")[CPPReference: \<stdexcept>],
  #cppr("language/throw")[CPPReference: Throwing Exceptions]
]
#h(1fr) ```cpp #include <stdexcept>```
#v(-0.5em)
=== Throwing Exceptions
#grid(
  [
    Any #hinweis[(copyable)] type can be thrown. There are _no means to specify_ what could be thrown,
    but you should always throw exceptions #hinweis[(either predefined from the `<stdexcept>` header or
    derived from `std::exception`)]. There is also _no meta-information_ available: _no stack trace_,
    _no source position_ of throw. Throwing an exception while another exception is propagated results in _program abort_.
  ],
  [
    ```cpp
    // Everything is throwable
    throw std::invalid_argument{"Description"};
    throw 15;
    // Do not use "throw new ..."
    // This will throw a pointer and cause problems
    ```
  ],
)

=== Catching Exceptions
#grid(
  [
    #hinweis[#cppr("language/catch")[CPPReference: Handling Exceptions]]\
    Try-catch block like in Java. Principle: _Throw by value, catch by `const` reference_.
    Avoids unnecessary copying, allows dynamic polymorphism for class types.

    The _sequence_ of catches is significant. _First match wins._ Catch-all with `(...)` must be the last catch.
    Caught exceptions can be _rethrown_ with `throw`. C++ does not have a `finally` clause.
  ],
  [
    ```cpp
    try {
      throwingCall();
    } catch (type const & e) {
      // Handle type exception
    } catch (type2 const & e) {
      // Handle type2 exception
    } catch (...) {
      // Handle other exception types
    }
    ```
  ],
)

=== Exception Types
#hinweis[#cppr("error#Exception_categories")[CPPReference: Exception Categories]]\
The Standard Library has some _pre-defined exception types_ that you can use in _`<stdexcept>`_.
`std::exception` is the base class. All exceptions have a constructor parameter for the "exception reason"
of type `std::string`\ #hinweis[(i.e. ```cpp std::invalid_argument{"Parameter not >0"};```)].

```cpp std::exception, std::runtime_error, std::logic_error, std::out_of_range, std::invalid_argument, ..```

=== Testing for Exceptions with Catch2
- _`REQUIRE_THROWS(<code>)`:_ Tests that any type of exception is thrown
  ```cpp
  TEST_CASE("throw any exception on negative square_root") {
    REQUIRE_THROWS(square_root(-1.0));
  }
  ```
- _`REQUIRE_THROWS_AS(<code>, <exception_type>)`:_ Tests that a specific type of exception is thrown
  ```cpp
  TEST_CASE("throw std::out_of_range on empty vector at()") {
    std::vector<int> empty_vector{};
    REQUIRE_THROWS_AS(empty_vector.at(0), std::out_of_range);
  }
  ```
- _`REQUIRE_THROWS_WITH(<code>, <string or string matcher>)`:_ Test for exception message content
  ```cpp
  TEST_CASE("parseInt throws with message") {
    REQUIRE_THROWS_WITH(parseInt("one"), "parse error - invalid digits in 'one'");
  }
  ```

#pagebreak()

=== Keyword `noexcept`
#grid(
  [
    #hinweis[
      #cppr("language/noexcept_spec")[CPPReference: noexcept specifier],
      #cppr("language/noexcept")[CPPReference: noexcept operator]
    ]
    Functions can be declared to explicitly _not throw_ an exception with the _`noexcept`_ keyword.
    If an exception is thrown directly/indirectly from a `noexcept` function, the program _will terminate_.
  ],
  [
    ```cpp
    auto add(int lhs, int rhs) noexcept -> int {
      return lhs + rhs;
    }
    ```
  ],
)

=== Summary
A _good function_ does _one thing well_ and is named after that #hinweis[(High cohesion)].
Has only _few parameters_, consists of only a few lines without deeply nested control structure.
_Provides guarantees_ about its result and is _easy to use_
#hinweis[(Allows all possible argument values or provides consistent error reporting if it doesn't)].
Pass _parameters_ and return _results_ by _value_, unless there is a good reason not to.
