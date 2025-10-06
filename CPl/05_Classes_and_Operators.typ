#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Classes and Operators
#v(-0.5em)
== Classes
#grid(
  [
    #hinweis[#cppr("language/classes")[CPPReference: Classes]]\
    A _good class_ does _one thing well_ #hinweis[(High cohesion)] and is named after that.
    It consists of _member functions_ with _only a few lines_.
    Has a _class invariant_ #hinweis[(Consistency, provides a guarantee about its state)].
    Is _easy to use_ without complicated protocol sequence requirements.
  ],
  [
    ```cpp
    class <GoodClassName> {
      <member variables>
      <constructors>
      <member functions>
    };
    ```
  ],
)

=== Declaration / Implementation Example
A class _defines a new type_. At the _end_ of a class definition, a semicolon is required. The definition/declaration is in
a _header file_ #hinweis[(\*.hpp)] and the implementation in a _source file_ #hinweis[(\*.cpp)]. In the implementation,
the member functions are not wrapped in a class #hinweis[(i.e. `class xy { ... }`)], instead every function has the
corresponding class name as a prefix: _`xy::`_

#grid(
  [
    ```cpp
    // File Date.hpp
    #ifndef DATE_HPP_ // Start of include guard
    #define DATE_HPP_

    class Date { // Keyword for defining a class
      // Member Variables
      int year, month, day;
    public: // access specifier: Public members
      // Constructor:
      Date(int year, int month, int day);
      // Member Functions 1 & 2
      static auto isLeapYear(int year) -> bool;
      auto tomorrow() const -> Date;

    private: // access specifier: Private members
      // Member Function 3
      auto isValidDate() const -> bool;
    }; // Don't forget this semicolon!
    #endif // End of include guard
    ```
  ],
  [
    ```cpp
    // File Date.cpp
    #include "Date.hpp"

    // Implementation of Constructor
    Date::Date(int year, int month, int day)
      : year{year}, month{month}, day{day} {
        /* ... */
    }

    // Implementation of Member Functions
    auto Date::isLeapYear(int year) -> bool {
      /* ... */
    }

    auto Date::isValidDate() const -> bool {
      /* ... */
    }

    auto Date::tomorrow() -> Date { /*...*/ }
    ```
  ],
)

==== Using the Class
```cpp
#include "Date.hpp"

auto dating() -> void {
  Date today{2016, 10, 19};        // Using the constructor
  auto thursday{today.tomorrow()}; // Copy Constructor, initialized with member function
  Date::isLeapYear(2016);          // Static Member Function
  Date invalidDate{2016, 13, 1};   // Should throw error
}
```

== Declaration in the header file
#hinweis[
  #cppr("language/class")[CPPReference: Class Declaration],
  #cppr("preprocessor/include")[CPPReference: Source file inclusion]
]
#v(-0.5em)
=== Include Guard
#grid(
  columns: (2fr, 1fr),
  [
    Ensures that the content of a header file is only included _once_.
    Eliminates _cyclic dependencies_ of `#include` directives.
    Prevents violation of the _one definition rule_, see chapter @one-definition-rule.
  ],
  [
    ```
    #ifndef <name>
    #define <name>
    #endif
    ```
  ],
)

#hinweis[#cppr("keyword/struct")[CPPReference: keyword struct], #cppr("keyword/class")[CPPReference: keyword class]\ ]
There are two different keywords for defining a class: ```cpp class``` and ```cpp struct```. Their only difference is the
_default visibility_ of their member functions and variables: _`private` for `class`, `public` for `struct`_.

=== Access specifiers
#hinweis[#cppr("language/access")[CPPReference: Access specifiers]]\
- _`private:`_ visible only inside the class, for hidden data members
- _`protected:`_ also visible in subclasses
- _`public:`_ visible from everywhere, for the interface of the class
It is possible to declare _multiple blocks_ of the same access specifier, but best practice is to _only use one block_.

=== Member variables
Have a _type_ and a _name_: `<type> <name>`. Do _not_ make member variables _`const`_, as it prevents _copy assignment_.
The definition order _specifies the initialization order_ of the class members.

=== Static Members
#grid(
  [
    #hinweis[#cppr("language/static")[CPPReference: Static members]]\
    Classes can also have static member functions/variables that don't need an instance to be called/accessed.
    In the header, they are defined with the `static` keyword.
  ],
  [
    ```cpp
    class Date {
      static const Date myBirthday;
      static Date today{};
      static auto isLeapYear(int year) -> bool;
    }
    ```
  ],
)

