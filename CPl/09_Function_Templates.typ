#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Function Templates
#hinweis[
  #cppr("language/templates")[CPPReference: Templates],
  #cppr("language/function_template")[CPPReference: Function templates]
]

#definition[
  ``` template <Template-Parameter-List> FunctionDefinition```
]

Function Templates are the C++ way to _create generic code_ that can work with different types.
The keyword _`template`_ is used for declaring a template.
A _template parameter_ is a _placeholder for a type_, which can be used within the template as a type.
A type template parameter is introduced with the _`typename`_ keyword
#hinweis[(in older C++ standards, the `class` keyword was used, but it was changed as the type doesn't need to be a class)].
The template parameter list contains one or more template parameters.

*The compiler ...*
- _resolves_ the function template #hinweis[(checks which function (template) to use)]
- figures out the template _argument(s)_
- _instantiates_ the template for the arguments #hinweis[(creates code with template parameters replaced)]
- _checks_ the types for correct usage

== Template Definition
#hinweis[#cppr("language/template_parameters")[CPPReference: Template parameters]]\
Templates are usually _defined_ #hinweis[(not just declared)] in a header file, because a compiler needs to see
the whole template definition to create an instance. They are implicitly `inline`.\
_Type checking_ happens twice:
- _During definition:_ Only basic checks are performed: Syntax and resolution of names independent of the template parameters.
- _During template instantiation (writing code that calls the template):_
  The compiler checks whether the template arguments can be used as required by the template.

C++ Templates use _duck-typing_: Every type can be used as argument as long as it supports the used operations.

=== Example Usage
#grid(
  [
    ```cpp
    // Min.hpp
    template <typename T>
    auto min(T left, T right) -> T {
      return left < right ? left : right;
    }
    // T can be replaced with another
    // type when min() gets called.
    // In the example, T gets replaced
    // by int.
    ```
  ],
  [
    ```cpp
    // Smaller.cpp
    #include "Min.hpp"
    #include <iostream>

    auto main() -> int {
      int first; int second;
      if (std::cin >> first >> second) {
        auto const smaller = min(first, second);
        std::cout << "Smaller of " << first
                  << " and " << second
                  << " is: " << smaller << '\n';
      }
    }
    ```
  ],
)


== Template Concepts
#hinweis[#cppr("language/constraints")[CPPReference: Constraints and concepts]]\
A concept is the _requirements a type must fulfill_ to be usable as an argument for a specific template parameter.\
The requirements of the type `T` in the `min` template above are:
- _Comparable with itself:_ The `<` operator is used to compare two elements of type `T`
- _Copy/Move constructible:_ The template creates a new instance of `T` to return the result by value
  #hinweis[(copy/move constructible)]

C++20 allows to explicitly specify concepts to allow better checking of the template definition
#hinweis[(are all requirements fulfilled?)] and allows for easier to read error messages for failed template instantiations.
See chapter @constraints.

=== Example: What are the Concepts?
```cpp
template<typename InputIt1, typename InputIt2, typename T>
auto inner_product(InputIt1 first1, InputIt2 last1, InputIt2 first2, T init) -> T {
  while (first1 != last1) { // check if still in range of 'first'
    init = init + *first1 * *first2; // dereference the iterators, multiply values & add to sum
    ++first1; ++first2; // increment iterators of both ranges
  }
  return init;
}
```

#small[
  #table(
    columns: (1fr,) * 3,
    table.header([`InputIt1`/`InputIt2`], [`init + *first1 * *first2`], [`T`]),
    [
      - `*`: Dereferenceable
      - `++`: Prefix increment
      - `!=`: Compare `InputIt1` with itself, result convertible to `bool`
    ],
    [
      - `*`: Multiplication on `*first1` and `*first2`
      - `+`: Addition on `T` and result of above
    ],
    [
      - `=`: Assignable from result of\ `init + *first1 * *first2`
      - Copy/Move constructable due to `return` as value
    ],
  )
]

== Argument Deduction
#hinweis[#cppr("language/template_argument_deduction")[CPPReference: Template argument deduction]]\
The compiler will try to figure out the function template's arguments from the call by pattern matching
on the function parameter list. If the type is _ambiguous_, it cannot figure out the arguments.
For example, if there is a template ```cpp min(T left, T right)``` and a function calls ```cpp min(1, 1.0)```,
the compiler doesn't know if `T` should be `int` or `double`.

== Variadic Templates
#grid(
  [
    #hinweis[
      #cppr("language/pack")[CPPReference: Packs],
      #cppr("language/sizeof...")[CPPReference: `sizeof...`],
      #cppr("language/fold")[CPPReference: Fold]
    ]\
    In specific cases, the number of template parameters might not be fixed/known upfront.
    Thus the template shall take an arbitrary number of parameters, so called _Variadic Templates_.

    *Syntax: Ellipses everywhere.*
    + _Template Parameter Pack:_ In template parameter list for an arbitrary number of template parameters
    + _Function Parameter Pack:_ In function parameter list for an arbitrary number of function arguments
    + _Number of template arguments:_ After `sizeof` to access the number of elements in template parameter pack
    + _Pack Expansion:_ In the variadic template implementation after a pattern
  ],
  [
    ```cpp
    template<typename First, typename...Types>// 1.
    auto printAll(First const & first,
      Types const &...rest) -> void { // 2.
      std::cout << first;
      if (sizeof...(Types)) { // 3.
        std::cout << ", ";
      }
      printAll(rest...); // 4. (Recursion)
    }
    auto printAll() -> void { } // Base Case

    // Usage
    int i{42}; double d{1.25}; string name{"Nina"};
    printAll(i, d, name);

    // ...xy fold together
    // xy... fold out
    ```
  ],
)

