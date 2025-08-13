#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Namespaces and Enums
#v(-0.5em)
== Namespaces
#hinweis[#cppr("language/namespace")[CPPReference: Namespaces]]\
Namespaces are _scopes_ for grouping and preventing name clashes. The _same name_ for classes, functions etc.
in different scopes is possible #hinweis[(`boost::optional` and `std::optional` can coexist)].
_Nesting_ of namespaces is possible #hinweis[(i.e. `std::literals::chrono_literals`)], allows hiding of names.\
The _global namespace_ has the `::` prefix. Can be _omitted_ if unique
#hinweis[(`::std::cout` is usually equal to `std::cout`)].

=== Example
#grid(
  [
    Namespaces can only be defined _outside_ of classes and functions.
    The same namespace can be opened and closed multiple times #hinweis[(i.e. to split a namespace over multiple files)].
    Qualified names are used to access names in a namespace: `demo::subdemo::foo()`.\
    A name with a leading `::` is called a _fully qualified name_ #hinweis[(i.e. `::std::cout`)]

    ==== Using Declarations
    ```cpp
    using std::string; string s{"no std::"};
    ```

    _Imports_ a name from a namespace into the _current scope_. That name can then be used without a namespace prefix.
    Useful if the name is used very often.\
    It is also possible to give the namespace an _alias_:
    ```cpp using input = std::istream_iterator<int>;```\
    Don't put _`using namespace std`_ into your header file to avoid _"namespace pollution"_
    #hinweis[(only use in local scope)].
  ],
  [
    ```cpp
    namespace demo {
    auto foo() -> void; // Declares (1)
    namespace subdemo {
    auto foo() -> void { /* (2) */ }
    } // subdemo
    } // demo

    namespace demo {
    auto bar() -> void { /* (3) */
      foo(); // Calls (1)
      subdemo::foo(); // Calls (2)
    }
    } // demo
    auto demo::foo() -> void { /* (1) */ }

    auto main() -> int {
      using demo::subdemo:foo;
      foo(); // Calls (2)
      demo::foo(); // Calls (1)
      demo::bar(); // Calls (3)
    }
    ```
  ],
)

=== Anonymous Namespaces
#grid(
  [
    The name after the `namespace` keyword can be _omitted_ to turn it into an _anonymous namespace_.
    Every implementation can only be accessed from _inside this file_.
    This _hides module internals_ like helper functions and constants.
    While the namespace doesn't have a "public" name, the compiler gives it an _unique identifier_ internally.
    Anonymous namespaces should only be used in source files #hinweis[(.cpp)]
  ],
  [
    ```cpp
    namespace { // anonymous namespace
    // can't be called outside this file
    auto doit() -> void { ... }
    } // anonymous namespace ends

    // callable from other files
    auto print() -> {
      doit();
    }
    ```
  ],
)

=== Putting `Date` in a namespace
The `Date` class should be put in a namespace to group it with its operators and functions.
Using types and functions from `Date` now require qualification.

#grid(
  [
    *Date.hpp*
    #v(-0.5em)
    ```cpp
    namespace calendar {
    class Date {
      int year, month, day;
    public:
      auto tomorrow() const -> Date
    }; }
    ```
  ],
  [
    *Date.cpp*
    #v(-0.5em)
    ```cpp
    #include "Date.hpp"
    auto calendar::Date::tomorrow() const -> Date {
      // ...
    }
    ```
  ],
)

=== Argument Dependent Lookup
#hinweis[#cppr("language/adl")[CPPReference: Argument-dependent lookup]]\
Types and #hinweis[(non-member)] functions belonging to that type should be placed in a _common namespace_.
When the compilers encounters an _unqualified function_ it looks into the namespace in which
that function is _defined_ to _resolve_ it
#hinweis[(i.e. it is not necessary to write `std::` in front of `for_each` when the first argument is `std::vector::begin()`)].

Functions and operators are _looked up_ in the namespace of the type of their arguments first,
so unqualified operator calls don't allow explicit namespace qualification: #strike[```cpp std::cout calendar::<< birthday```]