#v(-0.5em)
=== Constructors <constructors>
#grid(
  [
    #hinweis[#cppr("language/constructor")[CPPReference: Constructors]]\
    A constructor #hinweis[(often shortened to `ctor`)] is a _function with the name of the class_ that can be
    called to create an instance of this class. It is a _special member function_.
    It has _no return type_ and can have an _initializer list_ for member initialization.
  ],
  [
    ```
    <class name>() {}

    <class name>(<parameters>)
      : <initializer-list>
    {}
    ```
  ],
)

#grid(
  [
    The _member initializer list_ can take the parameters and directly assign them to member variables.
    The initialization _order_ depends on the order of the members inside the class, not the order in the initializer list.
    There can be more code after the initializer list, for example to perform validation of the parameters before assigning them.
    If there is no code after it, empty `{}` are still required!
  ],
  [
    ```cpp
    Date::Date(int year, int month, int day)
      : year{year}, month{month}, day{day}
    {
      if (month < 1 || month > 12) {
        throw std::invalid_argument
          {"Invalid month!"};
      }
      // more error checking for day & year
    }
    ```
  ],
)



==== Implicit Special Constructors
#grid(
  [
    #hinweis[
      #cppr("language/default_constructor")[CPPReference: Default Constructor],
      #cppr("language/copy_constructor")[CPPReference: Copy Constructor]
    ]\
    _Default Constructor:_ ```cpp Date d{};``` \
    The Default Constructor is a constructor that can be called with _no arguments._
    Has to initialize member variables with default values. It is _implicitly available_ if there are no
    other declared constructors. If there are other constructors, it can be _explicitly_ made available
    with the keyword `default`.
  ],
  [
    ```cpp
    class Date {
      public:
        Date(int year, int month, int day);
        // Default-Constructor
        Date(); // implicit
        Date() = default; // explicit

        // Copy-Constructor
        Date(Date const &);
    };
    ```
  ],
)

_Copy Constructor:_ ```cpp Date d2{d};```\
The copy constructor can be called with an object of the same class and copies the content of the argument.
It has one parameter of type `<own-type> const &`. It is implicitly called when an object is assigned to a new variable.
_Copies_ all member variables into the new variable. Is _implicitly available_, unless there is a move constructor
#hinweis[(C++ Advanced topic)] or an assignment operator. Usually no need for explicit implementation.

=== Defaulted Constructor
#grid(
  [
    ```cpp <ctor-name>() = default;```\
    If any constructor is implemented, the implicit default constructor is no longer available.
    If it is still desired to keep it, instead of reimplementing it manually, it can be _defaulted_.
    This adds it back with the same behavior as when it was implicitly available.
    Defaulting is also possible for default destructor, copy/move constructor and copy/move assignment operator.
  ],
  [
    ```cpp
    class Date {
      int year{9999}, month{12}, day{31}
      // explicitly re-add default ctor
      Date() = default;
      Date(int year, int month, int day);
    };
    ```
  ],
)

==== Type-conversion Constructor
#grid(
  [
    ```cpp explicit <ctor-name>(<OtherType>);```\
    Constructors with a _single argument_ or with default arguments for all parameters after the first can be
    called with any type as its argument, as long as it is _implicitly convertible_ to the specified type
    #hinweis[(i.e. a `double` argument for a `int` parameter)]. This implicit conversion can cause errors.
    To disable this, constructors like this can be declared _`explicit`_, so only the specified type will
    be taken as an argument.
  ],
  [
    ```cpp
    class Date {
    public:
      Date(int year, int month, int day);
      // Type-conversion Constructor
      // Is marked 'explicit' to prevent implicit
      // conversion of the 'year' parameter
      // i.e. from double or char
      explicit Date(
        int year, int month = 1, int day = 1);
    };
    ```
  ],
)

==== Initializer List Constructor
#grid(
  [
    ```cpp Container box{item1, item2, item3};```\
    Has one `std::initializer_list<T>` parameter. Does _not_ need to be marked _`explicit`_
    #hinweis[(implicit conversion is usually desired)].
    Initializer List constructors are preferred if a variable is initialized with `{}`:

    ```cpp
    std::vector v(4, 10); // returns 10, 10, 10, 10
    std::vector v{4, 10}; // returns 4, 10
    ```

  ],
  [
    ```cpp
    struct Container {
      Container() = default;
      // Initializer List Constructor
      Container(
        std::initializer_list<Element> elements);
    private:
      std::vector<Element> elements{};
    };
    ```
  ],
)

