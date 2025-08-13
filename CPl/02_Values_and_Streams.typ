#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Values and Streams
#v(-0.5em)
== Variables
`<type> <variable-name>{<initial-value>}`: #sym.space ```cpp int anAnswer{42}, int const theAnswer{42}```

Variables initialized with _empty `{}`_ are initialized with the _default value_ of this type.
Using `=` or `{}` for initialization with a value we can have the _compiler determine its type_: ```cpp auto const i = 5;```\
_Uninitialized variables_ contain _random_ values. Dangerous! Variables are best defined _as close to their use as possible_.

Every mutable global variable is a design error! They make code almost untestable.

_Naming Conventions:_ Begin variable names with a lower-case letter. Do not abbreviate unnecessarily.

=== `const`: Constants
#hinweis[#cppr("language/cv")[CPPReference: const and volatile]]\
Adding `const` in front of the name makes the variable _only assignable at initialization_ - a _constant_.\
```cpp int const theAnswer{42}```\
It is _best practice_ to use `const` whenever possible for _non-member variables_ that don't need to be updated.

=== Name visibility / Scope
A variable defined within a block is _invisible after_ the block ends.
_Redefining_ an existing variable inside a block is _not_ an error in C++.

#pagebreak()

=== Types
#hinweis[#cppr("language/types")[CPPReference: Fundamental Types]]\
- _`short`, `int`, `long`, `long long`_ #hinweis[(also available as `unsigned` variants)]
- _`bool`, `char`, `unsigned char`, `signed char`_ #hinweis[(are treated as integral numbers as well)]
- _`float`, `double`, `long double`_
- _`void`_ is special, it is the type with _no values_
- _`std::string`, `std::vector`_ #hinweis[(requires #cppr("preprocessor/include")[`#include`] of the type definition)]

== Values and Expressions
#hinweis[#cppr("language/expressions")[CPPReference: Expressions]]
#v(-0.6em)

#table(
  columns: (1fr, 1fr, auto),
  table.header([Arithmetic Expressions], [Logical Expressions], [Bit-operators]),
  [
    - *unary:* `+, -, ++, --`
    - *binary:* `+, -, *, /, %`
    #v(-0.5em)
    #hinweis[Unary have one, binary two operands]
  ],
  [
    - *unary:* `!`
    - *binary:* `&&, ||`
    - *ternary/conditional:* `? :`
  ],
  [
    - *unary:* `~` #hinweis[(complement)]
    - *binary:* `& | ^ << >>` #hinweis[(bitand, bitor, xor, shift)]
  ],
)
Unusual literals:
`5ull` #hinweis[(unsigned long long)], `0x1f` #hinweis[(int32)],`0.f` #hinweis[(float)], `1e9` #hinweis[(double)] `10⁹`,
`42.E-12L` #hinweis[(long double $42*10^(-12)$)]

=== Type Conversion
C++ provides _automatic_ type conversion if values of different types are _combined_ into an expression,
_unless in braced initialization_ like ```cpp int i{1.0}```.
- _Division_ results of integers get _rounded down_ #hinweis[(```cpp double x = 45 / 8``` evaluates to `5`)].
- _Integers_ can be automatically _converted_ to _`bool`_: `0` is `true`, every other value `false`.
- _Logical operators_ and conditional statements accept _numeric values_; however `if(5)` is probably not useful.\
  This can cause confusion, as ```cpp if(a < b < c)``` does *not* test whether `b` is between `a` and `c`.

=== Floating Point Numbers
Use _`double`_ instead of `float`. `float` is only needed if memory consumption is utmost priority
and precision and range can be traded.\
There are _legal_ double values that are _not numbers_: `NaN, +Inf, -Inf`. _Comparing_ floating points for equality (`==`)
is usually wrong, better check if it is in a certain range around the expected value.

== Strings
#hinweis[#cppr("string")[CPPReference: Strings library]]\
```cpp std::string name{"Bjarne Stroustrup"};```\
Type for representing _sequences of char_. Only 8 bit, so _no Unicode support_.
Literals like `"ab"` are _not_ of type `std::string`, but an _array of `const` characters_ which is `null` terminated.
The type of `"ab"` is therefore\ _`char const[3]`_.\
But #cppr("string/basic_string/operator%2522%2522s")[`"ab"s`] is an `std::string`.
This requires ```cpp using namespace std::literals```:

```cpp
auto printName(std::string name) -> void {
  using namespace std::literals;
  std::cout << "my name is: "s << name;
}
```

=== Capabilities
`std::string` objects are _mutable_, unlike in Java where ```java String``` objects cannot be modified.
It is possible to _iterate_ over the contents of a string.

