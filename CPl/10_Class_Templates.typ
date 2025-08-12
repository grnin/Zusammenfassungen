#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Class Templates <class-templates>
#hinweis[#cppr("language/class_template")[CPPReference: Class template]]\
In addition to functions, class types can have template parameters as well. They offer _compile-time polymorphism_.

#definition[
  `template <Template-Parameter-List> class TemplateName { /* ... */ }`\
  `template <typename T> class Sack { /* ... */ }`
]
A class template provides a type with _compile-time parameters_. Data members can depend on template parameters.
Function members are _implicit template functions_ with the class' template parameters.

*Note:* Function members can be defined as template member functions with _additional_ template parameters.
They will then have the template parameter of their class, as well as the newly defined ones.

=== Example Usage <example-usage-class-template>
#grid(
  columns: (1.1fr, 1fr),
  [
    ```cpp
    template <typename T> // One template parameter
    class Sack {
      using SackType = std::vector<T>;
      // "typename" keyword required, create new type
      // size_type is a dependent name
      using size_type = typename SackType::size_type;
      SackType theSack{};
    public:
      auto empty() const -> bool {
        return theSack.empty();
      }
      auto size() const -> size_type{
        return theSack.size();
      }
      auto putInto(T const & item) -> void {
        theSack.push_back(item);
      }
      // Member function forward declaration
      auto getOut() -> T;
    };
    ```
  ],
  [
    ```cpp
    // Example for implementing member function
    // outside of a class, requires 'template' KW
    template <typename T>
    auto Sack<T>::getOut() -> T {
      if (empty()) {
        throw std::logic_error{"Empty Sack"};
      }
      auto index = static_cast<size_type>(
        rand() % size()); // pick random element

      T return_value{theSack.at(index)};
      theSack.erase(theSack.begin() + index);
      return return_value;
    }
    // Concept for Sack's T:
    // - T is assignable (implied by std::vector)
    // - T is copyable (push_back & copy
    //   constructor in 'return_value')
    ```
  ],
)

== Type Aliases and Dependent Names
#hinweis[
  #cppr("language/type_alias")[CPPReference: Type alias],
  #cppr("language/dependent_name")[CPPReference: Dependent names]
]\
It is common for template definitions to define type aliases in order to _ease their use_.
Less typing and reading, single point to change the aliased type. This could even be a template itself
#hinweis[(Outdated `typedef` keyword does not allow templates)]. These are called _Type Aliases_ or _Alias Templates_.

#definition[
  `using Typename = AliasedType; ->` #sym.space ```cpp using SackType = std::vector<T>;```
]

=== `typename` for Dependent Names
#hinweis[#cppr("keyword/typename")[CPPReference: `typename` keyword]]

Within the template definition you might use names that are directly or indirectly _depending_ on _template parameter_
#hinweis[(i.e. ```cpp std::vector<T>``` depends on `T`)].
The compiler assumes that a name is either a variable or a function name.
If a name should be interpreted as a type, you have to explicitly tell the compiler this with the _`typename` keyword_.
When the _`typename` keyword_ is _required,_ you should extract the type into a _type alias_.

#definition[
  ```cpp using size_type = typename SackType::size_type;```
]

#pagebreak()

=== Example
#grid(
  [
    ```cpp
    // Accessing a member of a template parameter
    template <typename T>
    void accessTsMembers() {
      typename T::MemberType m{}; // keyword req.
      T::StaticMemberFunction(); // no keyword
      T::StaticMemberVariable; // no keyword
    }
    ```
  ],
  [
    ```cpp
    struct Argument {
      struct MemberType{};
      static auto StaticMemberFunction() -> void;
      static int StaticMemberVariable;
    }
    ```
  ],
)

```cpp
// Indirect dependency, 'typename' necessary because 'size_type' depends on T
template<typename T>
class Sack { using size_type = typename std::vector<T>::size_type; }
```

=== Members Outside of Class Template
#grid(
  [
    Members can be defined out ouf the class template, but the syntax is a bit ugly.
    They still must be _inline_, but it is _implicitly_ inline as it is a function template.\
    For a _full example_ see @example-usage-class-template.
  ],
  [
    ```cpp
    template <typename T> // repeat template decl.
    auto Sack<T>::getOut() -> T // Member signature
    Sack<T>:: // Template ID of Sack as name scope
    ```
  ],
)

=== Rules
- Define class templates _completely in header files_. The _member functions_ can be directly in the class template
  #hinweis[(recommended)] or as an inline function template in the _same_ header file.