==== Deleted Constructors
#grid(
  [
    ```cpp <ctor-name>() = delete;```\
    To _delete implicit constructors_, you can delete them by adding the keyword `delete`.
    Possible for default constructor/destructor, copy/move constructor and copy/move assignment operator.
  ],
  [
    ```cpp
    class Banknote {
      int value;
      // Delete default copy constructor
      // Instances can't be copied anymore
      Banknote(Banknote & const) = delete;
    };
    ```
  ],
)

==== Delegating Constructors
#grid(
  [
    Constructors can call _other_ constructors, similar to Java.
    The Constructor call has to be in the _member initializer list_.

    ```cpp
    Date::Date(int year, int month, int year)
      : Date{year, Month(month), day} {}
    ```
    This calls the ```cpp Month(int)``` constructor and the result is then placed in the
    ```cpp Date(int, Month, int)``` constructor.
  ],
  [
    ```cpp
    class Date {
      // ...
      Date(int year, Month month, int day);
      Date(int year, int month, int day);
    };

    class Month {
      Month(int month);
      // ...
    }
    ```
  ],
)

#pagebreak()

==== Destructor
#grid(
  [
    #hinweis[#cppr("language/destructor")[CPPReference: Destructor]]\
    ```cpp ~Date();```\
    A destructor #hinweis[(often shortened to `dtor`)] is the _counterpart_ to the constructor.
    Must _release_ all resources. Is implicitly available.
    Must _not_ throw an exception, because if it does, the whole program gets terminated.
    Is called _automatically_ at the end of the block for local instances.
  ],
  [
    ```cpp
    class Date {
      public:
        Date(int year, int month, int day);
        ...
        // Destructor
        ~Date();
    };
    ```
  ],
)

== Implementation in the source file
#v(-0.5em)
=== Constructors and Default Initialization
#grid(
  [
    - _Establish Invariant:_ Properties for a value of the type that are always valid.
      A `Date` instance always represents a valid date. All #hinweis[(public)] member functions assume this and keep it intact.
    - _Initialize all Members:_ Constructors only create a valid instance.
      Use initializer lists and the default values if possible / necessary, see chapter @constructors.

    The _Default Value_ should be created by the default Constructor. Initialize all classes with `{}`!
    ```cpp Date::Date() : year{9999}, month{12}, day{31}{}```
  ],
  [
    ```cpp
    #include "Date.hpp"
    Date::Date(int year, int month, int day)
      : year{year}, month{month}, day{day}
    {
      if (!isValidDate()) {
        throw std::out_of_range{"invalid date"};
      }
    }
    Date::Date() // Default ctor
      : Date{1980, 1, 1} {}

    Date::Date(Date const & other) // Copy ctor
      : Date{other.year, other.month, other.day} {}
    ```
  ],
  [
    _Member variables_ can have a _default value_ assigned, so called _`NSDMI` = Non-Static Data Member Initializers._
    These values are used if the member is not present in the initializer list of the constructor.
    Get overridden by initializer list. Useful if multiple constructors initialize class similarly, avoids duplication.
  ],
  [
    ```cpp
    class Date { // in Date.hpp
      int year{9999}, month{12}, day{31}; // NSDMI
      Date();
    }
    // in Date.cpp
    Date::Date() {} // initializes default values
    ```
  ],
)

=== Implementing Member Functions
#grid(
  [
    - _Don't violate invariant_: Leave object in valid state.
    - _Implicit `this` object_: Is a pointer, member access with arrow #no-ligature[`->`].\
      ```cpp this->``` can usually be omitted, only necessary when a naming ambiguity exists.
    - _Declare `const` if possible!_
    - Must _not modify members_ and can only call `const` functions if `const`.

    Otherwise member functions have _access_ to _all_ other members.
  ],
  [
    ```cpp
    // Date.cpp
    #include "Date.hpp"
    auto Date::isValidDate() const -> bool {
      if (day <= 0) { return false; }
      switch (month) {
        case 1: case 3: case 5: case 7: case 8:
        case 10: case 12:
          return day <= 31;
        case 4: case 6: case 9: case 11:
          return this->day <= 30;
        case 2:
          return day <= (isLeapYear(year) ? 29:28);
        default:
          return false;
      }
    }
    ```
  ],
)