The example uses _recursion_ to handle each function parameter one by one:
The value in `first` gets printed and all others in `rest` are the arguments for the recursive call,
where the first element of `rest` gets placed in `first.`

For each #hinweis[(recursive)] function call, the compiler creates an instance of the template where the template types and
function types are replaced by their actual type. However, this does not work if there are _zero parameters remaining:_
The template requires at least one argument (`first`) to be called.
To work around this, we _create a new non-template function with no arguments_ that does nothing.
It acts as our _recursive base case_.

```cpp
// What the instantiated template looks like
auto printAll(int const & first, double const & __rest0, std::string const & __rest1) {
  std::cout << first;
  if (2) { // sizeof...(Types) - Number of arguments in the pack (equals to true here)
    std::cout << ", ";
  }
  printAll(__rest0, __rest1); // rest... expansion
}
```

== Template Overloading <overloading-template>
#grid(
  [
    Multiple function templates with the _same name_ can exist, as long as they can be _distinguished_ by their parameter list.
    An overload for pointers is possible. This way, the content of _reference types_ can be compared instead of
    their pointer addresses.

    _Function templates_ and _"normal" functions_ with the same name can coexist as well.
    When called with `std::string`, the pointer overload would only compare the first `char` of the strings,
    so a non-template function specifically for string comparisons can be created.
  ],
  [
    ```cpp
    template <typename T> // regular template
    auto min(T left, T right) -> T {
      return left < right ? left : right;}

    template <typename T> // overload for pointers
    auto min(T * left, T * right) -> T * {
      return *left < *right ? left : right;}

    auto min(char const * left, char const * right)
      -> char const * { // non-template function
      return std::string{left} < std::string{right}
        ? left : right;}
    ```
  ],
)

== Generic Lambda
#grid(
  [
    Operators and member functions can be templates too. Lambdas are internally converted to templates.

    _Beware:_ Don't make operator templates too eagerly, you might end up with unexpected matches for other calls!
  ],
  [
    ```cpp
    auto const printer = [&out](auto const & e) {
      out << "Element: " << e;
    }; // converted to:
    struct __PrinterLambda {
      template <typename T>
      auto operator()(T const & e) const -> void {
        __out << "Element: " << e;
      }
      std::ostream& __out;
    };
    ```
  ],
)

== Template Gotchas
#v(-0.5em)
=== Literals and references
Because strings are _arrays of `char`s_ referenced on the heap, problems can occur if you try to _compare_ two strings
which do not have _equal size_. With the use of _String Literals_, this can be fixed #hinweis[(Conversion into `std::string`)].

#grid(
  [
    ```cpp
    template <typename T>
    auto min(T const & left, T const & right)
      -> T const & {
      return left < right ? left : right;
    }
    ```
  ],
  [
    ```cpp
    std::cout << min("C++", "Java");
    // -> error: no matching function for call to
    // 'min(const char[4], const char[5])'. Fix:
    using namespace std::string_literals;
    std::cout << min("C++"s, "Java"s);
    ```
  ],
)

=== Matching and Overloading
#grid(
  [
    Sometimes, the template might be a better match and _overload_ your function you want to call.
    `const` and non-`const` values/parameters are prone to this.

    ```cpp
    std::string small{"aa"};
    std::string capital{"ZZ"};
    std::cout <<< min(small, capital) << '\n'; //ZZ
    ```
  ],
  [
    ```cpp
    template <typename T>
    auto min(T & left, T & right) -> T {
      return left < right ? left : right;
    }
    // The function above matches, because the
    // strings aren't const.
    auto min(std::string const & left, std::string const & right) -> std::string { /* ... */ }
    ```
  ],
)

=== Invalid Template
#grid(
  [
    A temporary #hinweis[(value not stored in a variable)] might become invalid, because the lifetime
    of temporaries ends at `";"`. `const &` can extend the lifetime of a temporary, but only if it is a temporary value
    as a result of the _outermost expression_ #hinweis[(i.e. no more function calls or operators applied to the temporary)].

    ```cpp
    // Outermost expression, lifetime extended
    const std::vector<int>& v = std::vector{1, 2};
    // Vector is destroyed, 'i' access is UB!
    const int& i = std::vector{1, 2}[0];
    ```
  ],
  [
    ```cpp
    template <typename T>
    auto min(T const & left, T const & right)
      -> T const & {
      return left < right ? left : right;
    }
    std::string const & smaller = min("a"s, "b"s);
    std::cout << "smaller is: " << smaller;
    // 'smaller' is a invalid reference because the
    // arguments are only valid within min().
    ```
  ],
)