==== Example
#grid(
  columns: (1.2fr, 1fr),
  [
    ```cpp
    // Adl.hpp
    namespace one {
      struct type_one{};
      auto f(type_one) -> bool { /* ... */ } // (1)
    }
    namespace two {
      struct type_two{};
      auto f(type_two) -> void { /* ... */ } // (2)
      auto g(one::type_one) -> void { /* ... */ } //(3)
      auto h(one::type_one) -> void { /* ... */ }
    }
    auto g(two::type_two) -> void { /* ... */ } // (4)
    ```
  ],
  [
    ```cpp
    // Adl.cpp
    #include "Adl.hpp"
    int main() {
      one::type_one t1{};
      f(t1); // (1)
      two::type_two t2{};
      f(t2); // (2)
      // error: t1 -> one, no checks for 'two'
      h(t1);
      two::g(t1); // (3)
      g(t1); //Argument type does not match(4)
      g(t2); } // (4)
    ```
  ],
)

==== Issues with ADL
Templates might _not pick up_ a global operator `<<` in an algorithm call using `ostream_iterator` if the value output
is from _namespace std_ too #hinweis[(i.e `std::vector<int>`)].
This would require to put both the `ostream` and `std::vector<int>` in a `namespace std`-block.
But this is _not allowed_ by the C++ standard.

To work around this, a _new class_ inheriting from `std::vector<int>` has to be created with inherited constructors.
A simple alias is insufficient. But it is generally _not recommended_ to derive from standard containers in general.

```cpp
namespace X {
struct IntVector: vector<int> { // create new type
  using vector<int>::vector; }; // inherit constructors from vector
auto operator <<(ostream& os, IntVector const& v) -> ostream& {
  copy(begin(v), end(v), ostream_iterator{os, ","}); return os;
} }
```

#pagebreak()

== Enums
#grid(
  [
    #hinweis[#cppr("language/enum")[CPPReference: Enumeration declaration]]\
    Enumerations are useful to _represent types with only a few values_.
    An enumeration creates a new type that can easily be _converted_ to an _integral_ type.
    The _individual values_ #hinweis[(enumerators)] are _specified_ in the type.
    Unless specified explicitly, the values start with 0 and increase by 1.

    ==== Unscoped enum
    Has no `class` keyword. Used without qualifier.\ Can _implicitly converted_ to `int`.\
    Enumeration leaks into surrounding scope, best used as a member of a class.

    ==== Scoped enum
    Has a `class` keyword. Requires the enum name as qualifier to access the values #hinweis[(i.e. `DayOfWeek::Fri`)].\
    Requires a explicit conversion to int: ```cpp static_cast<int>```\
    Enumeration does not leak into surrounding scope.
  ],
  [
    ```cpp
    // unscoped enum
    enum <name>  { <enumerators> };
    enum DayOfWeek {
      Mon, Tue, Wed, Thu, Fri, Sat, Sun
    // 0,   1,   2,   3,   4,   5,   6
    };
    // implicit conversion to int
    int day = Sun; // 6

    // scoped enum
    enum class <name> { <enumerators> };
    enum class DayOfWeek {
      Mon, Tue, Wed, Thu, Fri, Sat, Sun
    // 0,   1,   2,   3,   4,   5,   6
    };
    // no implicit conversion to int
    int day = static_cast<int>(DayOfWeek::Sun);

    // from int to enum always requires manual cast
    // no type safety, invalid values possible
    DayOfWeek tuesday = static_cast<DayOfWeek>(1);
    ```
  ],
)

=== Operator Overloads for Enumerations
Operators can be _overloaded_ for `enums`. Prime candidates for overloading are the _prefix increment_ `++i`
and _postfix increment_ `i++` operators. If both should be implemented, the postfix operator requires a pseudo-argument
#hinweis[(an additional unused argument)], so the compiler can distinguish the signatures.

#grid(
  columns: (1fr, 1.1fr),
  [
    ```cpp
    // Prefix increment
    auto operator++(DayOfWeek& d) -> DayOfWeek {
      int day = (d + 1) % (Sun + 1);
      d = static_cast<DayOfWeek>(day);
      return d;
    }
    ```
  ],
  [
    ```cpp
    // Postfix increment
    auto operator++(DayOfWeek& d, int) -> DayOfWeek {
      DayOfWeek ret{d};
      if (d == Sun) { d = Mon; }
      else { d = static_cast<DayOfWeek>(d + 1); }
      return ret;
    }
    ```
  ],
)

Another popular application is the `<<` operator: Since enumerator names are not mapped automatically to their original name,
a lookup table is often provided by the output operator to _get an Enumeration as string_.
```cpp
auto operator<<(std::ostream& out, Month m) -> std::ostream& {
  static std::array<std::string, 12> const monthNames {
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };
  out << monthNames[m - 1];
  return out;
}
```