- When using language elements _depending_ directly or indirectly on a _template parameter_, you must specify
  _`typename`_ when it is naming a type.
- _`static` member variables_ of a template class can be defined in the header without violating ODR
  #hinweis[(One definition rule)], even if included in _several_ compilation units. They can even be declared _inside_
  the class template, this requires the _`inline`_ keyword. #hinweis[(i.e. ```cpp inline static int member{sizeof(T)}```)]

Static template members can be "locked" to a specific type.
#grid(
  columns: (1fr, 1.2fr),
  [
    ```cpp
    // staticMember.hpp
    template <typename T>
    struct StaticMember {
      inline static int member{sizeof(T)};
    };
    // setMemberTo42.cpp
    #include "staticMember.hpp"
    auto setMemberTo42() -> int {
      using MemberType = StaticMember<int>;
      MemberType::member = 42;
      return MemberType::member; }
    ```
  ],
  [
    ```cpp
    #include "staticMember.hpp"
    #include <iostream>

    auto setMemberTo42() -> int;

    auto main() -> int {
      std::cout << StaticMember<double>::member; // 8
      std::cout << StaticMember<int>::member; // 4
      std::cout << setMemberTo42(); // 42
      std::cout << StaticMember<int>; // 42
    }
    ```
  ],
)

== Inheritance
When a class template _inherits_ from another class template, _name-lookup_ can be surprising!

#grid(
  [
    ```cpp
    template <typename T>
    struct Parent {
      auto foo() const -> int {
        return 42;
      }
      static int const bar{43};
    };
    auto foo() -> int {
      return 1;
    }
    double const bar{3.14};
    ```
  ],
  [
    ```cpp
    template <typename T>
    struct Child : Parent<T> {
      auto demo() const -> void {
        out << bar;          // 3.14
        out << this->bar;    // 43
        out << Child::bar;   // 43
        out << foo();        // 1
        out << this->foo();  // 42
        out << Child::foo(); // 42
      }
    }
    ```
  ],
)

*Rule:* Always use `this->` or the class `name::` to refer to inherited members in a template class.
If the name could be a _dependent name_, the compiler will not look for it when compiling the template definition
#hinweis[(Thus eventual unqualified variables/functions will be accessed, see example above)].
Checks might only be made for dependent names at template usage.


== Partial Specialization
#hinweis[
  #cppr("language/partial_specialization")[CPPReference: Partial template specialization],
  #cppr("language/template_specialization")[CPPReference: Explicit (full) template specialization]
]\
Like function template overloads, we can provide "template specializations" for class templates.
These can be _partial_ still using a template parameter, but provide some arguments.
Or complete _explicit_ specializations, providing all arguments with concrete types #hinweis[(No more `T`'s)].

One must declare the _non-specialized_ template _first._ The _most specialized version that fits is used_.

#grid(
  columns: (1fr, 1.2fr),
  [
    ```cpp
    // Partial Specialization for all pointers
    // Template parameter remains
    template <typename T>
    struct Sack<T *>;
    ```
  ],
  [
    ```cpp
    // Explicit Specialization for std::string
    // No template parameter
    template <>
    struct Sack<char const *>;
    ```
  ],
)

Class template specializations can have _any content_, even no content at all.
There is really no relationship apart from the template name.

=== Preventing Creation of a partial specialization
#grid(
  [
    To prohibit instantiating a class is to prohibit the ability to its destructor.
    _If an object cannot be destroyed, it cannot be created._
    This can be done by declaring its _destructor_ as _`= delete;`_.
  ],
  [
    ```cpp
    template <typename T>
    struct Sack<T *> { ~Sack() = delete; }
    // now a sack of pointers cannot be created
    ```
  ],
)

Useful to disable storing pointers in an object, as all pointed-to objects would need to outlive the container,
which is hard to achieve. And someone must clean up the objects nevertheless.


== Adapting Standard Containers
#grid(
  columns: (1fr, 2fr),
  [
    Possible adaptations that could be implemented by you #hinweis[(yes, you!)]
    - _`SafeVector`:_ no undetected out-of-bounds access
    - _`IndexableSet`:_ provide `[]` oper.
    - _`SortedVector`:_ guarantee sorted order of elements

    To build these extensions, create a template class inheriting from template base class and
    _inherit the constructors of the standard container_
    #hinweis[(instantiates the container directly when instantiating the extension class)].
  ],
  [
    ```cpp
    template<typename T>
    struct SafeVector : std::vector<T> {
      using container = std::vector<T>;
      using container::container; // inherits constructors
      using size_type = typename container::size_type; //type alias
      using reference = typename container::reference;
      using const_reference = typename container::const_reference;
      reference operator[](size_type index) {
        return this->at(index);
      }
      const_reference operator[](size_type index) const {
        return this->at(index);
      }
    }
    // No std::vector member variable is needed, because a
    // vector is automatically created when creating a SafeVector
    ```
  ],
)
_Caution:_ no safe conversion to base class, no polymorphism

