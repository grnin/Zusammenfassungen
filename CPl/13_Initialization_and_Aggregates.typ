#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Initialization & Aggregates
#grid(
  [
    In C++, there are six different types of initialization:
    + _Default_ Initialization
    + _Value_ Initialization
    + _Direct_ Initialization
    + _Copy_ Initialization
    + _List_ Initialization
    + _Aggregate_ Initialization
  ],
  [
    They have four general syntaxes, the kind depends on the context.
    + Nothing
    + `( expression list )`
    + `= expression`
    + `{ initializer list }`
  ],
)

== Default Initialization
#grid(
  [
    #hinweis[#cppr("language/default_initialization")[CPPReference: Default initialization]]\
    The simplest form of initialization: Simply _don't provide an initializer_.
    The effect depends on the kind of entity to declare. Does not work with references!
    It also doesn't necessarily work with `const`, as the object must have a valid value.
    Default initialized entities _can be dangerous_ #hinweis[(i.e. default initialized variables contain a random value)].
    _Should be avoided due to possible undefined behavior!_

    *Effects:*
    - _`static` variables_ are _zero initialized_ first, then their type's default constructor is called.
      If the type cannot be default constructed, the program is ill-formed!
    - _Non-`static`_ integer and floating point variables are _uninitialized_
    - Objects of _`class` types_ are constructed using their default constructor
    - _Member variables_ not in a constructor initializer list are _default initialized_
    - _Arrays_ initialize all elements according to their type
  ],
  [
    ```cpp
    int global_variable; // implicitly static

    auto di_func() -> void {
      static long local_static;
      long local_variable;
      std::string local_text;
    }

    struct di_class {
      di_class() = default;
      char member_var; // not in ctor init list
    };

    struct no_default_ctor {
      no_default_ctor(int x);
    };
    no_default_ctor static_instance; // error!

    auto print_uninitialized() -> void {
      int my_number; // undefined behavior
      std::count << my_number << '\n';
    }
    ```
  ],
)

== Value Initialization
#grid(
  [
    #hinweis[#cppr("language/value_initialization")[CPPReference: Value initialization]]\
    Initialization is performed with empty `()` or `{}`. Using `{}` is preferred, since it works in more cases.
    It _invokes the default constructor_ for class types.
  ],
  [
    ```cpp
    auto vi_function() -> void {
      int number{};
      std::vector<int> data{};
      int actually_a_function(); // error!
    }
    ```
  ],
)

== Direct Initialization
#grid(
  [
    #hinweis[#cppr("language/direct_initialization")[CPPReference: Direct initialization]]\
    Similar to value initialization, except the `()` or `{}` _contain a value_.
    If `{}` are used, direct initialization is only used if the object is not a `class` type.
    Otherwise, list initialization is used. Danger of _most vexing parse_ with `()`, thus `{}` is preferred.
  ],
  [
    ```cpp
    auto diri_function() -> void {
      int number{69};
      std::string text("CPl");
      word vexing(std::string()); // dangerous!
    }
    ```
  ],
)

=== Most Vexing Parse
The compiler can interpret the following statement in two different ways:\
```cpp word vexing(std::string());```
- _Initialization of a variable_ called `vexing` of type `word` with a value-initialized `std::string()`
- _Declaration of a function_ called `vexing` that returns `word` and taking an unnamed pointer
  to a function returning an `std::string`

While the first one is what we would expect, the second is what the standard requires! Therefore, prefer `{...}`

== Copy Initialization
#grid(
  [
    #hinweis[#cppr("language/copy_initialization")[CPPReference: Copy initialization]]\
    Initialization using `=`. If the object is a `class` type and the right-hand side has the same type, the object is
    constructed _"in-place"_ if the right side is temporary #hinweis[(i.e. a function call)].
    If it is not a temporary #hinweis[(i.e. another variable)], the _copy constructor_ is invoked.

    If the object is not a `class` type or does not have the same type, a _suitable conversion sequence_ is searched for.

    This also applies to `return` statements and `throw`/`catch` blocks.
  ],
  [
    ```cpp
    auto string_factory() -> std::string {
      return "";
    }

    auto ci_function() -> void {
      // Constructed in-place from temporary
      std::string in_place = string_factory();
      // Copy constructor used on in_place variable
      std::string copy = in_place;
      // Converted from const char[4]
      std::string converted = "CPl";
    }
    ```
  ],
)