=== Defining Values of Enumerators
#grid(
  [
    With _`=`_, _values can be specified_ for enumerators. Subsequent enumerators get value incremented (+1).

    _Different enumerators_ can have the _same value_.

    In the example on the right, `may` doesn't have a "long name" version and is missing in the second half.
    This is why `june` requires a new assignment.
  ],
  [
    ```cpp
    enum Month {
      jan = 1, feb, mar, apr, may, jun, jul, aug,
      sep, oct, nov, dec,
      january = jan /* 1 */, february /* 2 */,
      march, april, june = jun /* 5 */, july,
      august, september, october, november,
      december
    }
    ```
  ],
)

#pagebreak()

=== Specifying the Underlying Type
#grid(
  [
    Enumerations can _specify_ the _underlying type_ by inheritance. The underlying type can be _any integral type_.
    This allows _forward-declaring_ enumerations, which can be used to hide implementation details if defined as a class member.
    #hinweis[(declaration only in header, enum values only in .cpp-file)]
  ],
  [
    ```cpp
    enum class LaunchPolicy : unsigned char {
      sync = 1;     // Enum values specified in
      async = 2;    // powers of 2 are often used
      gpu = 4;      // as bitmasks: 1 = 0b001
      process = 8;  // 2 = 0b010, 4 = 0b100...
      none = 0;
    }
    ```
  ],
)

=== Example use of enums
#grid(
  columns: (1.3fr, 2fr),
  [
    ```cpp
    // Statemachine.hpp
    #ifndef STATEMACHINE_HPP_
    #define STATEMACHINE_HPP_

    struct Statemachine {
      Statemachine();
      auto processInput(char c) -> void;
      auto isDone() const -> bool;
    private:
      enum class State : unsigned short;
      State theState;
    };

    #endif
    ```
  ],
  [
    ```cpp
    // Statemachine.cpp
    #include "Statemachine.hpp"
    #include <cctype>
    enum class Statemachine::State : unsigned short {
      begin, middle, end
    };
    Statemachine::Statemachine() : theState {State::begin} {}
    auto Statemachine::processInput(char c) -> void {
      switch (theState) {
        case State::begin:
          if(!isspace(c)) {theState = State::middle;} break;
        case State::middle:
          if(!isspace(c)) {theState = State::end;} break;
        case State::end:
          break; // Ignore input
      }
    }
    auto StateMachine::isDone() const -> bool {
      return theState == State::end;
    }
    ```
  ],
)

== Arithmetic Types
#hinweis[#cppr("language/types")[CPPReference: Fundamental types]]\
The arithmetic types are divided into two categories: _integral types_ #hinweis[(which include character and boolean types)]
and _floating-point types_. All arithmetic types must be equality comparable #hinweis[(#no-ligature[`==`])].
It is not recommended to implement your own arithmetic type, but here is a basic example anyway.

=== Example Arithmetic Type: Ring5 -- Arithmetic Modulo 5
The basics are provided: An invariant #hinweis[(The member variable is in range $[0, 4]$)], an accessor to the value
and a explicit constructor. We also implement the default equality operator, a custom output operator
and custom `+` and `+=` operators.

```cpp
struct Ring5 {
  explicit Ring5(unsigned x = 0u) : val{x & 5} {} // constructor
  auto value() const -> unsigned { return val; }  // accessor
  auto operator==(Ring5 const& r) const -> bool = default;
  auto operator+=(Ring5 const& r) -> Ring5& {
    val = (val + r.val) % 5; return *this;        // where the magic happens
  }
  auto operator+(Ring5 const& r) const -> Ring5 { // uses += operator for result
    Ring5 lvalue = *this; lvalue += r; return lvalue;
  }
private:
  unsigned val;
}
auto operator<<(std::ostream& out, Ring5 const& r) -> std::ostream {
  out << "Ring5{" << r.value() << '}'; return out;
}
```
=== Adding mixed arithmetic
If we want to add `Ring5` and `int`, we have two possibilities:
- _Implement all parameter combinations for the `+` operator:_ Causes code duplication overhead\
  ```cpp operator+(Ring5, unsigned); operator+(unsigned, Ring5)```
- _Make constructor non-explicit:_ Might cause problems with automatic conversion.

Both options have their own downsides. Pick your poison!