```cpp
auto toUpper(std::string & value) -> void {
  std::transform(cbegin(value), cend(value), begin(value), ::toupper);
}
```
This changes the content of the _original_ string object.

=== Example
```cpp
#include <iostream>
#include <string>

auto askForName(std::ostream & out) -> void {
  out << "What is your name? ";
}

auto inputName(std::istream & in) -> std::string {
  std::string name{};
  in >> name;
  return name;
}

auto sayGreeting(std::ostream & out, std::string name) -> void {
  out << "Hello " << name ", how are you?\n";
}

auto main() -> int {
  askForName(std::cout);
  sayGreeting(std::cout, inputName(std::cin));
}
```

== Input and Output Streams
#hinweis[#cppr("io")[CPPReference: Input/output library]] \
`std::string` and built-in types represent _values_. Can be copied and passed-by-value. There is _no need_ to allocate memory
_explicitly_ for storing the chars. Some objects aren't values, because they can't be copied #hinweis[(i.e. I/O streams).]\
So, these _functions taking a stream object_ must take it as a _reference_, because they _provide a side-effect_ to the stream.

=== `std::cin` and `std::cout`
#hinweis[#cppr("io/cin")[CPPReference: std::cin], #cppr("io/cout")[CPPReference: std::cout]] \
`std::cin` and `std::cout` #hinweis[(character in/out)] are _predefined globals_.
Should _only_ be used in the ```cpp main()``` function.

- _The bitwise "shift" operators_ read into variables or write values to an output: ```cpp std::cin >> x; std::cout << x;```
- _Multiple values_ can be streamed at once: ```cpp std::cout << "the value is " << x << '\n';```
- The stream object is always the _first element_ in a statement, no stream after the first shift operator.
- Streams have a _state_ that denotes if I/O was successful or not. Only _`.good()`_ streams actually do I/O.\
  You need to _`.clear()`_ the state in case of an error.

=== Reading a `std::string` Value
#grid(
  columns: (0.8fr, 1fr),
  [
    Reading a `std::string` can _not go wrong_, unless the stream is already `!good()`. Reads until the first whitespace.
    The content of the `std::string` is _replaced_. Maybe it is _empty_ after reading.
  ],
  [
    ```cpp
    #include <istream>
    #include <string>
    auto inputName(std::istream & in) -> std::string {
      std::string name{}; in >> name; return name;
    }
    ```
  ],
)

=== Reading an `int` Value
#grid(
  columns: (0.8fr, 1fr),
  gutter: 1em,
  [
    Reads the first non-whitespace character, regardless if it is a number or not.
    _No error recovery_, one wrong input puts the stream into _status "fail"_. Characters _remain_ in input.

    _Boolean Conversion:_ ```cpp if (in >> age)``` is the `istream` object itself.
    It converts to `true` if the last reading operation has been successful.

    #hinweis[(More robust version see next page)]
  ],
  [
    ```cpp
    #include <istream>
    auto inputAge(std::istream & in) -> int {
      int age{-1};
      if (in >> age) {
        return age;
      }
      return -1;
    }
    ```
  ],
)

==== More robust reading an `int` Value
#grid(
  columns: (0.8fr, 1fr),
  gutter: 1em,
  [
    Read a line with `getline()` and parse it _as an integer_ until a `int` is read successfully
    or a `EOF` is returned #hinweis[(end of file)].

    Read operation in `while` condition acts as a _"did the read work?" check_.

    Use an _`std::istringstream`_ as an intermediate stream to try parsing as `int` after the original `istream`
    has already been read with `getline()`.
  ],
  [
    ```cpp
    #include <istream>
    auto inputAge(std::istream & in) -> int {
      std::string line{};
      while (getline(in, line)) {
        std::isstringstream iss{line};
        int age{-1};
        if (iss >> age) { return age; }
      }
      return -1;
    }
    ```
  ],
)

=== Chaining Input Operations
#grid(
  columns: (0.8fr, 1fr),
  gutter: 1em,
  [
    ```cpp in >> symbol``` returns the _`istream` object_ itself. So multiple _subsequent reads_ are possible,
    because the next statement would be the same as ```cpp is >> count```.

    If a previous read already _failed_, _subsequent reads_ will fail _as well_.
  ],
  [
    ```cpp
    #include <istream>
    auto readSymbols(std::istream & in) -> std::string {
      char symbol{}; int count{-1};
      if (in >> symbol >> count) {
        // Repeats symbol count-times
        return std::string(count, symbol);
      }
      return "error";
    }
    ```
  ],
)

=== Stream handling on the terminal
If the application is waiting for `EOF` and the input is coming from the terminal, you need to terminate the stream
by pressing *CTRL+D*. CTRL+Z terminates the whole application, similar to CTRL+C.