=== Implementing Static Member Functions
#grid(
  [
    No `this` object, cannot be `const`.\
    No `static` keyword in the implementation.

    Call with `<classname>::<member>()`:\
    ```cpp Date::isLeapYear(2016);```
  ],
  [
    ```cpp
    #include "Date.hpp"
    auto Date::isLeapYear(int year) -> bool {
      if (year % 400 == 0) { return true; }
      if (year % 100 == 0) { return false; }
      return year % 4 == 0;
    }
    ```
  ],
)

=== Implementing Static Member Variables
#grid(
  [
    No `static` keyword in implementation. `static const` member can be initialized directly in the header.

    Access outside of the class with name qualifier:\
    `<classname>::<member>`
  ],
  [
    ```cpp
    // File Date.hpp
    static Date myBirthday;
    // File Date.cpp
    Date const Date::myBirthday{1996, 21, 10};
    // File Any.cpp
    #include "Date.hpp"
    auto printBirthday() -> void {
      std::cout << Date::myBirthday;
    }
    ```
  ],
)

=== Inheritance <inheritance>
#grid(
  columns: (1.2fr, 1fr),
  [
    #hinweis[#cppr("language/derived_class")[CPPReference: Derived Classes]]\
    Base classes are specified after the name:\
    `class <name> : [visibility] <base1>, ..., <baseN>`. _Multiple inheritance_ is possible, but should be avoided.
    Inheritance can specify a _visibility_, limits the maximum visibility of the inherited members
    #hinweis[(i.e. private inheritance turns all `public` and `protected` members of the base class `private`)].\
    If _no visibility_ is specified, the default of the inheriting class is used
    #hinweis[(`class` $->$ `private`, `struct` $->$ `public`)].

    If the subclass is not a `class` but a `struct`, the keyword `"public"` is not needed.
  ],
  [
    ```cpp
    class Base {
      private:
        int onlyInBase;
      protected:
        int baseAndInSubclasses;
      public:
        int everyoneCanFiddleWithMe;
    };
    class Sub : public Base {
      // can see baseAndInSubclasses and
      // everyoneCanFiddleWithMe
    }
    ```
  ],
)

=== Sequence
The sequence of initialization is important, if there are multiple base classes.
The base class constructor should come _before_ the initialization of members.

```cpp
class DerivedWithCtor : public Base1, public Base2 {
  int member_var;
public:
  DerivedWithCtor(int i, int j) : Base1{i}, Base2{}, member_var{j} {}
};
```

For more details on inheritance, see chapter @dynamic-polymorphism.\
For Template Syntax of classes, see chapter @class-templates.

== Operator Overloading
#hinweis[#cppr("language/operators")[CPPReference: Operator Overloading]]
#h(1fr) ```cpp #include <compare>```
#grid(
  [
    Custom operators can be _overloaded_ for user-defined types. Declared like a function, with a special name.
  ],
  [
    ```cpp
    auto operator op(<parameters>) -> <returntype>
    <returntype> operator op(<parameters>)
    ```
  ],
)

Operators can be implemented to _simplify_ the handling with classes.
For example, you can override the #no-ligature[`==`] operator to see if two dates in the `Date` class are equal,
or override the relational comparison operators #no-ligature[`<`, `>`, `<=`, `>=`] to order dates.\
_Operators should be implemented reasonably!_ Their semantic should be natural and lead to no surprises for the user:
"When in doubt, do as the ints do"

Unary operators #hinweis[(like `!` or `++`)] take one, binary operators #hinweis[(like `<` or `+=`)] take two parameters.
The second parameter #hinweis[(often called _right hand side (`rhs`)_)] does not necessarily need to be the same type
as the first #hinweis[(often called _left hand side (`lhs`)_)]. If the operator is implemented inside of a class,
the left-hand side is given _implicitly through `this`_.

If the operators do not modify anything #hinweis[(i.e comparison)], they should be `const` and _`rhs`_ should be _`const &`_.