=== Extending the Sack Template
What should it be able to do?
#grid(
  [
    - Create a `Sack<T>` using iterators to fill it\
      #v(-0.5em)
      ```cpp
      std::vector values{1, 5 , 7, 12};
      Sack<int> sack{begin(values), end(values)};
      ```

    - Create a `Sack<T>` of multiple default values
      ```cpp Sack<unsigned> sack(10, 3);```

    - Create a `Sack<T>` from a initializer list\
      ```cpp Sack<char> charSack{'a', 'c', 'a', 'b'};```
  ],
  [
    - Obtain copy of contents to store in a `std::vector`
      #v(-0.5em)
      ```cpp
      Sack<int> sack{1, 2, 3};
      auto v = static_cast<std::vector<int>>(sack);
      ```

    - Auto-deducing `T` for a `Sack<T>` from an initializer list
      ```cpp Sack c{'n', 'g'}; Sack i{begin(v), end(v)};```

    - Allow to vary the type of the container to be used
      ```cpp Sack<unsigned, std::set> sack{1, 3, 9};```
  ],
)

#pagebreak()

=== Filling a `Sack` from `std::initializer_list<T>`
#grid(
  columns: (1.1fr, 1fr),
  [
    Like a `std::vector`, we can create a `Sack` from an initializer list by creating a constructor
    that delegates that task to the corresponding constructor of `std::vector`.
    Requires ```cpp #include <initializer_list>```.

    But adding this user-declared constructor removes the implicit default constructor, so we need to default it.
  ],
  [
    ```cpp
    template <typename T>
    class Sack {
    public:
      Sack() = default; // Retain default ctor
      Sack(std::initializer_list<T> values)
        : theSack(values) {}
    };
    Sack<int> sack{5, 8, 6, 7};
    ```
  ],
)

=== Extracting a `std::vector` from a `Sack<T>`
#grid(
  [
    We can also implement direct casting from `Sack` into `std::vector` by implementing a cast operator `()`.

    ```cpp
    template <typename Elt>
    explicit operator std::vector<Elt>() const {
      return std::vector<Elt>(
        begin(theSack), end(theSack));
    }
    Sack<int> sack{1, 2, 3};
    auto vec = static_cast<std::vector<int>>(sack);
    ```
  ],
  [
    Alternatively, this could also be done by implementing a member function template, i.e. `.asVector()`.

    ```cpp
    template <typename Elt = T>
    auto asVector() const {
      return std::vector<Elt>(
        begin(theSack), end(theSack));
    }
    Sack<int> sack{1, 2, 3};
    auto doubleVec = sack.asVector<double>();
    ```
  ],
)

== Deduction Guides
#hinweis[#cppr("language/class_template_argument_deduction")[CPPReference: Class template argument deduction (CTAD)]]\
Class template arguments can usually be _determined by the compiler_.
The behavior is similar to pretending as if there was a factory function for each constructor
#hinweis[(i.e. a ```cpp make_sack(T content)``` that returns a `Sack<T>` with the content in it)]

=== User Provided Deduction Guides
In some cases, the compiler does deduct the _wrong template_. Consider the example below:
We'd like to create a `Sack` from a pair of iterators, just like `std::vector` can.
We implemented it by creating a _Constructor template_ that takes two iterators and delegated  the task to the
respective `std::vector` constructor.

#grid(
  [
    ```cpp
    template <typename T>
    class Sack {
      template <typename Iter>
      Sack(Iter begin, Iter end)
        : theSack(begin, end);
    }
    ```
  ],
  [
    ```cpp
    TEST_CASE("suprisingDeduction") {
      std::vector values{1, 2, 3, 4, 5, 6};
      Sack sack{begin(values), end(values)};
      REQUIRE(sack.size() == values.size());
      // results in "2 == 6"
    }
    ```
  ],
)

```cpp Sack sack{begin(values), end(values)}``` will not initialize the sack with the contents of the iterator range,
but will place the two iterators themselves into the `Sack`. This is because the compiler doesn't know which type
the vector should contain -- _the template type `Iter` has no relation with `T`_.
In this case, it has deduced that `T` is of type `std::vector<int>::iterator` instead of the `int` we expected.