=== An `std__istream's` States
#hinweis[#cppr("io/ios_base/iostate")[CPPReference: Stream State Flags and Accessors]]\
A stream can have _different states_, depending on what the stream was fed last. A stream always starts as `good()`.

#table(
  columns: (30%, 30%, 1fr),
  table.header([State Bit Set], [Query], [Entered by]),
  [`<none>`], [`is.good()`], [initial, `is.clear()`],
  [`failbit`], [`is.fail()`], [input formatting failed],
  [`eofbit`], [`is.eof()`], [trying to read at end of input],
  [`badbit`], [`is.bad()`], [unrecoverable I/O error],
)

Formatted input on stream `is` _must_ check for `is.fail()` #hinweis[(`true` if `failbit` or `badbit` is set)] and
`is.bad()` #hinweis[(`true` if `badbit` is set)]. If the stream has failed, call `is.clear()` on it and
_consume invalid input characters_ before continuing. When reading from a `fail`-ed stream, nothing happens.

=== Dealing with Invalid Input
```cpp
auto inputAge(std::istream & in) -> int {
  while (in.good()) {              // check for good stream state
    int age{-1};
    if (in >> age) { return age; } // return if int successfully read
    in.clear();                    // remove fail flag to continue reading
    in.ignore();                   // skip the char that caused the fail (isn't a number)
  }
  return -1;                       // return on EOF
}
```

#pagebreak()

=== Formatting Output
#hinweis[#cppr("io/manip")[CPPReference: Input/output manipulators]] \
There are different _manipulators_ that can format values for input & output.

#grid(
  columns: (75%, 25%),
  [
    ```cpp
    #include <iostream>
    #include <iomanip>
    #include <ios>
    #include <cmath>

    auto main() -> int {
      std::cout << 42 << '\t' // '\t' = Tab character
                << std::oct << 42 << '\t' // octal system output
                << std::hex << 42 << '\n'; // hexadecimal system ouput
      std::cout << 42 << '\t' // std::hex is sticky, this is still in hex
                << std::dec << 42 << '\n';
      std::cout << std::setw(10) << 42 // minimal line width, not sticky
                << std::left << std::setw(5) << 43 << "*\n";
                // '...43' without std::left, '43...' with std::left
      std::cout << std::setw(10) << "hallo" << "*\n";

      double const pi{std::acos(0.5) * 3};
      std::cout << std::setprecision(4) << pi << '\n';
      std::cout << std::scientific << pi << '\n';
      std::cout << std::fixed << pi * 1e6 << '\n';
    }
    ```
  ],
  [
    *Code Output* #hinweis[(◦ = whitespace)]\
    ```
    // 42◦◦◦◦◦◦52◦◦◦◦◦◦2a
    // 2a◦◦◦◦◦◦42
    // ◦◦◦◦◦◦◦◦4243◦◦◦*
    // hallo◦◦◦◦◦*
    // 3.142
    // 3.1416e+00
    // 3141592.6536
    ```
    *Other useful manipulators*
    _`std::ws`_ / _`std::skipws`_\ consumes/skips whitespace\
    _`std::setfill()`_\ spacing char for `std::setw`
    _`std::left`_ / _`std::right`_\ sets placement of fill chars
    _`std::boolalpha`_\ display booleans as text\
    _`std::uppercase`_\ print text as uppercase
  ],
)

=== Unformatted I/O
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #hinweis[#cppr("header/cctype")[CPPReference: \<cctype>]\ ]
    The `<cctype>` header contains char conversions and char query functions like `std::tolower()` / `std::toupper()`.

    The `.get()` / `.put()` functions deal with one char at a time.
  ],
  [
    ```cpp
    #include <iostream>
    #include <cctype>
    auto main() -> int {
      char c{};
      while (std::cin.get(c)) {
        std::cout.put(std::tolower(c));
    } }
    ```
  ],
)

=== The I/O headers: `<iosfwd>`, `<istream>`, `<ostream>`, `<iostream>`
#hinweis[
  #cppr("header/iosfwd")[CPPReference: \<iosfwd>], #cppr("header/istream")[CPPReference: \<istream>],
  #cppr("header/ostream")[CPPReference: \<ostream>], #cppr("header/iostream")[CPPReference: \<iostream>]
]
- _`iosfwd`:_ Contains only the declarations for `std::istream` / `std::ostream`. _Use in header files (.hpp)._
- _`istream` / `ostream`:_ Contains implementation of the stream and operators. _Use in source files (.cpp)._
- _`iostream`:_ Contains `std::cin` / `std::cout`. _Use only in the `main()` function._