Overloadable operators: #no-ligature[`+`, `-`, `*`, `/`, `%`, `^`, `&`, `|`, `~`, `!`, `,`, `=`, `<`, `>`, `<=`, `>=`, `++`, `--`,
`<<`, `>>`, `==`, `!=`, `&&`, `||`, `+=`, `-=`, `/=`, `%=`, `^=`, `&=`, `|=`, `*=`, `<<=`, `>>=`, `[]`, `()`, `->`, `->*`,
`new`, `new[]`, `delete`, `delete[]`, `<=>`]\
Non-overloadable operators: `::`, `.*`, `.`, `?:`

#pagebreak()

=== Three-Way-Comparison
#hinweis[#cppr("utility/compare/compare_three_way")[CPPReference: `std::compare_three_way`]]\
Before C++20, all relational operators #no-ligature[`<`, `>`, `<=`, `>=` and equality operators `==`, `!=`] had to be
implemented _separately,_ leading to a lot of boilerplate code.

The _three-way-comparison operator_ _#no-ligature[`<=>`]_ #hinweis[(informally called Spaceship Operator)] can be
implemented to provide all relational comparisons at once. It has a _special return type_ based on how strongly comparable
the elements are, see @ordering.\
_The equality operator #no-ligature[`==`]_ still needs to be implemented _manually_ due to differing return types,
however it can be implemented by calling the spaceship operator. It also implicitly overrides #no-ligature[`!=`] for inequality.

#no-ligature[
  ```cs class Date {
    int year, month, day;
   public:
    auto operator<=>(Date const& right) const -> std::strong_ordering {
      // the left hand side has an implicit 'this->'
      if (year != right.year) { return year <=> right.year; }
      if (month != right.month) { return month <=> right.month; }
      return day <=> right.day;
    }
    auto operator==(Date const& right) const -> bool {
      // implemented by calling <=> and checking if result is equal.
      // '*this' to get the value of the current/lhs object (because 'this' is a pointer)
      return (*this <=> right) == std::strong_ordering::equal;
    }
  };
  ```
]

The compiler can _generate_ the three-way-comparison operator by _defaulting_ it.
The default compares every member of both objects in definition order with the spaceship operator.
This implicitly generates the equality operator as well.

#no-ligature[
  ```cpp
  class Date {
    int year, month, day;
   public:
    // First compares year, then month, then day with the <=> operator
    auto operator <=>(Date const& right) const = default; // parameter name "right" is optional
    // Uses std::strong_ordering as return type, but can be changed:
    // auto operator <=>(Date const& right) const -> std::weak_ordering = default;
  }
  ```
]

=== Free Operators
Operators are called free operators when they are implemented _outside_ of a class.
While _inside_ of a class, the first parameter was given implicitly by the `this` pointer,
free operators need to specify it explicitly.\
_There are some limitations:_ Assignment can only be implemented as a member operator,
while the `<<` and `>>` operators dealing with streams can only be implemented as free operators.

```cpp
class Date {
  int year, month, day;
public:
  auto operator <(Date const& right) const -> bool {
    return year < right.year && month < right.month && day < right.day;
  }
};
// Operators can reuse code from other operators.
// This applies to all operators, not just free operators
inline auto operator >(Date const& left, Date const& right) -> bool { return right < left; }
inline auto operator >=(Date const& left, Date const& right) -> bool { return !(left < right); }
inline auto operator <=(Date const& left, Date const& right) -> bool { return !(right < left); }
// ...
```

#pagebreak()

=== Examples: Stream and input/output operators
To input or output data from/to a class, the `<<` and `>>` operators are often _overloaded._
They must be implemented as _free operators_ and require a reference to their respecting stream type as their _first parameter_
#hinweis[(```cpp std::istream&``` / ```cpp std::ostream&```)] and a object reference to read/write from/to as their _second parameter_.
Their return type is the same stream again, so multiple consecutive writes/reads are possible #hinweis[(Chaining)].

The operators also use the _`inline` keyword_. This is because the definition inside of the header can appear
in multiple translation units and the linker may see it multiple times. Normally, this would cause a compile error,
but with `inline` we ask the linker not to worry about it and "just pick one".

==== Print class members
_`"<<"`_ must be a _free function_. To keep the class _encapsulation intact_, the printing is delegated to a member function,
#hinweis[(here `print()`)] so the operator does not need to access private class members directly
#hinweis[(often done via `friend` operator -- bad design!)].
The second parameter with the object reference `date` and the `print()` member function can be `const`, as nothing is modified.