We can easily fix this on the call-side by replacing the `{}` with `()` when initializing the `Sack`:\
```cpp Sack sack(begin(values), end(values));```\
But what if we want to prevent this problem entirely?

_User-defined deduction guides_ that show the compiler when to use what template can be specified in the same scope
as the template. Usually after the template definition itself.

It might be necessary for a _complex case_, for example if the constructor template parameters do not map directly
to the class parameters. Most of the time, the deduction guide is also a template and looks similar to a
free-standing constructor declaration.

#definition[
  `TemplateName(ConstructorParameters) -> TemplateID;`
]

#pagebreak()

*Example:*
#v(-0.5em)
```cpp
template <typename Iter>
/* Constructor signature */                 /* Deduced template instance */
Sack(Iter begin, Iter end) -> Sack<typename std::iterator_traits<Iter>::value_type>;
// Meaning: Use this constructor if template type 'Iter' is a iterator of value types.
```

#grid(
  [
    After adding the deduction guide, the test case above for deducing the template argument from iterators works correctly.
    But now, using the constructor for creating a `Sack` with n-times a value doesn't work anymore.
    An _additional template_ is required so this constructor can be called again.
    No deduction guide is needed there because the compiler can deduce `T` for `Sack<T>` from the `value` parameter.
  ],
  [
    ```cpp
    Sack sack(10, 3u); // calls the Iter templ :(
    template<typename Iter>
    // Fails, because 'unsigned' is not an iterator
    Sack(unsigned begin, unsigned end) -> Sack<typename std::iterator_traits<unsigned>::value_type>
    // Explicit constructor for n-times value sack
    Sack(size_type n, T const & value)
      : theSack(n, value)
    ```
  ],
)

== Template Template Parameter
#grid(
  [
    A template can take other templates as parameters, a _template template parameter_.
    This allows us to swap the underlying container of our `Sack`.

    The template template parameter must specify the _number of parameters_.
    But standard containers usually take more than just the element type.
    We can fix this by leaving the number of template parameters _unspecified_ with the variadic template `template<typename...>`
    to allow an arbitrary number of parameters.

    Our _`getOut()`_ function also needs a small rewrite to work with container without index access.
  ],
  [
    ```cpp
    template <typename T,
      template<typename...> typename Container>
    class Sack { /* ... */ };
    // Use Sack with a different container
    Sack<unsigned, std::set> aSack{1,2,3}

    auto getOut() -> T { // generalize for all
      throwIfEmpty();    // types of container
      auto index = static_cast<size_type>
        (rand() % size());
      std::advance(it, index);
      T return_value{*it};
      theSack.erase(it); return return_value;
    }
    ```
  ],
)

C++ allows _default arguments_ for function and template parameters:
```cpp
template <typename T, template<typename...> typename Container = std::vector>
class Sack;
```

== Non-Type Template Parameters
#grid(
  columns: (1fr, 2fr),
  [
    Useful for specifying _compile-time values_ #hinweis[(i.e. size of an `std::array`)].\
    If the type of the non-type template parameter should be flexible, _`auto`_ can be used.
  ],
  [
    ```cpp
    template <typename T, std::size_t n>
    // template <typename T, auto n> can be used as well
    auto average(std::array<T, n> const & values) {
      auto sumOfValues = accumulate(begin(values), end(values), 0);
      return sumOfValues / n;
    }
    ```
  ],
)

== Variable Templates
#grid(
  [
    #hinweis[#cppr("language/variable_template")[CPPReference: Variable template]]\
    It is also possible to specify a template for a variable.
    The template can be specialized and is usually a `constexpr`.
    The purpose is to provide compile-time predicates and properties of types, which is useful for template meta programming.
  ],
  [
    ```cpp
    template<typename T> // cast pi to other types
    constexpr T pi = T(3.14159265358979);
    template<typename T> //for all types except int
    constexpr bool = is_integer = false;
    template<> // template for just int
    constexpr bool = is_integer<int> = true;
    ```
  ],
)

=== Best practices
- Create #hinweis[(partial)] _specialization_ if the class template should behave differently for specific arguments
- Specify _type aliases_ to be expressive and have only a single location to adapt them
- Access _inherited members_ from other class templates with _#no-ligature[`this->`]_ or _`base::`_
- _Inherit constructors_ when deriving from a standard container
- _Deduction guides_ help the compiler deducing the template arguments