== List Initialization
#grid(
  [
    #hinweis[#cppr("language/list_initialization")[CPPReference: List initialization]]\
    Uses non-empty `{}`. Two varieties: _Direct List Initialization_ and _Copy List Initialization_.

    Constructors are selected in two phases:
    + Check for a constructor taking `std::initializer_list`.
    + Other suitable constructor is searched

    Since the `std::initializer_list` constructor is preferred, you might run into _problems_.
  ],
  [
    ```cpp
    std::string directListInit{"Nina"};
    std::string copyListInit = {"Jannis"};

    auto usesInitializerList() -> int {
      // creates vector with values '10' and '42',
      // not with 10 times '42'
      std::vector<int> data{10, 42};
      return data[5]; // undefined behavior
    }
    ```
  ],
)

#pagebreak()

==== Initialization Overview Example
```cpp
// Aggregate Initialization
std::array<char const *, 4> names{{"Freely", "Cally", "Sofieus", "Avren"}};

void print_names(std::ostream & out) {
  std::size_t name_count;    // Default Initialization
  name_count = names.size(); // No Initialization, this is a Copy Assignment!

  for(int i = 0; i < name_count; ++i) { // Copy Initialization
    std::string name{names[i]};         // List Initialization
    out << name << '\n';
  }
}

int main() {
  std::size_t name_count(names.size()); // Direct Initialization
  std::cout << "will print " << name_count << " names\n";
  print_names(std::cout);
}
```

== Aggregate Types
#hinweis[#cppr("language/aggregate_initialization")[CPPReference: Aggregate initialization]]\
An aggregate type is a class with certain restrictions regarding its content.
Classes that do not have these elements are automatically considered aggregates:
- No _user-declared_ or _inherited constructors_
- No `private` or `protected` _non-`static` data members_ #hinweis[(`private`/`protected` functions are allowed)]
- No `private`, `protected` or `virtual` _base classes_ #hinweis[(`public` base classes are allowed)]
- No `virtual` _member functions_

_All arrays are automatically aggregates._  The big _advantage_ of aggregate types is that they can easily be initialized
with a initializer list #hinweis[(like `std::vector`)]. Mostly used for simple types #hinweis[(reduces initializing code)]
and if the class has no invariant.

#grid(
  [
    *Valid Aggregate*
    #v(-0.5em)
    ```cpp
    struct Person {
      std::string name;
      int age{42};

      auto operator<(Person const &other) const
        -> bool { return age < other.age; }

      auto write(std::ostream &out) const -> void {
        out << name << ": " << age << '\n';
      }
    };
    auto main() -> int {
      person nina{"Nina", 28};
      nina.write(std::cout);
    }
    ```

  ],
  [
    *Invalid Aggregate*
    #v(-0.5em)
    ```cpp
    struct db_entry {}; // base class

    // no aggregate: private base class
    struct Person : private db_entry {
      std::string name;
      int age{42};

      // no aggregate: user-declared constructor
      Person() = default;

      // no aggregate: virtual function
      virtual auto write(std::ostream& out) const
        -> void {
        out << name ": " << age << '\n'; }
    };
    ```
  ],
)

=== Aggregate Initialization
#hinweis[#cppr("language/aggregate_initialization")[CPPReference: Aggregate initialization]]\
Aggregates can be _initialized like `std::vector`_ with the member values in `{}`.
This special type of List Initialization is called Aggregate Initialization.\
The members and base classes are initialized from the initializers in the list.
If more elements than members #hinweis[(or base classes)] are provided, the program is _ill-formed_.
If less elements are provided, the uninitialized members use their member initializer, if they have any.
Otherwise, they are initialized from empty lists.

```cpp
Person nina{"Nina"}; // age will be set to 42, because of the member initializer above
```