#grid(
  columns: (2fr, 1.1fr),
  [
    ```cpp
    // Date.hpp
    #include <ostream>
    class Date {
      int year, month, day;
     public:
      auto print(std::ostream& os) const -> void {
        os << year << "/" << month << "/" << day;
      }
    };
    inline auto operator <<(std::ostream& os, Date const& date)
      -> std::ostream& {
      date.print(os); return os;
    }
    ```
  ],
  [
    ```cpp
    // Any.cpp
    #include "Date.hpp"
    #include <iostream>

    auto printBirthday() -> void {
      std::cout << Date::myBirthday;
    }
    ```
  ],
)

==== Create new instance by reading from input
_`">>"`_ must be a _free function_. When reading input, it is always a good idea to _validate_ that input.
Unlike the `<<` operator, the object reference parameter `date` _cannot be `const`_, as `date` is modified
by assigning it a new `Date` instance.

#grid(
  columns: (2fr, 1.1fr),
  [
    ```cpp
    // Date.hpp
    #include <ostream>
    class Date {
      int year, month, day;
     public:
      auto print(std::ostream& os) const -> void {
        os << year << "/" << month << "/" << day;
      }
    };
    inline auto operator >>(std::istream& is, Date& date)
      -> std::istream& {
      int year{-1}, month{-1}, day{-1};
      // discard vars to get rid of the date separators
      char sep1, sep2;
      is >> year >> sep1 >> month >> sep2 >> day;
      try {
        date = Date{year, month, day};
        is.clear();
      } catch (std::out_of_range const& e) {
        // validation inside the 'Date' ctor failed
        is.setstate(std::ios::failbit);
      }
      return is;
    }
    ```
  ],
  [
    ```cpp
    // Any.cpp
    #include "Date.hpp"
    #include <iostream>

    auto readDate() -> Date {
      Date date{};
      std::cin >> date;
      return date;
    }
    ```
  ],
)

=== Ordering <ordering>
#hinweis[
  #cppr("compare/strong_ordering")[CPPReference: std::strong_ordering],
  #cppr("compare/weak_ordering")[CPPReference: std::weak_ordering],
  #cppr("compare/partial_ordering")[CPPReference: std::partial_ordering]
]\
The three-way-comparison returns a _ordering type_ instead of a bool.
There are different types of orders to choose from depending on the elements to compare.

==== Strong Order
#no-ligature[
  ```cpp auto operator <=> (Date const& right) const -> std::strong_ordering;```
]
#grid(
  columns: (1.4fr, 1fr),
  [
    Values that are equivalent are _indistinguishable_.\
    Either `"a < b"`, `"a == b"` or `"a > b"` must be true.\
    #hinweis[(For example, `int`s or `Date`s.)]
  ],
  [
    #small[
      ```
      - std::strong_ordering::less for a < b
      - std::strong_ordering::equivalent or
        std::strong_ordering::equal for a == b
      - std::strong_ordering::greater for a > b
      ```
    ]
  ],
)

==== Weak Order
#no-ligature[
  ```cpp auto operator <=> (Date const& right) const -> std::weak_ordering;```
]
#grid(
  columns: (1.4fr, 1fr),
  [
    Values that are equivalent _may be distinguishable_.\
    Either `"a < b"`, `"a == b"` or `"a > b"` must be true.\
    #hinweis[(For example `string`s, when letter case is ignored, i.e. `Hello` and `hello` are equivalent, but not equal)]
  ],
  [
    #small[
      ```
      - std::weak_ordering::less for a < b
      - std::weak_ordering::equivalent for a == b
      - std::weak_ordering::greater for a > b
      ```
    ]
  ],
)

==== Partial Order
#no-ligature[
  ```cpp auto operator <=> (Date const& right) const -> std::partial_ordering;```
]
#grid(
  columns: (1.4fr, 1fr),
  [

    Values that are equivalent _may be distinguishable_.\
    `"a < b"`, `"a == b"` and `"a > b"` can all be false.\
    #hinweis[(For example `double`, as `NaN` with itself always compares to `false`)]
  ],
  [
    #small[
      ```
      - std::partial_ordering::less for a < b
      - std::partial_ordering::equivalent for a == b
      - std::partial_ordering::greater for a > b
      - std::partial_ordering::unordered for
        none of the above
      ```
    ]
  ],
)
