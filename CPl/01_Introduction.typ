#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

#hinweis[
  *Hinweis:* In der Typst-Datei "00_CPPR_Settings.typ" kann mit ```typ #let EXAM_MODE = true```
  zwischen der On- und Offlineversion von CPPReference gewechselt werden, um diese Links auch in
  der CAMPLA-Prüfungsumgebung nutzen zu können.
]

= Introduction
`main()` is the program entry function. Unlike Java, C++ provides _functions_, not methods. Not all functions are bound
to a class or object. Bound functions are called _member-functions_.\
Return types are written in front of the function name #hinweis[(C style)] or as trailing return-types
#hinweis[(modern C++ style)] in declarations. `main()` implicitly returns 0.

#grid(
  [
    ```cpp
    // modern C++ function definition
    auto main() -> int { }
    ```
  ],
  [
    ```cpp
    // classic C style function definition
    int main() { }
    ```
  ],
)

The difficulties with C++ lie in the _"permissiveness" to program C_ that still compiles as C++, the _manual memory management_
#hinweis[(no garbage collection)] and the _"undefined behavior"_ in the C++ standard, where if conditions occur that aren't
described in the standard, every compiler can do what it wants, leading to unpredictable non-deterministic results.

== Compilation Process
- _\*.cpp files for source code:_ Also called "Implementation File". Contains function implementations and
  is the source of compilation - aka the "Translation Unit"
- _\*.hpp (or \*.h) files for interfaces (and templates):_ Also called "Header File". Contains declarations and definitions
  to be used in other implementation files #hinweis[(shared variables, function signatures)]. Textual inclusion through a
  pre-processor with ```cpp #include "header.hpp"```. The pre-processor then "copies" the entire content of `header.hpp`
  into the file.

C++ is usually compiled into machine code. Unlike Java, there is_ no Virtual Machine overhead_.
There are 3 phases of compilation:
- _Preprocessor:_ Textual replacement of preprocessor directives (```cpp #include```, ```cpp #define``` etc.)
- _Compiler:_ Translation of C++ code into machine code (source file to object file)
- _Linker:_ Combination of object files and existing libraries into new libraries and executables

`sayhello.cpp` $arrow.r$ _Preprocessor_ $arrow.r$ `sayhello.i` #hinweis[(preprocessed source)] $arrow.r$ _Compiler_ $arrow.r$
`sayhello.o` #hinweis[(object code)] $arrow.r$ _Linker_ $arrow.r$ `sayhello` #hinweis[(binary)]

=== Files of `sayhello`
#grid(
  columns: (auto, 1.3fr, 1.1fr),
  [
    *`main.cpp`*
    ```cpp
    #include "sayhello.hpp"
    #include <iostream>

    auto main() -> int {
      sayHello(std::cout);
    }
    ```
  ],
  [
    *`sayhello.hpp`*
    ```cpp
    #ifndef SAYHELLO_HPP_
    #define SAYHELLO_HPP_
    #include <iosfwd>

    auto sayHello(std::ostream&) -> void;
    #endif /* SAYHELLO_HPP_ */
    ```
  ],
  [
    *`sayhello.cpp`*
    ```cpp
    #include "sayhello.hpp"
    #include <ostream>

    auto sayHello(std::ostream& os)
      -> void
    {
      os << "Hi there!\n";
    }
    ```
  ],
)

The _preprocessor_ combines _`main.cpp`_ and _`sayhello.hpp`_ into  the preprocessed source _`main.i`_.
On this, the compiler creates the object file _`main.o`_ for this translation unit into machine code.
The Linker finally combines the translation units _`main.o`_ and _`sayhello.o`_ into the executable _`sayhello`_.

#grid(
  columns: (1.1fr, 1fr, 0.8fr),
  [
    *`main.i`*
    ```cpp
    <content of iosfwd>
    auto sayHello(std::ostream&) -> void;

    <content of iostream>
    auto main() -> int {
      sayHello(std::cout);
    }
    ```
  ],
  [
    *`main.o`*
    ```
    010110101... (machine code)
    <Definition of main() which calls sayHello>
    ```

    *`sayhello.o`*
    ```
    010110101... (machine code)
    <Definition of sayHello() which writes to the ostream parameter>
    ```
  ],
  [
    *`sayhello Executable`*
    ```
    010110101... (machine code)

    <executable program>
    ```
  ],
)

== Modularization & Testing
Code in C++ should be _modularized into libraries_ to allow for _unit testing_.
```cpp main()``` is usually kept _minimal,_ with only a few calls to library functions, as this code can't be unit tested.
Using library functions requires _`#include`_, normally at the beginning of the file.
The names of macros provided by the _Catch2 unit testing framework_ are written in _uppercase._

#grid(
  columns: (1.5fr, 1.5fr, 1fr),
  [
    ```cpp
    #include "sayhello.hpp"
    #include <ostream>
    auto sayhello(std::ostream & out)
      -> void
    {
      out << "Hello world!\n";
    }
    ```
  ],
  [
    ```cpp
    #ifndef SAYHELLO_HPP_
    #define SAYHELLO_HPP_

    #include <iosfwd>
    auto sayhello(std::ostream & out)
      -> void;

    #endif /* SAYHELLO_HPP_ */
    ```
  ],
  [
    ```cpp
    #include "sayhello.hpp"
    #include <iostream>

    auto main() -> int {
      sayhello(std::cout);
    }
    ```
  ],
)

== Declarations and Definitions
All things with a name must be _declared before usage_ #hinweis[(e.g. function call, type of a variable, variables)].
_Names_ for things concerning the _preprocessor_ are conventionally written in _uppercase._

=== Declaring Functions
Declarations are usually put into a _header file_ #hinweis[(`*.hpp`)], so other modules can _access_ and call them.
There can be _multiple declarations_ of the same function.

#definition[
  ```
  auto          <function-name>(<parameters>) -> <return-type>;
  <return-type> <function-name>(<parameters>);
  ```
]

#table(
  columns: (auto, 1fr),
  table.header([Term], [Description]),
  [Return Type], [Every function either returns a value of a specified type or it has return type ```cpp void```.],
  [Function Name],
  [Identifier. Overloading allowed #hinweis[(Multiple functions with the same name but different parameters)].],

  [Parameters], [A list of $0$ to $N$ parameters. Each parameter has a type and an optional name.],
  [Signature], [Combination of name and parameter types. Used for overload resolution. No return type overloading.],
)

=== Defining & Implementing Functions
Specifies what the function does. Definitions are usually put into a source file #hinweis[(`*.cpp`)].
There can only be _one definition_ of the _same function_ #hinweis[(One Definition Rule)].
Functions with _non-void return types_ must return a value on _every code path_ or throw an exception.
The compiler only throws a warning, not an error without a valid return statement, so code without it still compiles
#hinweis[(undefined behavior)]!

#definition[
  ```
  auto          <function-name>(<parameters>) -> <return-type> { /* body */ }
  <return-type> <function-name>(<parameters>)                  { /* body */ }
  ```
]

#table(
  columns: (auto, 1fr),
  table.header([Term], [Description]),
  [Return Type, Function Name, Parameters, Signature], [Same as for function declaration],
  [Body], [Implementation of the function with $0$ to $N$ statements],
)

==== One Definition Rule (ODR) <one-definition-rule>
While a program element can be _declared several times_ there can be _only one definition_ of it.
_Consequences:_ There can be only one definition of the `main()` function or any other function with the same signature.
There _must be a definition for all elements_ that are used by the code.

_`#include` guards are recommended_ in header files, so a function cannot be accidentally included multiple times
over dependencies.

=== Include Guards
Use of specific preprocessor directives to ensure that a header file is _only included once_.
A code block within an include guard is skipped on subsequent inclusions. Without it, invalid code could be generated.

#grid(
  columns: (2fr, 1fr),
  align: horizon,
  [
    #table(
      columns: (auto, 1fr),
      table.header([Directive], [Description]),
      [```cpp #ifndef SYMBOL```],
      [Checks whether the `SYMBOL` macro has already been defined. If not, the block until `#endif` is included.],

      [```cpp #define SYMBOL```], [Defines a macro named `SYMBOL` without any content.],
      [```cpp #endif```], [Closes the conditional block opened by `#ifndef`],
    )
  ],
  [
    ```cpp
    #ifndef SAYHELLO_HPP_
    #define SAYHELLO_HPP_

    #include <iosfwd>
    struct Greeter { /* ... */ };
    #endif /* SAYHELLO_HPP_ */
    ```
  ],
)

== Differences C++ and Java
#table(
  columns: (1fr, 1.3fr),
  table.header([C++], [Java]),
  [
    Allocates memory for variables on definition _on the stack_.
    No _explicit heap memory_ needed. No indirection and space overhead.\
    ```cpp Type name{};```
  ],
  [
    Objects are placed on the _heap_ #hinweis[(as references)] and a reference to this heap memory is placed on the stack.\
    Exception: Primitive values (`int`, `float`, `boolean`).\
    ```java Type name = new Type();```
  ],

  [
    Assigning an object to another object results in _two different objects_ on the stack.
    ```cpp
    // Copied values
    Point p1{1, 20}; point p2{p1};
    ```
  ],
  [
    Because only a _reference_ is stored, the reference points to the _same data on the heap_,
    modifications affect both variables.
    ```java
    // shared values
    Point p1 = new Point(1,2); Point p2 = p1;
    ```
  ],
)

Due to C++'s _allocation implementation_, functions can mix and match the two different types of parameters:

- _Value Parameter:_ No side-effect on the call-site, because the elements get copied #hinweis[(call by value)]
- _Reference Parameter:_ Side-effect on the call-site. Needs to be explicitly defined with an `&`:\
  ```cpp Point & x``` #hinweis[(call by reference)].

A function has a _side effect_ if it does more than reading its parameters and returning a value to its callee,
i.e. modifying non-local variables #hinweis[(by-reference-parameters, global variables)], performing I/O or throwing errors.
