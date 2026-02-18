// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan", "Matteo Gmür"),
  fach: "CPlA",
  fach-long: "C++ Advanced",
  semester: "FS25",
  language: "en",
  column-count: 6,
  font-size: 3pt,
  landscape: true,
  heading-page-number-in-ref: false,
)

// Set this to true to enable access to the offline copy of CPP Reference
// within the CAMPLA exam environment. MS Edge can open "file:" links in PDF
#let EXAM_MODE = false
#let CPPR_ROOT = if EXAM_MODE {"file://C:/cppreference/reference/en/cpp/"} else {"https://en.cppreference.com/w/cpp/"}

#let cppr(url, body) = {
  return underline(link(CPPR_ROOT + url + ".html", body))
}

// Special table cells
#let check = text(fill: colors.grün, weight: "bold", sym.checkmark)
#let cell-check-hinweis(hinweis-text) = {
  table.cell(align: center, check + " " + hinweis(hinweis-text))
}

// Document-specific settings
#show grid: set par(justify: false, linebreaks: "optimized")
#show table.cell: set par(justify: false)

= Move Semantics
#align(center, image("img/cpla_01.png"))

Sometimes, it is desirable to avoid copying values around for _performance reasons_.
- With a _copy_, the stack and heap data is copied. The new element is completely independent of the old one.
- With a _move_, only the stack data is copied. The old heap pointer gets deleted and the new one is attached
  to the same heap data. _Attention:_ The old stack data is still valid, but in a indeterminate state, risk of dangling pointers.

*Ownership Transfer:*
Resources of expiring values can be transferred to a new owner. Might be _more efficient_ than a (deep) copy and
destroying the original. Might be feasible when copying is not #hinweis[(e.g. `std::unique_ptr`)].
Examples of such resources: Heap Memory, Locks, (File) Handles.

== #highlight[Example Move Constructor (Testat 1)]
```cpp
struct ContainerForBigObject {
 ContainerForBigObject() // Default constructor
  : resource{std::make_unique<BigObject>()} {} // make_unique creates heap obj. & pointer

 ContainerForBigObject(ContainerForBigObject const& other) // Copy constructor
  : resource{std::make_unique<BigObject>(*other.resource)} {}
  // Creates a copy of the heap object and a new pointer to the copy

 ContainerForBigObject(ContainerForBigObject&& other) // Move constructor
  : resource{std::move(other.resource)} {}
  // New pointer points to the same heap object, 'other' is valid, but indeterminate state

 // Copy assignment operator
 auto operator=(ContainerForBigObject const& other) -> ContainerForBigObject& {
   resource = std::make_unique<BigObject>(*other.resource); // Same as copy constructor
   return *this; // The 'this' object gets returned
 }

 // Move assignment operator
 auto operator=(ContainerForBigObject&& other) -> ContainerForBigObject& {
   using std::swap; // Search swap in namespace scope, fallback to std-implementation
   swap(resource, other.resource); // Pointers get swapped
   //resource = std::move(other.resource) is possible too, same as move constructor
   return *this;
 }
private:
 std::unique_ptr<BigObject> resource;
};
```

== Lvalue and Rvalue References
*Lvalue:*
Everything that has an identity #hinweis[(a name)]. The address can be taken.
A lvalue reference can be used as function parameter type #hinweis[(no copy happens, but side-effects on argument are possible)],
Member/local variable or as a return type #hinweis[(returned object must survive, i.e. a reference parameter or `vector.at()`)].
Beware of dangling references!\
*Rvalue:*
Disposable values without an address or a name. Either a literal, a temporary object or an explicitly converted lvalue.
If an rvalue is passed to a rvalue reference parameter, it gets a name and turns into an lvalue. See @std-forward.

#v(-0.5em)

#table(
  columns: (1fr, 1fr),
  table.header([lvalue references], [rvalue references]),
  [Binds to an lvalue #hinweis[(everything with a name)]], [Binds to an rvalue #hinweis[(temporary objects, literals)]],
  [```cpp T &```], [```cpp T &&```],
  [The original must exist as long as it is referred to.], [Can extend the life-time of a temporary.],
  [
    ```cpp
    auto modify(T& t) -> void {
      // manipulate t
    }
    auto lvalueRefExample() -> void {
      T t = 5;
      modify(t); // modify(5) would not
      // work because 5 is not a reference
      T& ir = t; // rarely used
    }
    ```
  ],
  [
    ```cpp
    auto createT() -> T;
    // 't' can be "stolen" (not needed anymore)
    auto consume(T&& t) -> void {
      // manipulate t
    }
    auto rvalueRefExample() -> void {
      consume(T{}); // new temporary T as param
      T&& t = createT(); // rarely used
    }
    ```
  ],
)

#table(
  columns: (1fr, 1fr),
  table.header([lvalue examples], [rvalue examples]),
  table.cell(colspan: 2, align: center, [#hinweis[The value which is the lvalue/rvalue is marked as `[value]`]]),
  [
    ```cpp
    // Has a name
    T value {}; std::cout << [value];
    ```
  ],
  [
    ```cpp
    // Temporary object without a name
    int value{}; std::cout << [value + 1];
    ```
  ],
  [
    ```cpp
    // Function calls returning a lvalue ref
    [std::cout << 23]; // returns 'std::cout &'
    [vec.front()]; // returns 'T &'
    ```
  ],
  [
    ```cpp
    // Function call returning a value type
    std::abs(int n); // returns 'int'
    ```
  ],
  [
    ```cpp
    // Built-in prefix inc/dec expressions
    ++a; // returns 'T &'
    ```
  ],
  [
    ```cpp
    // Built-in postfix inc/dec expressions
    a++; // returns 'T', the value without +1
    ```
  ],
  [
    ```cpp
    // lvalue ref, but has a name
    auto foo(T& param) -> void {
      std::cout << [param]; }
    ```
  ],
  [
    ```cpp
    // Temporary T without a reference
    auto create() -> T; [create()];
    ```
  ],
  [
    ```cpp
    // rvalue ref, but has a name
    auto print(T&& param) -> void {
      std::cout << [param]; }
    ```
  ],
  [
    ```cpp
    // Transformation into rvalue with move
    T value{}; T o = [std::move(value)];
    ```
  ],
  [
    ```cpp
    // References have an address
    T& create(); [create()];
    ```
  ],
  [
    ```cpp
    // xvalue, binds to rvalue references
    T&& create(); [create()];
    ```
  ],
  [
    ```cpp
    // String literals are always lvalues
    std::cout << ["Hello"];
    ```
  ],
  [
    *Rule of thumb:*
    Does element keep living?\
    #sym.checkmark lvalue #hinweis[(only copy)],
    #sym.crossmark rvalue #hinweis[(copy & move possible)]
  ],
  table.cell(
    colspan: 2,
    align: center,
    [
      ```cpp
      // depends on the implementation of +
      T value{}; std::cout << [value + 1];
      ```
    ],
  ),
)

== Value Categories
#hinweis[#cppr("language/value_category")[CPPReference: Value categories]]
#align(center, image("img/cpla_02.png", width: 95%))

A value is always either a lvalue, xvalue or prvalue.
Lvalue does not always mean "on the left side of an assignment": ```cpp int const a = 0; a = 7; // error```
#hinweis[(left side can't always be assigned)]

#table(
  columns: (1fr,) * 3,
  table.header([Has identitty?], [Can be moved from?], [Value category]),
  [Yes], [No], [lvalue],
  [Yes], [Yes], [xvalue #hinweis[(expiring value)]],
  [No], [No #hinweis[(Since C++17)]], [prvalue #hinweis[(pure rvalue)]],
  [No], [Yes #hinweis[(Since C++17)]], [-- #hinweis[(does not exist anymore)]],
)

*Xvalue:*
Expiring Value. Address cannot be taken, cannot be used as left-hand operator of built-in assignment.
Conversion from prvalue through _temporary materialization_. Conversion from lvalue through _```cpp std::move(x)```_.
*Examples*:
Function call returning rvalue ref #hinweis[(i.e. ```cpp std::move(x)```)], access of non-ref members of rvalue object:

```cpp X x1{}, x2{}; consume(std::move(x1)); std::move(x2).member; X{}.member;```

=== Temporary Materialization
Getting from something imaginary to something you can point to #hinweis[(a value getting an address)].
Transformation from prvalue to xvalue. Requires a destructor. Happens...
- when _binding a reference to a prvalue_ #hinweis[(1)],
- when _accessing a member of a prvalue_ #hinweis[(2)],
- when accessing an element of a prvalue array #hinweis[(```cpp int value = (int[]){10, 20}[1]; // value = 20```)],
- when converting a prvalue to a pointer #hinweis[(```cpp const int &&ref = (5+3); const int *ptr = &ref;```)]
- when initializing an `std::initializer_list<T>` from a braced-init-list. #hinweis[(```cpp std::vector{1,2,3};```)]

```cpp
struct Ghost {
  auto haunt() const -> void { std::cout << "booo!\n"; } // ~Ghost() = delete; would error
};
auto evoke() -> Ghost { return Ghost{}; }
auto main() -> int { Ghost&& sam = evoke(); /* (1) */ Ghost{}.haunt(); /* (2) */ }
```

*const lvalue reference:* Binds lvalues, xvalues and prvalues: ```cpp auto f(T const &) -> void```

== Overload Resolution for Free Functions
#table(
  columns: (auto, auto, 1fr, auto, 1fr),
  table.vline(x: 2, stroke: 0.15em),
  table.header([], [`f(s)`], [`f(S &)`], [`f(S const &)`], [`f(S &&)`]),
  [
    ```cpp
    S s{}; f(s);
    ```
  ],
  cell-check,
  cell-check-hinweis([(preferred over `const&`)]),
  cell-check,
  cell-cross,

  [
    ```cpp
    S const s{}; f(s);
    ```
  ],
  cell-check,
  cell-cross,
  cell-check,
  cell-cross,

  [
    ```cpp
    f(S{});
    ```
  ],
  cell-check,
  cell-cross,
  cell-check,
  cell-check-hinweis([(preferred over `const&`)]),

  [
    ```cpp
    S s{}; f(std::move(s));
    ```
  ],
  cell-check,
  cell-cross,
  cell-check,
  cell-check-hinweis([(preferred over `const&`)]),
)

The overload for value parameters imposes ambiguities.
For deciding two lvalue reference overloads, the `const`-ness of the argument is considered.

== Overload Resolution for Member Functions
#table(
  columns: (auto, auto, auto, 1fr, auto, 1fr),
  align: horizon,
  table.vline(x: 3, stroke: 0.15em),
  table.header([], [`S::m()`], [`S::m() const`], [`S::m() &`], [`S::m() const &`], [`S::m() &&`]),
  [],
  table.cell(colspan: 2, align: center, [#hinweis[Value Members]]),
  table.cell(colspan: 3, align: center, [#hinweis[Reference Members]]),

  [
    ```cpp
    S s{};
    f(s);
    ```
  ],
  cell-check,
  cell-check,
  cell-check-hinweis([(preferred over `const&`)]),
  cell-check,
  cell-cross,

  [
    ```cpp
    S const s{};
    s.m();
    ```
  ],
  cell-cross,
  cell-check,
  cell-cross,
  cell-check,
  cell-cross,

  [
    ```cpp
    S{}.m();
    ```
  ],
  cell-check,
  cell-check,
  cell-cross,
  cell-check,
  cell-check-hinweis([(preferred over `const&`)]),

  [
    ```cpp
    S s{};
    std::move(s).m();
    ```
  ],
  cell-check,
  cell-check,
  cell-cross,
  cell-check,
  cell-check-hinweis([(preferred over `const&`)]),
);

Reference and non-reference overloads cannot be mixed.
The reference qualifier affects the `this` object and the overload resolution.
```cpp const &&``` is theoretically possible, but an artificial case.

== Special Member Functions
#hinweis[#cppr("language/rule_of_three")[CPPReference: The rule of three/five/zero]]\
- *Constructors:* Default Constructor, Copy Constructor, Move Constructor #hinweis[(Called on variable initialization)].
- *Assignment Operators:* Copy Assignment, Move Assignment #hinweis[(Called on variable reassignment)]
- *Destructors* #hinweis[(Called automatically when variable goes out of scope to clean up the objects resources)]

It is normally not necessary to implement these yourself (_"rule of zero"_),
but if a destructor or a copy function is needed, all three are needed (_"rule of three"_).
For further optimization, the move functions should also be implemented (_"rule of five"_).
Copy Constructor/Assignment should be marked `const` #hinweis[(they don't modify `this`)].

Assignment operators must be _member functions_.
Move operations _must not throw exceptions_, thus aren't allowed to allocate memory.
Use the default implementation of the special members whenever possible.

=== Move Constructor ```cpp S(S &&)```
#hinweis[#cppr("language/move_constructor")[CPPReference: Move constructor]]\
Takes the guts out of the argument and moves them to the constructed object.
Leaves the argument in _valid but indeterminate state_.
Don't use the argument after it has been moved from until you assign it a new value.
*Default behavior:* Initialize base classes and members with move initialization. #hinweis[```cpp S(S && v) : m{std::move(v.m)}```]

=== Copy/Move assignment ```cpp auto operator=(S const &) -> S&``` / ```cpp auto operator=(S &&) -> S&```
#hinweis[
  #cppr("language/as_operator")[CPPReference: Copy assignment],
  #cppr("language/move_assignment")[CPPReference: Move assignment]
]\
Copies/Moves the argument into the `this` object. Executed when the variable to copy/move to has _already been initialized_.
Must be a member operator. *Default behavior:* Initializes base classes and members with copy-assignment/move-assignment.

=== Destructor ```cpp ~S()```
#hinweis[#cppr("language/destructor")[CPPReference: Destructors]]\
_Deallocates resources_ held by the `this` object. No parameters. Must not throw #hinweis[(is `noexcept`)].
Must be implemented if a custom copy/move is defined. *Default behavior:* Calls destructor of base classes and members.

=== Copy-Swap-Idiom
Allows efficient implementation of the copy-assignment operator.
Utilizes the copy constructor to create a temporary object, and exchanges its contents with itself using a non-throwing swap.
Therefore, it _swaps the old data with new data_. The temporary object is then destructed automatically.
It needs a copy-constructor, a destructor and a swap function to work. Should be marked `noexcept`.

```cpp
struct S {
  // swap() member function - called by non-member swap() below
  auto swap(S& other) noexcept -> void {
    using std::swap; // Fall back to std::swap if no user defined swap is available
    swap(member1, other.member1); // Calls std::swap or custom swap of member variable
  }
  // Copy assignment
  auto operator=(S const& s) -> S& {
    if (std::addressof(s) != this) { // Avoids unnecessary self-copy
      S copy = s; // Can throw exception, this-object stays intact
      swap(copy);
    }
    return *this;
  }
  // Move assignment
  auto operator=(S&& s) -> S& { // could be noexcept
    if (std::addressof(s) != this) {
      swap(s); // 's' now contains value of this-object, but is okay because dead soon
    }
    return *this;
  }
}; // Destructor is implicit

auto swap(S& lhs, S& rhs) noexcept -> void {
  lhs.swap(rhs); // Calls S::swap() above
}
```

=== What you write vs. what you get
#let defaulted = [defaulted]
#let undeclared = text(fill: colors.rot, weight: "bold")[undeclared]
#let defaulted-bug = text(fill: colors.rot, weight: "bold")[defaulted!]
#let user-declared = underline[user decl.]
#let deleted = text(fill: colors.rot, weight: "bold")[deleted]

#hinweis[
  Watch out for the combinations in red. "defaulted!" are bugs, should be implemented yourself.
  You want to stay above the black line, avoid going below it!
  When using multiple constructor / assignment methods, #deleted takes precedence over #defaulted-bug, #undeclared over #defaulted.
  Defining a constructor / assignment method as `= default;` makes the implicit default explicitly #user-declared
]

#v(-0.75em)
#table(
  columns: (1fr,) * 7,
  table.header([write/get], [default ctor], [destructor], [copy ctor], [copy assign], [move ctor], [move assign]),
  table.hline(y: 4, stroke: 0.15em),
  [_nothing_], defaulted, defaulted, defaulted, defaulted, defaulted, defaulted,
  [_any ctor_], undeclared, defaulted, defaulted, defaulted, defaulted, defaulted,
  [_default ctor_], user-declared, defaulted, defaulted, defaulted, defaulted, defaulted,
  [_destructor_], defaulted, user-declared, defaulted-bug, defaulted-bug, undeclared, undeclared,
  [_copy ctor_], undeclared, defaulted, user-declared, defaulted-bug, undeclared, undeclared,
  [_copy assign_], defaulted, defaulted, defaulted-bug, user-declared, undeclared, undeclared,
  [_move ctor_], undeclared, defaulted, deleted, deleted, user-declared, undeclared,
  [_move assign_], defaulted, defaulted, deleted, deleted, undeclared, user-declared,
)

== Copy Elision
#hinweis[#cppr("language/copy_elision")[CPPReference: copy elision]]\
In some cases, the compiler is required to elide #hinweis[(omit)] specific copy/move operations
regardless of the side-effects of the corresponding special member functions (_"Mandatory elision"_). The omitted operations need not exist. This happens...
- In _initialization_, when the initializer is a _prvalue_: ```cpp S s = S{S{}};```
  #hinweis[(Only 1 constructor call, 0 copy operations)]
- When a function call _returns a prvalue_: #hinweis[(`S{}` gets initialized directly in `new_sw{}` instead of in `create()`)]
  #v(-0.5em)
  ```cpp
  auto create() -> S { return S{}; }
  auto main() -> int { S new_sw{create()}; S * sp = new S{create()}; }
  ```

=== Further optional elisions
- *NRVO:* _Named Return Value Optimization_.
  Return type is a value type, return expression is a local variable of the return type.
  The object is constructed in the location of the return value. The constructors _must still exist_ - even if they are elided.
  ```cpp return std::move()``` prevents NVRO.
- *`throw` Expression:* Return expression is a local variable from the innermost surrounding try block.
  The object is constructed in the location where it would be moved or copied to.
- *`catch` Clause:* If the caught type is the same as the object thrown, it accesses the object directly.

=== Example
```cpp
auto create() -> S { S s{}; std::cout << "\t --- create() ---\n"; return s; }
auto main() -> int {
  std::cout << "\t --- S s{create()} ---\n"; S s{create()};
  std::cout << "\t --- s = create()  ---\n"; s = create();
}
```

#grid(
  columns: (1fr,) * 3,
  [
    *Disabled elision* #hinweis[(C++14)]\
    #hinweis[2x Move in `s{}`, 1x Move in `s =`]
    ```cpp
    --- S s{create()} ---
    Constructor S()
    --- create() ---
    Constructor S(S&&)
    Constructor S(S&&)
    --- s = create() ---
    Constructor S()
    --- create() ---
    Constructor S(S&&)
    operator =(S&&)
    ```
  ],
  [
    *Only mandatory elision* #hinweis[(C++17)]\
    #hinweis[1x Move in `s{}`, 1x Move in `s =`]
    ```cpp
    --- S s{create()} ---
    Constructor S()
    --- create() ---
    Constructor S(S&&)
    // no create() to s
    --- s = create() ---
    Constructor S()
    --- create() ---
    Constructor S(S&&)
    operator =(S&&)
    ```
  ],
  [
    *With constructor elision* #hinweis[(C++17)]\
    #hinweis[0x Move in `s{}`, 0x Move in `s =`]
    ```cpp
    --- S s{create()} ---
    Constructor S()
    --- create() ---
    // no return to create()
    // no create() to s
    --- s = create() ---
    Constructor S()
    --- create() ---
    // no return to create()
    operator =(S&&)
    ```
  ],
)

== Life-Time Extension
The life-time of a temporary can be extended by _const lvalue references_ or _rvalue references_.
Extended life-time ends at the end of the block.
It is not transitive #hinweis[(Reference Return $->$ Dangling Reference $->$ Undefined Behavior)].

```cpp
struct Demon { /* ... */ };
auto summon() -> Demon { return Demon{}; } // Creates a demon
auto countEyes(Demon const&) -> void { /* ... */ }

auto main() -> int {
  summon();           // Demon dies at the end of the statement
  countEyes(Demon{}); // Demon lives long enough for count_eyes to finish
  // life-time can be extended by const & -> flaaghun lives until end of block
  Demon const& flaaghun = summon();
  // life-time can also be extended by && -> laznik lives until end of block
  Demon&& laznik = summon();
} // flaaghun and laznik die here
```


= Type Deduction
#v(-0.75em)
== Forwarding References and Type Deduction
#hinweis[
  #cppr("language/template_argument_deduction")[CPPReference: Template argument deduction],
  #cppr("language/reference.html#Forwarding_references")[CPPReference: Reference declaration -- Forwarding Reference]
]\
In some contexts, `T&&` does not necessarily mean rvalue reference.
_Exceptions:_ ```cpp auto &&``` or ```cpp T&&``` when template type deduction applies for type `T`.
Here, lvalues can also bind to ```cpp T&&``` as a ```cpp T&```.
Only works for Method Templates, not Class Templates, and only for "```cpp T &&```",
not "```cpp std::vector<T> &&```" or "```cpp T const &&```".

#grid(
  [
    ```cpp
    template <typename T>
    auto f(ParamType param) -> void;
    ```
  ],
  [
    ```cpp
    // T and ParamType can be different types!
    f(<expr>);
    ```
  ],
)

Deduction of `type T` depends on the structure of the type of the corresponding parameter `ParamType`:
#v(-0.5em)

=== `Paramtype` is a value type (`T`)
#hinweis[(e.g. ```cpp auto f(T param) -> void```) #sym.space Note: Pointers (```cpp T *```) are also value types]
+ `<expr>` is a reference type: ignore the reference
+ Ignore the rightmost `const` of `<expr>` #hinweis[(`char const * const --> char const *`)]
+ Pattern match `<expr>`'s type against `ParamType` to figure out `T`

```cpp
int x = 23; int const cx = x; int const & crx = x; char const * const ptr = ...;

// calls  // instances                                // deduced Ts
f(x);     auto f(int param) -> void;                  T = int
f(cx);    auto f(int param) -> void;                  T = int
f(crx);   auto f(int param) -> void;                  T = int
f(ptr);   auto f(char const * param) -> void;         T = char const *
```

=== `Paramtype` is a reference (`T&`)
#hinweis[(e.g. ```cpp auto f(T & param) -> void``` or ```cpp auto f(T const & param) -> void```)]
+ `<expr>` is a reference type: ignore the reference
+ Pattern match `<expr>`'s type against `ParamType` to figure out `T`

```cpp
int x = 23; int const cx = x; int const & crx = x;
```

*Examples for References:* #hinweis[```cpp auto f(T & param) -> void```]
#v(-0.5em)
```cpp
// calls  // instances                                // deduced Ts
f(x);     auto f(int& param) -> void;                 T = int
f(cx);    auto f(int const& param) -> void;           T = int const
f(crx);   auto f(int const& param) -> void;           T = int const
```

*Examples for Const References:* #hinweis[```cpp auto f(T const & param) -> void```]
#v(-0.5em)
```cpp
// calls  // instances                                // deduced Ts
f(x);     auto f(int const& param) -> void;           T = int
f(cx);    auto f(int const& param) -> void;           T = int
f(crx);   auto f(int const& param) -> void;           T = int
```

=== `Paramtype` is a forwarding reference (`T&&`)
#hinweis[(e.g. ```cpp auto f(T && param) -> void```)]

+ `<expr>` is an lvalue: `T` and `ParamType` become lvalue references #hinweis[(First 3 examples turn into `T&`)]
+ Otherwise #hinweis[(if `<expr>` is an rvalue)]: Rules for references apply #hinweis[(Last example)]

```cpp
int x = 23; int const cx = x; int const & crx = x;

// calls  // instances                                // deduced Ts
f(x);     auto f(int & param) -> void;                T = int &
f(cx);    auto f(int const & param) -> void;          T = int const &
f(crx);   auto f(int const & param) -> void;          T = int const &
f(27);    auto f(int && param) -> void;               T = int
f("OST"); auto f(char const (&) [4] param) -> void;   T = char const (&) [4]
```

=== Type Deduction and Initializer Lists
When an `initializer_list` is used for type deduction, an error occurs: ```cpp f({23});```\
For this to work, a separate template is needed:
```cpp
template <typename T>
auto f(std::initializer_list<T> param) -> void;
f({23}); // T = int, ParamType = std:initializer_list<int>
```

=== Type Deduction for `auto`
#hinweis[#cppr("language/auto")[CPPReference: Placeholder type specifiers: `auto`/`decltype(auto)`]]\
Same deduction as above. `auto` takes the place of `T`:
```cpp
auto x = 23;               // T  -> int          auto is a value type
auto const cx = x;         // T  -> int const    auto is a value type
auto& rx = x;              // T& -> int const &  auto is a reference type

auto&& uref1 = x;          // T&&: x  = int (lvalue)       -> uref1 = int&
auto&& uref2 = cx;         // T&&: cx = int const (lvalue) -> uref2 = int const&
auto&& uref3 = 23;         // T&&: 23 = int&& (rvalue)     -> uref3 = int&&

// Special cases
auto init_list1 = {23};    // std::initializer_list<int>
auto init_list2{23};       // int, was std_initializer_list<int> before C++17
auto init_list3{23, 23};   // Error, requires one single argument
```

*`auto` Return Type Deduction:*
`auto` can be used as return type and for parameter declarations. Body must be available to deduce the type.
Multiple `auto` parameters are considered different types.

=== Type Deduction for `decltype`
#hinweis[#cppr("language/decltype")[CPPReference: `decltype` specifier]]\
Represents the declared type of a named expression.
`decltype(auto)` allows deduction of (inline) function return types, but _does not strip references (`&`) or `const`
like plain `auto`_.
Can take an expression for specifying trailing return types.

```cpp
int              x         = 23;
int&             rx        = x;
decltype(rx)     rx_too    = rx; // rx_too  -> int&
auto             just_x    = rx; // just_x  -> int
decltype(auto)   more_rx   = rx; // more_rx -> int&
template <typename Container, typename Index>
auto access(Container &c, Index i) -> decltype(auto) { return c[i]; } // Requires body
auto access(Container &c, Index i) -> decltype(c[i]) { ... } // Body not required (.hpp)
```

=== Type Deduction in Lambdas
#hinweis[Slides: Page 38]
#v(-0.5em)

== Perfect forwarding with std::forward <std-forward>
#hinweis[#cppr("utility/forward")[CPPReference: `std::forward`], Slides Page 25 onward] #h(1fr) ```cpp #include <utility>```\

#definition[
  ```cpp
  template <typename T>
  decltype(auto) forward(std::remove_reference_t<T>& param) {
    return static_cast<T&&>(param);
  }
  ```
]

`std::forward` is a _conditional cast to an rvalue reference_.
This allows arguments to be treated as what they originally were: lvalues remain lvalues and rvalues remain rvalues.

- If `T` is of _value type_, `T &&` is an _rvalue reference_ in the return expression. #hinweis[(`int -> int&&`)]
- If `T` is of _lvalue reference type_, the resulting type is an _rvalue reference to an lvalue reference_\
  #hinweis[(e.g. `T = int & -> T &&` would mean "`int & &&`" which can be collapsed into "`int &`")].

```cpp
template<typename T>
static auto make_buffer(T && value) -> BoundedBuffer<value_type> {
    BoundedBuffer<value_type> new_buffer{};
    new_buffer.push(std::forward<T>(value));
    return new_buffer; }
```

== std::move
#hinweis[#cppr("utility/move")[CPPReference: `std::move`], Slides Page 43 onward] #h(1fr) ```cpp #include <utility>```\

#definition[
  ```cpp
  template <typename T>
  decltype(auto) move(T&& param) {
    return static_cast<std::remove_reference_t<T>&&>(param);
  }
  ```
]

Does not actually move objects. It's just a _unconditional cast to an rvalue reference_.
This allows resolution of rvalue reference overloads #hinweis[(```cpp auto f(T&& t)```)] and move-constructor/-assignment operators.
_Caution! Moving a `const` object or a non-const object without a move ctor/assignment results in a copy, not move operation!_
To allow for moving, there should be no `const` member in a class.

*Reference Collapsing:*
"`T& &`", "`T& &&`" and "`T&& &`" become "`T&`", "`T&& &&`" becomes "`T&&`".


= Heap Memory Management
*Lifetime on Stack:* Deterministic, local variables get deleted automatically upon leaving their scope ```cpp { int a; }```\
*Lifetime on Heap:*  Creation and deletion happens _explicitly_ with `new` and `delete` #hinweis[(Dangerous, avoid!)].\
```cpp auto foo() -> void { auto ip = new int{5}; /* ... */ delete ip;}```

*Rules:* Delete every object you allocated, do not delete an object twice or access a deleted object.

== Explicit Life-Time Management
Global and local variables have life-time implicitly managed by the program flow.
Some resources can be allocated and deallocated explicitly. This is _error-prone_.
*Guideline:* Always wrap explicit resource management in an object which has implicit life-time management (RAII).

== Pointer Syntax
#hinweis[#cppr("language/pointer")[CPPReference: Pointer declaration]]
```cpp
auto ip = new int{5};  // auto -> int *
int v = * ip;          // accessing value: v == 5
```
*Heap Array Access:*
#v(-0.5em)
```cpp
auto arr = new int[5]{};  // 5 needs to be compile-time-constant, auto -> int *
int v = arr[4];           // accessing element (*arr + 4 pointer objects)
```

*Direct Member Access (->):*
#v(-0.5em)
```cpp
struct S {
  auto member() -> void { this->value = ...; } int value; // 'this': pointer to a instance
};
auto foo() -> void {
  S* sp = new S{}; sp->member(); // = (*sp).member(); "." binds stronger than "*"
}
```

*Pointer Parameters:*
Pointers can be used as parameters.
Addresses can be taken with `&` #hinweis[(Caution, operator could be overridden)]
or `std::addressof()` #hinweis[(Preferred, the rvalue overload is deleted to prevent taking their address)].
```cpp
auto foo(int* p) -> void { }
auto bar() -> void { int* ip = new int{5}; int local = 6; foo(ip); foo(&local); }
```
#hinweis[More complicated examples with pointer to pointer to pointer to int: Slides page 25]

*Const Pointers:*
`const` Pointer can't be modified, but the object behind it may. `const` is on the right side of the `*`.
The declaration is read from right to left.\
```cpp int const * const * * const icpcppc = &icpcp;```\
"icpcppc is a #tcolor("orange")[const pointer] to a #tcolor("grün")[pointer]
to a #tcolor("dunkelblau")[const pointer] to a #tcolor("rot")[const int]"

*`nullptr`:*
Represents a `null`-Pointer. Is a _literal_ #hinweis[(prvalue)] and has _type_ `nullptr_t`.
Implicit conversion to any pointer type: `T *`.
Prefer `nullptr` over `0` and `NULL` #hinweis[(no overload ambiguity, no implicit conversion)].

*Pointer vs. Reference*
#v(-1em)
#table(
  columns: (1fr, 1fr),
  [Pointers ...], [References ...],
  [can be `nullptr`], [are always bound to an object],
  [can be changed #hinweis[(if not `const`)]], [cannot be rebound to another object],
  [require dereferencing with "`*`" or #no-ligature["`->`"]], [allow member access by "`.`"],
  [can be dangling #hinweis[(pointing to a destroyed object)]],
  [can be dangling #hinweis[(referencing a destroyed object)]],
)

Use raw pointers only to explicitly _model the possibility of a `nullptr`_ #hinweis[(requires a check like 
```cpp auto foo(int* ptr) -> void { if (ptr) { ... } }```)] and for _modelling borrowing_ only.
Else, use _smart pointers_.

== Memory Allocation with new
#definition[`new <type> <initializer>`]

Allocates memory for an instance of `<type>`. Returns a pointer to the object or array created on the heap of type `<type> *`.
The arguments in the `<initializer>` are passed to the constructor of `<type>`. _Memory Leak if not removed with `delete`_.
Avoid manual allocation, use RAII instead.

```cpp
struct Point{ Point(int x, int y) : x{x}, y{y}{} int x, y; };
auto createPoint(int x, int y) -> Point* {
  return new Point{x, y}; // constructor
}
auto createCorners(int x, int y) -> Point* {
  return new Point[2]{{0, 0}, {x, y}};
}
```

=== Placement new
#definition[`new (<location>) <type> <initializer>`]

#grid(
  columns: (1.9fr, 1fr),
  [
    Used for placing elements on the heap in the location of a deleted element.
    Does _not_ allocate new memory #hinweis[(Undefined Behavior)]!
    The memory of `<location>` needs to be suitable for construction of a new object and any element there
    _must be destroyed before_. Calls the Constructor for creating the object at the given location and returns
    the memory location. Better use `std::construct_at()`.
  ],
  [
    ```cpp
    auto ptr = new Point{9, 8};
    // deconstruct Point here...
    new (ptr) Point{7, 6};
    delete ptr;

    // Better:
    std::construct_at(ptr, 7, 6);
    ```
  ],
)

== Memory Deallocation with delete
#definition[`delete <pointer>`]

Deallocates the memory of a single object pointed to by the `<pointer>`. Calls the Destructor of the destroyed type.
`delete nullptr` does nothing. _Deleting the same object twice is Undefined Behavior!_

```cpp
struct Point{ Point(int x, int y) : x{x}, y{y}{} int x, y; };
auto funWithPoint(int x, int y) -> void {
  Point * pp = new Point{x,y};
  delete pp; // calls destructor and releases memory
}
```

=== Placement delete
Does not exist, but a destructor can be called explicitly.
#definition[#no-ligature[`S * ptr = ...; ptr->~S();`]]

Destroys the object, but does _not_ free its memory. Called like any other member function.
Better use `std::destroy_at(ptr)`. Use this for non-default constructible types.

=== Array Memory Deallocation with delete[]
#definition[``` delete[] <pointer-to-array>```]

Deallocates the memory of an array pointed to by the `<pointer-to-array>`. Calls the Destructor of the destroyed objects.
Also deletes _multidimensional arrays_. Not necessary to know exact amount of elements in the array.
Undefined behavior on non-array types.\
```cpp Point *arr = new Point[2]{{0, 0}, {3, 2}}; /* do stuff */ delete[] arr;```

== #highlight[Non-Default Constructible Types]
A type is non-default-constructible when there is _no explicit or implicit default constructor_.\
To create arrays of NDC types, allocate the plain memory and initialize it later #hinweis[(Slides page 36 onward)].

```cpp
auto memory = std::make_unique<std::byte[]>(sizeof(Point) * 2 /* Array size */);
auto location = reinterpret_cast<Point*>(memory.get()); // Address of first element
std::construct_at(location, 1, 2); // Equivalent to arr[0] = Point{1, 2}
auto value = elementAt(memory.get(), 0); // Access value via helper function
std::destroy_at(location);

auto elementAt(std::byte* memory, size_t index) -> Point& { // helper function
  return reinterpret_cast<Point*>(memory)[index];
}
```
Don't use an element if it is uninitialized and destroy them before the memory is deallocated.

Use a `std::byte` array as memory for NDC Elements.
- *Static:* ```cpp std::array<std::byte, no_of_bytes> values_memory;``` #hinweis[(on stack, size known at compile-time)]
- *Dynamic:* ```cpp std::unique_ptr<std::byte[]> values_memory;``` #hinweis[(on heap, size known at run-time)]

== Class-Specific Overloading of operator new/delete
Overloading `new` and `delete` for a class can inhibit heap allocation. This can be used to provide efficient allocation.
Is useful with a memory pool for small instances or if thread-local pools are used.
Can log or limit number of heap-allocated instances. _But in general, not advisable_.

```cpp
struct not_on_heap { // Prevents heap allocation of this class
  static auto operator new(std::size_t sz) -> void * { throw std::bad_alloc{};}
  static auto operator new[](std::size_t sz) -> void * { throw std::bad_alloc{};}
  static auto operator delete(void *ptr) -> void noexcept { /* do nothing */ }
  static auto operator delete[](void *ptr) -> void noexcept { /* do nothing */ }
};
```

== Reading Declarations
- Declarations are read _starting by the declarator_ (name)
- First _read to the right_ until a _closing parenthesis_ is encountered
- Second _read to the left_ until an _opening parenthesis_ is encountered
- Third _jump out of the parentheses_ and start over

*Specifiers right to the declarator:*
Array Declarator #hinweis[(`[]`)] and Function Parameter List #hinweis[(`(<parameter declarations>)`)]\
*Specifiers left to the declarator:*
References #hinweis[(`&&`, `&`)], Pointers #hinweis[(`*`)] and Types #hinweis[(`int`)]\
*`const`:*
Applies to its left neighbor, if there is no left neighbor, it applies to its right neighbor.\
```cpp const int i; int const i;```
Should always be written to the right of the type to avoid surprises #hinweis[(i.e. with aliases)].

```cpp void (* f)(int &, double)```\
`f` is a pointer to a function that takes a reference to `int` and a `double`, returning `void`.

```cpp int const * (* f [2][3]) [5];```\
`f` is an #tcolor("orange")[array of 2 elements] of #tcolor("grün")[arrays of 3 elements of pointers]
to #tcolor("dunkelblau")[arrays of 5 elements of pointers] to #tcolor("rot")[`const int`].

```cpp int (* f(int(*)(int))) (int); // [7]int ([3]* [1]f ([5]int ([2]*)([4]int))) ([6]int)```\
`f` #hinweis[[1]] is a function that takes a pointer to a function as argument #hinweis[[`2`]]
and returns a pointer to a function #hinweis[[`3`]].\
The function in the argument takes an `int` as argument #hinweis[([`4`])] and returns an int #hinweis[[`5`]].
The returned function takes an `int` as argument #hinweis[[`6`]] and returns an `int` #hinweis[[`7`]].
Always use type aliases on cases like this!

== Resource Management with RAII <RAII>
_Resource Acquisition Is Initialization_ is an alternative to allocating and deallocating a resource explicitly.
Wraps allocation and deallocation in a class, uses regular constructor/destructor. Cleaned up at end of scope.

=== `std::unique_ptr` and `std::make_unique`
#hinweis[
  #cppr("memory/unique_ptr")[CPPReference: std::unique_ptr],
  #cppr("memory/unique_ptr/make_unique")[CPPReference: std::make_unique]
]\
```cpp std::unique_ptr<char> cPtr = std::make_unique<char>('*');``` \
Wraps a plain pointer, has zero runtime overhead. A custom deleter could be supplied if required.
Always use `make_unique` for creation. Can create unbound arrays, but not fixed size arrays.

=== Container Member Function `emplace`
#hinweis[
  #cppr("container/vector/emplace")[CPPReference: `std::vector<T,Allocator>::emplace`],
  #cppr("container/stack/emplace")[CPPReference: `std::stack<T,Container>::emplace`]
]\
Constructs elements directly in a container, more efficient than moving them. Not available for `std::array`.\
```cpp std::stack<Point> vec{}; vec.emplace(3, 5); // std::vector requires position argument```


= Iterators & Tags
#v(-0.75em)
== Tags for Dispatching
#hinweis[#cppr("iterator/iterator_tags")[CPPReference: `std::..._iterator_tag`]]\
If the _same operation_ can be implemented more/less efficiently depending on the capabilities of the argument,
_tags can be used to find the "best" implementation_.\
Tags are used to _mark capabilities_ of associated types. They do not contain any members.
#v(-0.5em)
```cpp
// provides travelThroughSpace(), the base functionality
struct SpaceDriveTag{};
template<typename> struct SpaceshipTraits { using Drive = SpaceDriveTag; };
// provides travelThroughSpace() and travelThroughHyperspace(), specialized template
struct SubspaceDriveTag : SpaceDriveTag{};
template<> struct SpaceshipTraits<GalaxyClassShip> { using Drive = SubspaceDriveTag; };
template <typename Spaceship>
auto travelToDispatched(Galaxy destination, Spaceship& ship, SpaceDriveTag) -> void {
  ship.travelThroughSpace(destination); // for Spaceships with SpaceDriveTag
}
template <typename Spaceship>
auto travelToDispatched(Galaxy destination, Spaceship& ship, SubspaceTag) -> void {
  ship.travelThroughHyperspace(destination); // for Spaceships with SubspaceTag
}
template <typename Spaceship>
auto travelTo(Galaxy destination, Spaceship& ship) -> void {
  typename SpaceShipTraits<Spaceship>::Drive drive{}; // get the Spaceship's drive tag
  travelToDispatched(destination, ship, drive); // call overloaded function
}
```

== Iterators
Different algorithms require different strengths of iterators.
Iterators capabilities can be determined at compile time with tag types.
- *OutputIterator:* Write results #hinweis[(to console, file etc.)], without specifying an end #hinweis[(used on `std::ostream`)].\
  `operator *` returns an _lvalue reference_ for assignment of the value.
- *InputIterator:* Read sequence once #hinweis[(used on `std::istream`)].\
  `operator *` returns _const lvalue reference_, or _rvalue_.\
- *ForwardIterator:* Read/write sequence, multi-pass #hinweis[(used on `std::forward_list` linked-list)].\
  const `operator *` returns _const lvalue reference_ or rvalue, non-const `operator *` returns _lvalue_
- *BidirectionalIterator:* Read/write, back and forth #hinweis[(used on `std::list` double-linked-list)].
- *RandomAccessIterator:* Read/write/indexed sequence #hinweis[(used on `std::vector`)].

You need to implement the members required by your `iterator_tag`.
```cpp
struct IntIterator { // Provide these member types to align with STL iterators
  using iterator_category = std::input_iterator_tag; // iterator category
  using value_type = int; // type of element the iterator iterates over
  using difference_type = ptrdiff_t; // specifies iterator distance
  using pointer = int *; // pointer type of the elements iterated over
  using reference = int &; // reference type of the elements iterated over
};
```

=== `iterator_traits<>`
#hinweis[#cppr("iterator/iterator_traits")[CPPReference: `std::iterator_traits`]]\
STL algorithms often want to _determine the type_ of some specific thing related to an iterator.
However, not all iterator types are actually classes. Default `iterator_traits` just pick the type aliases from those provided.

```cpp
template <typename InputIterator, typename Tp>
auto count(InputIterator first, InputIterator last, const Tp& value)
  -> typename iterator_traits<InputIterator>::difference_type { ... }
```

Specialization of `iterator_traits` also allows "naked pointers" to be used as iterators in algorithms.
```cpp
template <typename _Tp> struct iterator_traits<Tp*> { /* Provide regular iter usings */ }
```

=== Problems with the Stream Input Iterator
==== Reference Member and Default Constructor
When implementing a input iterator, we need to be able to create an `EOF` iterator.
This dirty hack works, but the global variable to initialize the reference in an anonymous namespace is bad for multi-threading.

```cpp
namespace { // global variable to initialize the reference in an empty namespace
  std::istringstream empty{}; // pseudo default
}
IntInputter::IntInputter() : input { empty }
  // guarantee the empty stream is !good()
  input.clear(std::ios_base::eofbit); // mark empty stream as EOF
}
```

==== Dereferencing and Equality
```cpp
// Dereferencing with * reads the value from the input
auto IntInputter::operator*() -> IntInputter::value_type {
  value_type value{};
  input >> value;
  return value; }
// Stream iter comparisons only make sense for testing if they can still be read from
auto IntInputter::operator==(const IntInputter & other) const -> bool {
  return !input.good() && !other.input.good(); }
```

=== #highlight[Custom Iterator Example (Testat 2)]
#no-ligature[
  ```cpp
  template<typename V>
  struct iterator_base {
      using value_type = BoundedBuffer::value_type;
      using reference = BoundedBuffer::reference;
      using const_reference = BoundedBuffer::const_reference;
      using size_type = BoundedBuffer::size_type;
      using difference_type = std::ptrdiff_t;
      using iterator_category = std::random_access_iterator_tag;

      auto operator==(iterator_base const & other) const -> bool { ... }
      auto operator<=>(iterator_base const & other) const -> std::strong_ordering { ... }

      auto operator*() const -> decltype(auto) { return Buffer->elementAt(Index); }
      auto operator->() const -> decltype(auto) { return &(Buffer->elementAt(Index)); }
      auto operator[](difference_type index) const -> decltype(auto) { ... }

      auto operator++() -> iterator_base & { Index++; return *this; }
      auto operator++(int) -> iterator_base {
          auto const copy = *this;
          ++(*this);
          return copy; }

      auto operator--() -> iterator_base & { Index--; return *this; }
      auto operator--(int) -> iterator_base {
          auto const copy = *this;
          --(*this);
          return copy; }

      auto operator+(difference_type n) const -> iterator_base {
          auto copy = *this;
          copy += n;
          return copy; }

      auto operator-(difference_type n) const -> iterator_base {
          return this->operator+(-n); }

      auto operator+=(difference_type n) -> iterator_base & { Index += n; return *this; }
      auto operator-=(difference_type n) -> iterator_base & { return this->operator+=(-n); }

      auto operator-(iterator_base const & other) const -> difference_type { ... }
    private: difference_type Index{}; BoundedBuffer* Buffer;
  };

  using iterator = iterator_base<Container<T>>;
  using const_iterator = iterator_base<Container<T> const>;
  ```
]

Boost would generate `operator++(int), operator--(int), operator+(difference_type n), operator-(difference_type n)`
with implementation shown above.
Change signature to ```cpp struct iterator_base : boost::operators_impl::random_access_iterator_helper<iterator_base<V>, V> {}```


= Advanced Templates
#grid(
  columns: (1fr, 1fr),
  [
    *Pros of static polymorphism*
    - Happens at compile-time
    - Faster execution time #hinweis[(no dynamic dispatch required, easier to optimize)]
    - Type checks at compile-time
  ],
  [
    *Cons of static polymorphism*
    - Longer compile-times
    - Template code has to be known when used #hinweis[(Body needs to be in HPP file)]
    - Larger binary size #hinweis[(copy of the used parts for each template instance)]
  ],
)

A polymorphic call of a _virtual function_ #hinweis[(inheritance overloading)] requires lookup of the target function.
_Non-virtual calls_ #hinweis[(template overloading)] directly call the target function. This is _more efficient_.

== SFINAE (Substitution Failure is Not An Error)
#hinweis[#cppr("language/sfinae")[CPPReference: SFINAE] \ ]
Is used to eliminate overload candidates by substituting return type and parameters.
During overload resolution the template parameters in a template declaration #hinweis[(i.e. `T`)]
are substituted with the deduced types #hinweis[(i.e. `int`)].
This may result in template instances that cannot be compiled #hinweis[(i.e. calling a member function on a value type)].
If the substitution of template parameter fails, that overload candidate is _discarded_.

`decltype(<return-expr>)` as return type checks if the overload candidate would work, but this approach is infeasible,
because functions can be `void` and it's not elegant for complex bodies.

=== Type traits
#hinweis[
  #cppr("header/type_traits")[CPPReference: Type Traits],
  #cppr("types/integral_constant")[CPPReference: std::integral_constant]
]
#h(1fr) ```cpp #include <type_traits>```\
The standard library provides many predefined checks for type traits. A trait contains a boolean value.
Usually available in a `_v` #hinweis[(returns the `bool` result)] and non-`_v` variant #hinweis[(returns the integral constant)].

==== Example: `std::is_class`
#hinweis[#cppr("types/is_class")[CPPReference: `std::is_class`]]
```cpp
std::is_class<S>::value;   std::is_class_v<S>;   // both true
std::is_class<int>::value; std::is_class_v<int>; // both false
```
==== `std::enable_if` / `std::enable_if_t`
#hinweis[#cppr("types/enable_if")[CPPReference: `std::enable_if`]]\
`std::enable_if_t` takes an expression and a type.
If the expression evaluates to true, `std::enable_if_t` represents the given type, otherwise, it does _not_ represent a type.

```cpp
auto main() -> int {
  std::enable_if_t<true, int> i; // int
  std::enable_if_t<false, int> error; } // no type, compiler error
```
`std::enable_if` can be applied at different places #hinweis[(marked with "[]", only one needs to be used)]:
```cpp
template <typename T, [typename = enable_if_t<is_class_v<T>, void>]>
auto increment([enable_if_t<is_class_v<T>, void>] value) // impairs type deduction
  -> [enable_if_t<is_class_v<T>, T>] {
  return value.increment();
}
```

== Template Parameter Constraints and Concepts
#hinweis[#cppr("language/constraints")[CPPReference: Constraints and Concepts]]\
Provide a means to _specify_ the _characteristics of a type_ in template context. Better error messages, more expressive SFINAE.

=== Keyword `requires`
Allow constraining template parameters. `requires` is followed by a compile-time constant boolean expression.
Is either placed after the template parameter list or after the function template's declarator.

```cpp
template <typename T>
requires std::is_class_v<T> // either here...
auto function(T argument) -> void requires std::is_class_v<T> /* or here */ { ... }
```

==== `requires` Expression
`requires` also starts an expression that evaluates to `bool` depending whether they can be compiled.
#definition[
  ```cpp
  requires ($parameter-list$) { /* sequence of requirements */ }
  ```
]

```cpp
template <typename T>
requires requires (T const v) { v.increment(); } // compiles if v has a increment function
auto increment(T value) -> T { return value.increment(); }
```

==== Type Requirements
Check whether a type exists. Starts with `typename` keyword. Useful for nested types like in Bounded Buffer
#definition[
  ```cpp requires { typename $type$ }```
]

```cpp
requires { typename BoundedBuffer<int>::value_type; }
```

==== Compound Requirements
Check whether an expression is valid and can check constraints on the expression's type.
The return-type-requirement is optional. Needs to be a valid type constraint, regular types can't be used.

#definition[
  ```cpp
  requires (T v) { { $expression$ } -> $type-constraint$; }
  ```
]

```cpp
template <typename T> // We can't use T as return type in requires, it is not a constraint
requires requires (T const v) { v.increment() } -> std::same_as<T>; }
auto increment(T value) -> T { return value.increment(); }
```

=== Keyword `concept`
Specifies a named type requirement. Conjunctions #hinweis[(&&)] and disjunctions #hinweis[(||)] can be used to
combine constraints #hinweis[(i.e. ```cpp requires std::integral<T> || std::floating_point<T>```)].

```cpp
template <typename T>
concept Incrementable = requires (T const v) { { v.increment() } -> std::same_as<T> };
```

Named requirements can then be used in template parameter declarations or as part of a requires clause.
```cpp
template <Incrementable T> // either here...
requires Incrementable<T> // ...or here
auto increment(T value) -> T { return value.increment(); }
```

=== Abbreviated Function Templates
`auto` can be used as parameter type instead of a template declaration.

```cpp
template <Incrementable T>
auto increment(T value) -> T { return value.increment(); }
// is equivalent to Terse Syntax
auto increment(Incrementable auto value) -> T { return value.increment() }:
```
If there are two `auto` arguments, two template typenames `T1`, `T2` get created.

=== STL Concepts
#hinweis[#cppr("concepts")[CPPReference: Concepts library]] #h(1fr) ```cpp #include <concepts>```\
The STL has predefined constraints:
_`std::equality_comparable`_ #hinweis[(can type be `==`/`!=` compared?)]
_`std::default_initializable`_ #hinweis[(can type be default constructed?)]
_`std::floating_point`_ #hinweis[(is type a floating point?)]


= Compile-Time Computation
#v(-0.75em)
== Constant expression context
These expressions always need to be defined at compile-time.
- Non-type template arguments #hinweis[(```cpp std::array<Element, 5> arr{};```)]
- Array bounds #hinweis[(```cpp double matrix[ROWS][COLS]{};```)]
- Case expressions #hinweis[(```cpp switch(value) { case 42: /* ... */ }```)]
- Enumerator initializers #hinweis[(```cpp enum Light { Off = 0, On = 1 };```)]
- Static Assertions #hinweis[(```cpp static_assert(order == 66);```)]
- `constexpr` / `constinit` variables #hinweis[(```cpp constexpr unsigned pi = 3;```)]
- `constexpr` if-statements #hinweis[(```cpp if constexpr (size > 0) { }```)]
- `noexcept` expressions #hinweis[(```cpp Blob(Blob &&) noexcept(true);```)]

== constexpr / constinit
_static `const` variables_ in namespace scope of built-in types initialized with a constant expression are usually put
into ROMable memory, if at all. Allowed in constant expression context. No complicated computations, no guarantee
to be done at compile-time.

_`constexpr`_ / _`constinit`_ Variables are _evaluated at compile-time_.
They are initialized by a constant expression and _require a literal type_ #hinweis[(primitive data type without heap allocation)].
They can be used in _constant expression contexts_.
Possible contexts are local scope, namespace scope and `static` data members.
- _`constexpr`_ variables are const, read only at run-time
- _`constinit`_ variables are non-const. They need to be initialized at compile-time, but can be changed at run-time.

=== `constexpr` Functions
- Can have _local variables of literal type_. The variables must be initialized before usage.
- Can use loops, recursion, arrays, references, branches
- Can contain branches that rely on _run-time only features_, if branch is not executed during compile-time computations
  #hinweis[(e.g. `throw`. Compilation error if `throw` is reached while compiling.)]
- Can _only call `constexpr` functions_.
- Are usable in `constexpr` and non-`constexpr` contexts #hinweis[(during runtime)]
- Can allocate dynamic memory that is cleaned up by the end of the compilation #hinweis[(since C++20)]
- Can be virtual member functions #hinweis[(since C++20)]

#v(-0.35em)
```cpp
constexpr auto factorial(unsigned n) -> unsigned { /* needs to have a body */ }
```

=== `consteval` Functions
Are usable in `constexpr` contexts only #hinweis[(can't be called during runtime)] and implicitly `const`.

```cpp
consteval auto factorial(unsigned n) {
  // ...
  return result;
}
constexpr auto factorialOf5 = factorial(5); // works

auto main() -> int {
  static_assert(factorialOf5 == 120); // works
  unsigned input{};
  if (std::cin >> input) {
    std::cout << factorial(input); // error, function cannot be used at runtime
} }
```

=== Undefined Behavior
There is _no undefined behavior during compile-time_. Instead, there will be a compilation error.
If `constexpr` evaluation does not reach an invalid statement, the code is still valid.

== Literal Types
#hinweis[#cppr("named_req/LiteralType")[CPPReference: Named Requirements - LiteralType]]\
Literal types are built-in scalar types #hinweis[(like `int`, `double`, pointers, `enums`)],
Structs with some restrictions #hinweis[(must have `constexpr` destructor and `constexpr` / `consteval` constructor)],
Lambdas, References, Arrays of literal types and `void` #hinweis[(for functions with side effects on literals)]

Literal Types can be used in `constexpr` functions, but only `constexpr` member functions can be called on values
of literal type. Non-`const` member functions can modify the object.

=== #highlight[Literal Class Type Example]
```cpp
template <typename T> // can be a template
class Vector {
  constexpr static size_t dimensions = 3;
  std::array<T, dimensions> values{};
public:
  constexpr Vector(T x, T y, T z) : values{x, y, z} {} // constexpr constructor
  constexpr auto length() const -> T { // constexpr const member function
    auto squares = x() * x() + y() * y() + z() * z();
    return std::sqrt(squares);
  }
  constexpr auto x() -> T& { return values[0]; } // constexpr non-const member function
  constexpr auto x() const -> T const& { return values[0]; }
} // implicit default destructor is also constexpr

constexpr auto create() -> Vector<double> {
  Vector<double> v{1.0, 1.0, 1.0}; v.x() = 2.0; return v; }
constexpr auto v = create();
auto main() -> int {
  //v.x() = 1.0; // possible if v was constinit
  auto v2 = create(); v2.x() = 2.0; } // v2 is a regular variable, can be modified
```

=== Compile-Time Computation with Variable Templates
#hinweis[(for Class Template see slides page 25)\ ]
Variable templates can be `constexpr`/`constinit` and defined recursively. _Usage:_ Template-ID

```cpp
template <size_t N>
constexpr size_t factorial = factorial<N-1> * N;

template <> // Base case
constexpr size_t factorial<0> = 1;
```

=== Captures as Literal Types
Capture types #hinweis[(the types returned by lambda expressions)] are literal types as well.
The can be used as types of `constexpr` variables and in `constexpr` functions.

== User-Defined Literals
#hinweis[#cppr("language/user_literal")[CPPReference: User-defined literals]]

#definition[`operator"" _UDLSuffix()"`]

Allows integer, floating-point, character, and string literals to produce objects of user-defined type by defining
a user-defined suffix. The suffix must start with an underscore. It allows to add dimension, conversion, etc.
If possible, define UDL operator functions as `constexpr.`
Usually a _conversion function_ like `safeToDouble()` and a _conversion operator_ is needed.
_Rule:_ put overloaded UDL operators that belong together in a separate namespace.

```cpp
namespace velocity::literals {
constexpr inline auto operator"" _kph(unsigned long long value) -> Speed<Kph>
  { return Speed<Kph>{safeToDouble(value)}; } // user defined literal operator, can be
                                              // called with Speed s = 80_kph;
template<typename T>
concept arithmetic = std::is_arithmetic_v<T>; // allows ints & floats in + operator

static constexpr inline auto safeToDouble(long double value) -> double {
  if (value > std::numeric_limits<double>::max()
   || value < std::numeric_limits<double>::min()) {
      throw std::invalid_argument{"Value must be within double range"};
  }
  return static_cast<double>(value);
}
} // namespace velocity::literals

struct Speed {
  constexpr explicit Speed(double value) : value{value} {};
  constexpr explicit operator double() const { return value; } // conversion to double
  auto constexpr operator +(arithmetic auto rhs) -> decltype(rhs) { return value + rhs }
private:
  double value{};
}
auto constexpr operator +(arithmetic auto lhs, Speed rhs) -> decltype(lhs)
  { return rhs + lhs; } // Make + operator commutative (value + Speed calls Speed + value)
```

*Signatures:* `unsigned long long` for integral constants, `long double` for floating point constants,\
`(char const *, size_t len) -> std::string` for string literals, `char const *` for a raw UDL operator
#hinweis[(i.e. to convert ints and floats to string, is not `constexpr`)].

=== Template UDL Operator
#definition[
  ```cpp
  template <char...>
  auto operator""_suffix() -> TYPE
  ```
]

Has an empty parameter list and a variadic template parameter. Characters of the literal are template arguments.
Often used for interpreting individual characters. Since C++20, the template UDL operator works with string literals as well
#hinweis[(example and compile-time steps in slides on page 42 - 44)].

*Standard Literal Suffixes:*
Do not have leading underscore: `std::string` #hinweis[(s)], `std::complex` #hinweis[(i, il, if)],
`std::chrono::duration` #hinweis[(ns, us, ms, s, min, h)]

== Preprocessor
`hello.cpp -> preprocessor -> hello.i -> compiler -> hello.o -> linker -> hello` #hinweis[(executable program)]

*Object-like Macros*
#v(-0.5em)
#definition[`#define identifier replacement-list new-line`]
_Identifier_ is a unique name, by convention in ALL_CAPS. Is valid until ```cpp #undef NAME```.
_Replacement-list_ is a possible empty sequence of preprocessor tokens. _New-line_ terminates the replacement list.\
_Example:_ ```cpp #define NUMBER_OF_ROWS 5```

*Function-like Macros*
#v(-0.5em)
#definition[`#define identifier ( identifier-list?, ?...? ) replacement-list new-line`]
Features an optional parameter list, containing only names. Params with a `#`-prefix turn into string literals.

*Includes:*
Textual inclusion of another file. _`#include "path"`_ for including a header file from the same project or workspace,
_`#include <path>`_ for external includes.\
*Conditional Includes:*
Enable a section depending on a condition. #hinweis[(example and macros in slides on page 52 - 61)].

#grid(
  [
    ```cpp
    #if constant-expression new-line
    #elif constant-expression new-line
    #else new-line
    #endif new-line
    ```
  ],
  [
    ```cpp
    #ifdef identifer new-line
    #ifndef identifier new-line
    ```
  ],
)


= Multi-Threading & Mutex
_`std::thread`_ to explicitly run a new thread,
_`std::async`_ to easily wrap a computation #hinweis[(possibly with a result)],
_`std::mutex`_ and co. to facilitate synchronization,
_`pthreads`_ is legacy. No portability guarantee.

== API of `std::thread`
#hinweis[#cppr("thread/thread")[CPPReference: `std::thread`]] #h(1fr) ```cpp #include <thread>```\

```cpp
auto main() -> int { std::thread greeter { [] { /*lambda*/ } }; greeter.join(); }
```

A new thread is created and started automatically. Creates a new execution context, `join()` waits for the thread to finish.
Besides _lambdas_, _functions_ or _functor objects_ can also be executed in a thread.
The _return value_ of the function is _ignored_. Threads are _default-constructible_ and _moveable_.
_Caution_: Program terminates if thread gets destructed without calling `join()` before!

```cpp
struct Functor {
  auto operator()() const -> void { std::cout << "Functor" << std::endl; }
};
auto function() -> void { std::cout << "Function" << std::endl; }
auto main() -> int {
  std::thread functionThread{function};
  std::thread functorThread{Functor{}};
  functorThread.join(); functionThread.join(); }
```

*Streams:*
Using global streams does not create data races, but sequencing of characters could be mixed.

*_`std::this_thread`_ helpers:*
_`get_id()`_ #hinweis[(An ID of the underlying OS thread)],
_`sleep_for(duration)`_/_`sleep_until(time_point)`_ #hinweis[(Suspends thread for/until time)],
_`yield()`_ #hinweis[(Allows OS to schedule another thread)].

=== Passing arguments to a `std::thread`
#definition[
  ```cpp
  template<class Function, class... Args>
  explicit thread(Function&& f, Args&&...args);
  ```
]

The _`std::thread` constructor_ takes a function/functor/lambda and arguments to forward.
You should pass all arguments _by value_ to avoid data races and dangling references.
_Capturing by reference_ in lambdas creates shared data as well
#hinweis[(if you have to use them, don't declare them as `mutable`)]!

```cpp
auto fibonacci(std::size_t n) -> std::size_t { /* ... */ }
auto printFib(std::size_t n) -> void { auto fib = fibonacci(n); /* print... */ }
auto main() -> int { std::thread function { printFib, 46 }; function.join(); }
```

Before the `std::thread` object is destroyed, you must _`join()`_ #hinweis[(wait until finished)]
or _`detach()`_ #hinweis[(detach from the main thread and run in the background)] the thread, otherwise you get a runtime error.

== `std::jthread`
#hinweis[#cppr("thread/jthread")[CPPReference: `std::jthread`]] #h(1fr) ```cpp #include <thread>```\
RAII wrapper that automatically calls `join()`.
Also supports external stop requests #hinweis[(Similar to Cancellation Token in C\#. `t.request_stop()` sends the request,
with `stop_requested()` it can be checked if a stop request has been received)].

== Inter-thread Communication
#hinweis[
  #cppr("thread/mutex")[CPPReference: `std::mutex`],
  #cppr("thread/shared_mutex.html")[CPPReference `std::shared_mutex`]
] #h(1fr) ```cpp #include <mutex>```\
Communication happens with _mutable shared state_. _Problem:_ Data Race.
_Solution:_ Locking the shared access or make access atomic.

All _mutexes_ provide the following operations:
- *Acquire:* `lock()` - blocking, `try_lock()` - non-blocking
- *Release:* `unlock()` - non-blocking

Two properties specify the capabilities:
- *Recursive:* Allow multiple nested acquire operations of the same thread #hinweis[(prevents self-deadlock)]
- *Timed:* Also provide timed acquire operations #hinweis[(`try_lock_for(duration), try_lock_until(time)`)]

_Reading operations don't need exclusive access_. Only concurrent writes need exclusive locking.
Use `std::shared_mutex`/`std::shared_timed_mutex` with `lock_shared()` to _read with multiple threads_.
Shared mutex also have the exclusive lock methods from a regular mutex.

=== Acquiring / Releasing Mutexes
#hinweis[
  #cppr("thread/lock_guard")[CPPReference: `std::lock_guard`],
  #cppr("thread/scoped_lock")[CPPReference: `std::scoped_lock`],
  #cppr("thread/unique_lock")[CPPReference: `std::unique_lock`] #h(1fr) ```cpp #include <mutex>```\
  #cppr("thread/shared_lock")[CPPReference: `std::shared_lock`],
  #cppr("thread/condition_variable")[CPPReference: `std::condition_variable`] #h(1fr) ```cpp #include <shared_mutex>```\
]
Usually you use a lock that manages the mutex:
- _`std::lock_guard`_: RAII wrapper for a single mutex. Locks immediately when constructed, unlocks when destructed.
- _`std::scoped_lock`_: RAII wrapper for multiple mutexes. Locks immediately when constructed, unlocks when destructed.
  Acquires multiple locks in the constructor, avoids deadlocks by relying on internal sequence.
  Blocks until all locks could be acquired. #hinweis[(`std::scoped_lock both{mx, other.mx};`)]
- _`std::unique_lock`_: Mutex wrapper that allows deferred and timed locking.
  Similar interface to timed mutex, allows explicit locking/unlocking. Unlocks when destructed.
- _`std::shared_lock`_: Wrapper for shared mutexes. Allows explicit locking/unlocking, unlocks when destructed.
- _`std::condition_variable`:_ Condition. Waits for the condition and then notifies a potential change.
  Wait will go into sleep again if the actual condition has not been met yet.
  #hinweis[(`wait(<mutex>, <predicate>), wait_for(), wait_until(), notify_one(), notify_all()`)]

*Standard Containers and Concurrency:*
There is no thread-safety wrapper for standard containers. Access to different individual elements from different threads
is _not_ a data race. Almost all other concurrent uses of containers are _dangerous_.
`shared_ptr` copies to the same object can be used from different threads, but accessing the object itself
can race if non-const #hinweis[(reference counter is atomic)].

=== #highlight[Thread-safe Guard Example (Testat 3)]
_Scoped Lock Pattern:_ Create a lock guard that (un)locks the mutex automatically.
Every member function is mutually exclusive because of scoped locking pattern.
_Strategized Lock Pattern:_ Template Parameter for mutex type.

```cpp
template <typename T,
          typename MUTEX = std::mutex, typename CONDITION = std::condition_variable>
struct threadsafe_queue {
  using guard = std::lock_guard<MUTEX>;
  using lock = std::unique_lock<MUTEX>;
  template <typename ForwardType>
  auto push(ForwardType &&t) -> void {
    guard lk{mx}; q.push(std::forward<ForwardType>(t)); not_empty.notify_one();
  }
  auto pop() -> T {
    lock lk{mx}; // wait requires timed locking therefore unique_lock
    not_empty.wait(lk, [this]{ return !q.empty(); }); // checked once, no busy wait
    T t = q.front();
    q.pop();
    return t;
  }
  auto try_pop(T & t) -> bool {
   guard lk{mx}; if (q.empty()) { return false; } t = q.front(); q.pop(); return true;
  }
  // call container empty, not this->empty, would cause deadlock
  auto empty() const -> bool { guard lk{mx}; return q.empty(); }
private:
  std::queue<T> q{};
  mutable MUTEX mx{}; // mutable to unlock in const member functions
  CONDITION not_empty{};
}; // Mutex & condition_variable don't need to be swap()-ed. But notify them of changes!
```

== Returning Results from Threads
We can use shared state to "return" results. _Acquire lock_ in producer, _write_ the shared result, _wait_ for the result,
_read_ the result. We cannot communicate exceptions!

```cpp
auto main() -> int {
  auto mutex = std::mutex{}; auto finished = std::condition_variable{}; auto shared = 0;
  auto thread = std::thread{[&]{
    std::this_thread::sleep_for(2s);
    auto guard = std::lock_guard{mutex}; // Lock the mutex
    shared = 42; finished.notify_all(); // Wakes up all threads waiting on condition
  }}; // Mutex is unlocked when guard goes out of scope
  std::this_thread::sleep_for(1s);
  auto lock = std::unique_lock{mutex}; // Lock the mutex
  finished.wait(lock); // Release mutex, wait until thread unlocks mutex, lock it again
  std::cout << "The answer is: " << shared << "\n"; thread.join(); }
```

=== `std::future`
#hinweis[#cppr("thread/future")[CPPReference: `std::future`]] #h(1fr) ```cpp #include <future>```\
Future represents results that may be computed asynchronously. They allow us to _wait until the result is available_...
- ```cpp wait()```: blocks until available,
- ```cpp wait_for(<timeout>)```: blocks until available or timeout elapsed,
- ```cpp wait_until(<time>)```: blocks until available or the timepoint has been reached
#v(-0.5em)
...and then _get the result_
- ```cpp get()```: blocks until available and returns the result value or throws

Their destructor may wait for the result to become available.

=== `std::promise`
#hinweis[#cppr("thread/promise")[CPPReference: `std::promise`]] #h(1fr) ```cpp #include <future>```\
Promises are the origin of futures. They allow us to _obtain_ a future using `get_future()` and _publish_ results or errors
#hinweis[
  (```cpp set_result(<result_value>)``` -- set the associated future's result to `result_value`,
  ```cpp set_exception(<exception pointer>)``` -- set the associated future's exception)
].

```cpp
auto main() -> int {
  using namespace std::chrono_literals;
  std::promise<int> promise{}; auto result = promise.get_future();
  auto thread = std::thread{
    [&]{std::this_thread::sleep_for(2s); promise.set_value(42); }
  }
  std::this_thread::sleep_for(1s);
  std::cout << "The answer is: " << result.get() << "\n"; thread.join(); }
```

== `std::async`
#hinweis[#cppr("thread/async")[CPPReference: `std::async`]] #h(1fr) ```cpp #include <future>```\
Ready made _solution for computing asynchronously_. It allows us to _return our result_ from our computation function.
Additionally, it _catches all exceptions_ and propagates them.

#definition[
  ```cpp
  template<typename Function, typename ...Args>
  auto async(Function&& f, Args&&... args) -> std::future</* implicitly from f */>;
  ```
]

```cpp
auto main() -> int {
  auto the_answer = std::async([] { /* calculate a while ... */ return 42; });
  std::cout << "The answer is: " << the_answer.get() << "\n"; }
```

This function _returns a `std::future`_ that will store the result. `get()` waits for the result to be available.\
`std::async` can take an argument of type _`std::launch`_ #hinweis[(launch policy)]:
_`std::launch::async`_ launches a new thread and executes it regardless of if we need the result or not,
_`std::launch::deferred`_ defers execution until the result is obtained from the `std::future` #hinweis[(lazy evaluation)],
which computes the result on the thread calling `get()`.
The default policy is ```cpp std::launch::async | std::launch::deferred``` #hinweis[(environment dependent)].


= Memory Model & Atomics
The _C++ Standard_ defines an _abstract machine_ which describes _how a program is executed_.
_Platform specifics_ are _no longer relevant_ with this abstraction.
Represents the _"minimal viable computer"_ required to execute a C++ program.
The abstract machine defines in _what order initialization_ takes place and in _what order_ a program is executed.
It defines what a _thread_ is, what a _memory location_ is, how threads _interact_ and what constitutes a _data race_.

*Memory Location:*
An object of scalar type #hinweis[(Arithmetic, pointer, enum, `std::nullptr`.
These values have the same amount of bits as the architecture defines, like 64-bit)].\
*Conflict:*
Two expression evaluations run in parallel. Both access the same Memory Location #hinweis[(at least one write, one read)]\
*Data Race:*
The program contains two conflicting actions. Undefined Behavior!

== Memory Model
The C++ _Memory Model_ defines when the effect of an operation is visible to other threads and
how and when operations might be reordered. The Memory orderings define when effects become visible.
- _Sequentially-consistent_ #hinweis[(Same as code ordering and the default behavior)],
- _Acquire/Release_ #hinweis[(Weaker guarantees than sequentially-consistent)],
- _Consume_ #hinweis[(Discouraged, slightly weaker than acquire-release)] and
- _Relaxed_ #hinweis[(No guarantees besides atomicity)].

*Visibility of effects:* #hinweis[(if one thread modifies a variable, under what conditions is
another thread guaranteed to see that modification?)]\
_sequenced-before:_ #hinweis[(A comes before B within a single thread)],
_synchronizes-with:_ #hinweis[(inter-thread sync, event that makes another thread see it, i.e. with Mutex)].
_happens-before:_ #hinweis[(A happens-before B if A is sequenced-before or synchronizes-with B)],

Read/Writes in a single statement are "unsequenced": ```cpp std::cout << ++i << ++i; // output unknown```

=== Atomics
#hinweis[
  #cppr("atomic/atomic")[CPPReference: `std::atomic`],
  #cppr("atomic/atomic_flag")[CPPReference: `std::atomic_flag`],
  #cppr("atomic/memory_order")[CPPReference: `std::memory_order`]
]
#h(1fr) ```cpp #include <atomic>```\
Template class to create atomic types. Atomics are guaranteed to be _data-race free_.
There are several specializations in the standard library. The most basic type _`std::atomic_flag`_ is lock-free.

```cpp
auto outputWhenReady(std::atomic_flag & flag, std::ostream & out) -> void {
  // start critical section
  while (flag.test_and_set() /* set flag to true and returns old value */) yield();
  out << "Here is thread: " << get_id() << std::endl;
  flag.clear(); // sets the flag to false
} // end critical section

auto main() -> int {
  std::atomic_flag flag { };
  std::thread t { [&flag] { outputWhenReady(flag, std::cout);} };
  outputWhenReady(flag, std::cout); t.join(); }
```
When creating your own atomic type with `std::atomic<T>`, the atomic member operations are:
- _`void store(T)`_ #hinweis[(set the new value)]
- _`T load()`_ #hinweis[(get the current value)]
- _`T exchange(T)`_ #hinweis[(set the new value and return the old one)]
- _`bool compare_exchange_weak(T & expected, T desired)`_ #hinweis[(compare expected with current value,
  if equal replace the current value with desired, otherwise replace expected with current value. May spuriously fail)]
- _`bool compare_exchange_strong(T & expected, T desired)`_ #hinweis[(cannot fail spuriously, but slower)]

*Applying Memory Orders:*
All atomic operations take an additional argument to specify the memory order #hinweis[(Type `std::memory_order`)].
e.g. ```cpp flag.clear(std::memory_order::seq_cst);```

- *Sequential Consistency (`seq_cst`):* Global execution order of operations. Every thread observes the same order.
  This is the Default behavior. The latest modification will be available to a read operation.
- *Acquire (`acquire`):* No reads or writes in the current thread can be reordered _before_ this load.
  All writes in other threads that _release the same atomic_ are visible in the current thread.
  _Not guaranteed_ to _see latest write_ (Half Fence), but ordering is consistent.
- *Release (`release`):* No reads or writes in the current thread can be reordered _after_ this store.
  All writes in the current thread are visible in other threads that _acquire the same atomic_.
- *Acquire/Release (`acq_rel`):* Guaranteed to work on the latest value unlike Acquire, used for Read-Modify-Write operations
  (Full Fence) e.g. ```cpp test_and_set(...)```.
- *Relaxed (`relaxed`):* Does not give promises about sequencing. No data-races for atomic variables.
  Order can be inconsistent #hinweis[(parallel `load()`/`store()`)] (Lost Updates), but may be more efficient.
  Difficult to get right.
- *Release/Consume:* Do not use! Data-dependency, hard to use. Better use `acquire`.

=== Custom Types with `std::atomic`
Custom types need to be trivially copyable. You _cannot have_ a custom copy ctor, move ctor, copy assignment or move assignment.
Object can only be accessed as a whole. No member access operator.

== Volatile
#definition[```cpp volatile int mem{0};```]

Volatile in C++ is _different_ from volatile in Java and C\#. Load and store operations of volatile variables must
_not be elided_, even if the compiler cannot see any visible side-effects within the same thread.
Prevents the compiler from _reordering_ within the same thread #hinweis[(but the hardware might reorder instructions anyway)].
Useful when accessing _memory-mapped hardware_. _Never use for inter-thread communication!_

== Interrupts
Interrupts are _events originating from underlying system_ which _interrupt the normal execution_ flow of the program.
Depending on the platform, they _can be suppressed_. When an interrupt occurs, a _previously registered function_ is called
#hinweis[("Interrupt Service Routines" -- ISRs)]. Should be _short_ and must _run to completion_.
After the interrupt was handled, execution of the program resumes.

Data _shared_ between an ISR and the normal program execution needs to be _protected_.
All accesses must be _atomic_, modifications need to become _visible_.
_`volatile`_ helps because it suppresses compiler optimizations.
Interrupts may need to be _disabled temporarily_ to guarantee atomicity.


= Network & Async
_Sockets_ are an abstraction of endpoints for communication.
- *TCP Sockets* are reliable, stream-oriented and require a connection setup
- *UDP Sockets* are unreliable, datagram-oriented and do not require a connection setup.

*Connection-Oriented Communication Pattern using Sockets:*
#grid(
  columns: (1.05fr, 1fr),
  align: horizon,
  [
    _Socket:_ Create a new communication end point\
    _Bind:_ Attach a local address to a socket #hinweis[(IP, Port)]\
    _Listen:_ Announce willingness to accept connections
    _Accept:_ Block caller until a connection request arrives\
    _Connect:_ Actively attempt to establish a connection\
    _Send:_ Send some data over the connection\
    _Receive:_ Receive some data over the connection
    _Close:_ Release the connection
  ],
  image("img/cpla_03.png"),
)

== Data Sources / Buffers
Transmit/Receive functions need _sources_ or _destination_ buffers. The ASIO library doesn't manage memory!\
*Fixed Size Buffers:* `asio::buffer()`.
Must provide at least as much memory as will be read. Can use several standard containers as a backend.
Pointer + Size combinations are available.\
*Dynamically Sized Buffers:* `asio::dynamic_buffer()`
Use if you do not know the required space and with `std::string` and `std::vector`.\
*Streambuf Buffers:* `asio::streambuf`.
Works with `std::istream` and `std::ostream`

== ASIO Library
#hinweis[#cppr("experimental/networking")[CPPReference: Extensions for networking]]
#h(1fr) ```cpp #include <asio.hpp>``` #hinweis[(if installed)]\
#v(-0.5em)

=== Example: Synchronous TCP Client Connection with ASIO
*Socket:*
All ASIO Operations require an I/O context. Create a TCP Socket using the context.
There are asynchronous and synchronous functions to communicate with sockets.

```cpp
asio::io_context context{}; // multiple contexts possible
asio::ip::tcp::socket socket{context}; // multiple sockets per context possible
```
*Connect:*
If the IP address is known, an endpoint can be constructed easily.
`socket.connect()` tries to establish a connection to the given endpoint.

```cpp
auto address = asio::ip::make_address("127.0.0.1");
auto endpoint = asio::ip::tcp::endpoint(address, 80); socket.connect(endpoint);
```

A resolver resolves the host names to endpoints. `asio::connect()` tries to establish a connection.
```cpp
asio::ip::tcp::resolver resolver{context};
auto endpoints = resolver.resolve(domain, "80"); asio::connect(socket, endpoints);
```

*Write:*
`asio::write()` sends data to the peer the socket is connected to.
It returns when all data is sent or an error occurred #hinweis[(`asio::system_error`)].

```cpp
std::ostringstream request{};
request << "GET / HTTP/1.1\r\n";
request << "Host: " << domain << "\r\n"; request << "\r\n";
asio::write(socket, asio::buffer(request.str())); // Blocks until data is sent
```

*Read:*
`asio::read()` receives data sent by the peer the socket is connected to.
It returns when the read-buffer is full, when an error occurred or when the stream is closed.
The error code is set if a problem occurs, or the stream has been closed #hinweis[(`asio::error::eof`)].

```cpp
constexpr size_t bufferSize = 1024; std::array<char, bufferSize> reply{};
asio::error_code errorCode{};
auto readLength = asio::read(socket, asio::buffer(reply.data(), bufferSize), errorCode);
```

*Advanced Reading:*
`asio::read` also allows to specify completion conditions.
- _`asio::transfer_all()`_ #hinweis[(Default behavior, transfer all data or until buffer is full)]
- _`asio::transfer_at_least(std::size_t bytes)`_ #hinweis[(Read at least `bytes` number of bytes, may transfer more)]
- _`asio::transfer_exactly(std::size_t bytes)`_ #hinweis[(Read exactly `bytes` number of bytes)]

`asio::read_until` allows to specify conditions on the data being read.
- Simple matching of characters or strings #hinweis[(read until "x")] or more complex matching using `std::regex`
- Allows to specify a callable object #hinweis[(predicate $->$ can be iterated over, returns sent data if predicate true.\
  Expects ```cpp std::pair<iterator, bool> operator()(iterator begin, iterator end)```)]

*Close:*
`shutdown()` closes the read/write stream associated with the socket.
The destructor cancels all pending operations and destroys the object.

```cpp
socket.shutdown(asio::ip::tcp::socket::shutdown:both); // close read and write end
socket.close();
```

=== Example: Synchronous TCP Server with ASIO
*Socket, Bind & Listen:*
An _acceptor_ is a special socket responsible for establishing incoming connections.
Is bound to a given local end point and starts listening automatically.

```cpp
asio::io_context context{};
asio::ip::tcp::endpoint localEndpoint{asio::ip::tcp::v4(), port}; //uses an available IPv4
asio::ip::tcp::acceptor acceptor{context, localEndpoint};
```

*Accept:*
`accept()` blocks until a client tries to establish a connection #hinweis[(with `connect`)].
It returns a new socket through which the connected client can be reached.

```cpp
asio::ip::tcp::endpoint peerEndpoint{}; // information about client
asio::ip::tcp::socket peerSocket = acceptor.accept(peerEndpoint);
```

=== Async communication
*Handling multiple requests simultaneously:* Using synchronous operations blocks the current thread.
_Asynchronous Operations_ allow further processing of other requests while the async operation is executed.
Most OS support asynchronous IO operations.

+ The program _invokes an async operation_ on an I/O object #hinweis[(socket)] & _passes a completion handler_ callback.
+ The I/O object _delegates_ the operation and the callback to its _`io_context`_.
+ The OS _performs_ the asynchronous operation.
+ The OS _signals_ the `io_context` that the operation has been _completed_.
+ When the program calls `io_context::run()` the _remaining_ asynchronous operations are _performed_
  #hinweis[(wait for the result of the operating system)].
+ Still inside the `io_context::run()` the _completion handler_ is called to handle the _result_ of the asynchronous operation.

=== Asynchronous Read/Write on Sockets
- _Async read operations:_ `asio::async_read`, `asio::async_read_until`, `asio::read_at` #hinweis[(certain position in buf.)]
- _Async write operations:_ `asio::async_write`, `asio::async_write_at`

They return immediately. The operation is processed by the executor associated with the stream's `asio:io_context`.
A completion handler is called when the operation is done.

```cpp
// Reads from async stream into buffer until '\n' is reached, then calls completion handl.
auto readCompletionHandler = [] (asio::error_code ec, std::size_t len_of_read) { /*...*/ }
asio::async_read_until(socket, buffer, '\n', readCompletionHandler);

// Writes data from a buffer to async stream until data has been written
// or an error occurs. Then calls the completion handler.
auto writeCompletionHandler = [] (asio::error_code ec, std::size_t len_of_write) {/*...*/}
asio::async_write(socket, buffer, writeCompletionHandler);
```

=== Asynchronous Acceptor
Create an _accept handler_ that is called when an incoming connection has been established.
The second parameter is the socket of the newly connected client.
A `session` object is created on the heap to handle all communication with the client.
`accept()` is called to _continue new inbound connection attempts_.
The accept handler is registered to handle the next accept asynchronously.

The constructor creates the server. It initializes its acceptor with the given `io_context` and port.
It calls `accept()` for registering the accept handler and does not block.
To use it, create an `io_context` and the `server`.
The executor will run until no async operation is left thanks to `async_accept()`.
It is important that the server lives as long as async operations on it are processed.

```cpp
struct Server { using tcp = asio::ip::tcp;
  Server(asio::io_context &c, unsigned short port)
    : acceptor{c, tcp::endpoint{tcp::v4(), port}} { accept(); }
private:
  auto accept() -> void {
    auto acceptHandler = [this](asio::error_code ec, tcp::socket peer) {
      if (!ec) { // start new session if no error has occurred
        auto session = std::make_shared<Session>(std::move(peer));
        session->start();
      }
      accept(); // call accept again to continue accepting new connections.
    };          // If not done only one client session request will ever be handled
    acceptor.async_accept(acceptHandler); // Register acceptHandler to handle next accept
  }
  tcp::acceptor acceptor;
};
auto main() -> int {
  asio::io_context context{}; Server server{context, 1234}; context.run();
}
```

=== Session with Asynchronous IO
The constructor stores the socket with the client connection.
_`start()`_ initializes the first async read, _`read()`_ invokes async reading. _`write()`_ invokes async writing.
The fields store the data of the session. _`enable_shared_from_this`_ is needed because the session object
would die at the end of the accept handler, therefore it needs to be allocated on the heap.
The _handlers need to keep the object alive_ by pointing on it on the heap.
If there is no pointer to the object left, it gets deleted.

```cpp
struct Session : std::enable_shared_from_this<Session> {
  explicit Session(asio::ip::tcp::socket socket); auto start() -> void { read(); }
private:
  auto read() -> void; auto write(std::string data) -> void;
  asio::streambuf buffer{}; std::istream input{&buffer}; asio::ip::tcp::socket socket;
};
// Code in Accept handler
auto session = std::make_shared<Session>(std::move(peer)); session->start();
accept(); // if not called, only single connection possible
// Code in Read handler
auto Session::read() -> void { auto readComplHandl = [self = shared_from_this()] /*...*/}
// Code in Write handler
auto Session::write(std::string input) -> void {
  auto data = std::make_shared<std::string>(input);
  auto writeCompletionHandler = [self = shared_from_this(), data] /*...*/}
```

=== Async Operation without Callbacks
Async operations can work "without" callbacks. Specify "special" objects as callbacks.
- _`asio::use_future`:_ Returns a `std::future<T>`. Errors are communicated via exception in future
- _`asio::detached`:_ Ignores the result of the operation
- _`asio::use_awaitable`:_ Returns a `std::awaitable<T>` that can be awaited in a coroutine. Complicated!

== Signal Handling
#hinweis[#cppr("header/csignal")[CPPReference: Standard library header `<csignal>`]] #h(1fr) ```cpp #include <csignal>```\
Most OS support signals. Signals provide asynchronous notifications.
They are used to gracefully terminate a program, communicate errors, notify about traps #hinweis[("it's a trap!")]

_`SIGTERM`_ #hinweis[(Termination requested)],
_`SIGSEGV`_ #hinweis[(Invalid memory access)],
_`SIGINT`_ #hinweis[(User interrupt)],
_`SIGILL`_ #hinweis[(Illegal Instruction)],
_`SIGABRT`_ #hinweis[(Abnormal termination)],
_`SIGFPE`_ #hinweis[(Floating-point exception)]

=== Signal Handling in ASIO
`asio::signal_set` defines a set of signals to wait for.
Handlers can be set up with ```cpp signal_set.wait()```/```cpp signal_set.async_wait()``` that take a lambda.
The signal handler receives the signal that occurred and an error if the wait was aborted: ```cpp [&](auto error, auto sig){...}```
Useful to cleanly stop server applications.

== Accessing Shared Data
Multiple async operations can be in flight.
All completion handlers are dispatched through `asio::io_context` and run on a thread executing `io_context.run()`.
Multiple threads can call `run()` on the same `asio::io_context`. This results in a possible data race.

=== Strands
Strands are a mechanism to _ensure sequential execution_ of handlers.
- _Implicit strands:_ If only one thread calls `io_context.run()` or program logic ensures only one operation
  is in progress at a time.
- _Explicit strands:_ For multiple threads on the same `io_context`. Objects of type `asio::strand<...>`.
  Created using ```cpp asio::make_strand(executor)``` or ```cpp asio::make_strand(execution_context)```.
  Applied to handlers using ```cpp asio::bind_executor(strand, handler)```.

```cpp
// globally accessible
auto results = std::vector<int> { }; auto strand = asio::make_strand(context);
// in connection class
asio::async_read(socket, asio::buffer(buffer),
  asio::bind_executor(strand, [&](auto err, auto bytes) { // wrap access in bind_executor
    auto result = parse(buffer); results.push_back(result); /* bye bye data race */ }));
```


= Advanced Library Design
#v(-0.75em)
== Exception Safety
There is code that _handles_ exceptions, code that _throws_ exception, and _exception neutral code_
#hinweis[(does not throw, does not catch, just forwards exceptions)].
Exception safety is important in generic code that manages resources or data structures
#hinweis[(might call user-defined operations, must not garble its data structures and must not leak resources)]

The _deterministic lifetime model of C++_ requires exception safety.
When an exception is thrown, "stack unwinding" ends the lifetime of temporary and local objects.
Throwing an exception while another exception is "in flight" in the same thread causes the program to terminate.

=== Safety Levels (from highest to lowest)
- _`noexcept` aka `no-throw`:_ Will never throw an exception #hinweis[(and is always successful)].
  Very hard to achieve, sometimes even impossible, e.g. memory allocation.
  #hinweis[(*Examples*: Swap, Move Constructor, Move Assignment Operator, `std::vector<T>::clear()`]
- _Strong exception safety:_ Operation succeeds and doesn't throw, or nothing happens but an exception is thrown
  #hinweis[(transaction, compare DB transactions)]. Hard to achieve.
  #hinweis[(*Examples*: Copy Constructor, Copy Assignment Operator (Copy-Swap Idiom))]
- _Basic exception safety:_ Does not leak resources or garble internal data structures in case of an exception
  #hinweis[(guarantees invariance)], but operations might be only half-done
  #hinweis[(i.e. if copy throws, but internal members have not been adjusted yet)]
  ```cpp
  auto push(value_type const & elem) -> void {
    value_type val{elem}; // might throw here due to copy operation failing
    tail_ = (tail_ + 1) % (capacity() + 1); elements_++; /*elements not yet changed*/}
  ```
- _No guarantee:_ Often unintentional, but happens. Invalid or corrupted data when an exception is thrown.

A function can only be as exception-safe as the weakest sub-function it calls!

#table(
  columns: (1fr,) * 4,
  table.header([], [Invariant OK], [All or Nothing], [Will Not Throw]),
  [*No Guarantee*], cell-cross, cell-cross, cell-cross,
  [*Basic Guarantee*], cell-check, cell-cross, cell-cross,
  [*Strong Guarantee*], cell-check, cell-check, cell-cross,
  [*No-Throw Guarantee*], cell-check, cell-check, cell-check,
)

#v(-0.5em)
=== `noexcept` Keyword
#hinweis[#cppr("language/noexcept_spec")[CPPReference: noexcept specifier]]\
`noexcept` belongs to the function signature. You _cannot overload_ on `noexcept`.
_`noexcept(expression)`_ can be used to determine the _"noexceptiness"_ of an expression, without computing it.
```cpp noexcept(noexcept(f()))``` means "Outer function is `noexcept`, if function `f()` is also `noexcept`".

The compiler might _optimize_ a call of a `noexcept` function _better_.
But if you throw an exception from a `noexcept` function, `std::terminate()` will be called.

=== Member Functions that should not throw
- _Destructors_ must not throw when used during stack unwinding
- _Move construction_ and _move assignment_ better not throw #hinweis[(This is why it often uses swap internally)]
- _swap_ should not throw #hinweis[(`std::swap` requires non-throwing move operations)]
- _Copying_ might throw, when memory needs to be allocated

=== Standard Library Helpers
#hinweis[#cppr("utility/move_if_noexcept")[CPPReference: `std::move_if_noexcept`]] #h(1fr) ```cpp #include <utility>```\
It may be hard for a container to implement its move operations if the element type does not support `noexcept`-move.
Use `std::move_if_noexcept` instead: If `noexcept`, then move.

```cpp
explicit Box(T && t) noexcept(noexcept(T(std::move_if_noexcept(t))))
  : value(std::move_if_noexcept(t)) { ... }
```
There are other helpers like `is_nothrow_...`:\
`constructible`, `move_constructible`, `default_constructible`, `assignable`, `move_assignable`, `copy_assignable`,
`destructible`, `copy_constructible`,  `swappable`

=== Wide and narrow contracts
- _Wide Contract:_ A function that can handle all argument values of the given parameter types successfully.
  It cannot fail and should be specified as `noexcept(true)`. `this`, global and external resources are also possible parameters.
- _Narrow Contract:_ A function that has preconditions on its parameters, e.g. `int` parameter must not be negative.
  Even if not checked and no exception is thrown, those functions _should not be `noexcept`_.
  This allows later checking and throwing.

== PImpl Idiom (Pointer to Implementation Idiom)
#hinweis[#cppr("language/pimpl")[CPPReference: PImpl]]\
*Opaque/Incomplete Types:* Name known #hinweis[(declared)], but not the content. Introduced by a forward declaration.
Can be used for pointers and references, but it cannot dereference values or access members without a later definition.

```cpp
struct S; // Forward Declaration
auto foo(S & s) -> void { foo(s); /* S s{}; is invalid */}
struct S{}; // Definition
auto main() -> int { S s{}; foo(s); /* s can now be used */ }
```
*Problem:*
Internal changes in a class' definition require clients to re-compile #hinweis[(e.g. changing a type of a private member variable)].
*Solution:*
Create a "Compilation Firewall": Allow changes to implementation without the need to recompile users.
It can be used to shield client code from implementation changes, meaning you must not change header files
your client relies upon.

Put in the "exported" header file a class consisting of a "Pointer to Implementation" plus all public members.
Basically place all public definition in the header file.

With _`std::shared_ptr<class Impl>`_ we can use a minimal header and hide all details in the implementation `WizardImpl`.
The `Wizard` class called from the header delegates all calls to `WizardImpl`.

#grid(
  gutter: 0em,
  [
    ```cpp
    // wizard.hpp: Minimal Header
    class Wizard {
      std::shared_ptr<class WizardImpl> pImpl;
    public:
      Wizard(std::string name = "Rincewind");
      auto doMagic(std::string wish)
        -> std::string;
    };
    ```
  ],
  [
    ```cpp
    // WizardImpl.cpp: Full implementation of
    // WizardImpl (all private members, not shown
    // here) and Wizard (PImpl & public methods)
    Wizard::Wizard(std::string name) :
     pImpl{std::make_shared<WizardImpl>(name)}{}

    auto Wizard::doMagic(std::string wish)
      -> std::string {
      return pImpl->doMagic(wish);
    }
    ```
  ],
)

With _`std::unique_ptr<class Impl>`_ we need to define the destructor of `Wizard` after the definition of `WizardImpl`.
The compiler can't move the destructor by himself.

#grid(
  [
    ```cpp
    // wizard.hpp
    class Wizard {
      std::unique_ptr<class WizardImpl> pImpl;
    public:
      Wizard(std::string name);
      ~Wizard(); // define explicitly
      auto doMagic(std::string wish)
        -> std::string; };
    ```
  ],
  [
    ```cpp
    // WizardImpl.cpp
    class WizardImpl { /* ... */ };
    // ...
    Wizard::~Wizard() = default;
    ```
    Because the default deleter of `std::unique_ptr` can't delete an incomplete type, we need to define
    the destructor explicitly.
  ],
)

=== Design Decisions with PImpl Idiom
How should objects be copied?
- _No copying - only moving:_ `std::unique_ptr<class Impl>` #hinweis[(declare destructor and move operations `&= default`)]
- _Shallow copying:_ `std::shared_ptr<class Impl>` #hinweis[(sharing the implementation)]
- _Deep copying:_ `std::unique_ptr<class Impl>` #hinweis[(with DIY copy constructor of Impl, default for C++)]

Never do `pImpl == nullptr`, and do not inherit from PImpl class.


= Hourglass Interfaces
#v(-0.75em)
== Application Binary Interfaces (ABI)
ABIs define _how programs interact_ on a _binary level_
#hinweis[(Names of structures and functions, calling conventions, Instruction sets)].
_C++ does not define_ any specific ABI, because they are _tightly coupled_ to the platform.
They change between OSes, compiler versions, library versions, etc.
Different STL implementations are #hinweis[(usually)] incompatible.

Use _C(89)_ as an "intermediate" layer, as "C frontend for our C++ code". This is a _extremely stable ABI_.
No namespaces, no name mangling. But there are also no member functions, no exceptions and no templates.

#align(center, image("img/cpla_04.png", width: 70%))

=== Example: Wizard Class
```cpp
// C++ Library
struct Wizard {
  Wizard(std::string name = "Rincewind") : name{name}, wand{} {}
  auto doMagic(std::string const & wish) -> char const *;
  auto learnSpell(std::string const & newSpell) -> void;
  auto mixAndStorePotion(std::string const & potion) -> void;
  auto getName() const -> char const * { return name.c_str(); }
};
// C++ Client / Tests: Work normally as you would expect
using wizard_client::Wizard;
TEST(canCreateDefaultWizard) {
  Wizard const magician{};
  ASSERT_EQUAL("Rincewind", magician.getName());
}
```

*Background C API:*
Abstract data types can be _represented by pointers_. Ultimate abstract pointer: `void *`.
Member functions map to functions taking the abstract data type pointer as first argument.
Requires _factory and disposal functions_ to manage object lifetime. Strings can only be represented by `char *`.
Make sure to not return pointers to temporary objects. Exceptions do not work across a C API, use a `Error` struct.

```cpp
// C Header / C API DLL (Wizard.h)
#ifdef __cplusplus // 'extern' only compiles with a CPP, not C compiler
extern "C" { // mark header file as C to disable name mangling
#endif
typedef struct Wizard * wizard; // Wizard can only be accessed through pointers
typedef struct Wizard const * cwizard;
typedef struct Error * error_t; // Stores exception messages, needs to be cleaned up
wizard createWizard(char const * name, error_t * out_error); // Factory func to wrap ctor
void disposeWizard(wizard toDispose); // Factory function to wrap destructor
char const * error_message(error_t error); // Allocates error message on the heap
void error_dispose(error_t error); // Removes error message from the heap
char const * doMagic(wizard w, char const * wish, error_t *out_error);
void learnSpell(wizard w, char const * spell);
void mixAndStorePotion(wizard w, char const * potion);
char const *wizardName(cwizard w); // All member funcs take a wizard pointer as first arg
#ifdef __cplusplus
}
#endif
```

*Parts of C++ that can be used in an extern "C" interface:*
- Functions, but not templates. No overloading!
- C primitive Types #hinweis[(`char`, `int`, `double`, `void`)]
- Pointers, including function pointers
- Forward-declared structs
- Unscoped Enums without class or base types
- If using from C you must embrace it with `extern "C"` when compiling it with C++ #hinweis[(`extern "C" {}`)]

*Implementing the Opaque Wizard Type:*
Wizard class must be implemented. To allow full C++ including templates, we need to use a "trampoline" class.
It wraps the actual Wizard implementation.

#grid(
  [
    ```cpp
    // Wizard.cpp
    extern "C" {
    struct Wizard { // C linkage trampoline
      Wizard(char const * name) : wiz{name} {}
      unseen::Wizard wiz;
    };
    ```
  ],
  [
    ```cpp
    // WizardHidden.hpp
    namespace unseen {
    struct Wizard {
      /* see code from C++ library above */ };
    }
    ```
  ],
)

*Dealing with Exceptions:*
You can't use references in C API, you must use pointers to pointers. In case of an error, allocate error value on the heap.
You must provide a disposal function to clean up. Internally, you can use C++ types, but you should return `char const *`,
because the caller owns the object providing memory.\
*Creating Error Messages from Exceptions:*
Call the function body and catch expressions. Map them to an `Error` object, set the pointer pointed to by `out_error`.
Passed out `out_error` must not be `nullptr`! ```cpp *out_error = new Error{"Unknown internal error"}``` \
*Error Handling at Client Side:*
Client-side C++ usage requires mapping error codes back to exceptions. Unfortunately, the exception type doesn't map through.
But you can use a generic standard exception #hinweis[(`std::runtime_error`)]. There is a dedicated RAII class for disposal.
You could also use a _temporary object with throwing destructor_, but this is tricky because of possible leaking.

#grid(
  columns: (1fr, 1.8fr),
  [
    ```cpp
    // C++ Client API (Header Only)
    struct ErrorRAII {
      ErrorRAII(error_t error)
        : opaque{error} {}
      ~ErrorRAII() {
        if (opaque) {
          error_dispose(opaque);
        }
      }
      error_t opaque;
    };
    ```
  ],
  [
    ```cpp
    // Header continued
    struct ThrowOnError{
      ThrowOnError() = default;
      ~ThrowOnError() noexcept(false) {
        if (error.opaque) { throw std::runtime_error{error_message(error.opaque)};}
      }
      operator error_t*() { return &error.opaque; }
    private:
      ErrorRAII error{nullptr};
    };
    ```
  ],
)

```cpp
struct Wizard {
  Wizard(std::string const & who = "Rincewind")
    : wiz {create_wizard(who.c_str(), ThrowOnError{})} {}
    // C linkage trampoline
};
```

To complete `WizardClient.cpp`, call the C functions from `WizardClient.hpp` from global namespace #hinweis[(i.e. `::do_magic()`)].
Delete the copy constructor & assignment to prevent a double free.

```cpp
struct Wizard {
  // ...
  auto doMagic(std::string, const &wish) -> std::string {
    return ::do_magic(wiz, wish.c_str(), ThrowOnError{});
  }
private:
  Wizard(Wizard const &) = delete;
  Wizard & operator =(Wizard const &) = delete;
  wizard wiz;
}
```

== Java Native Access (JNA)
JNA provides a _simple interface to C libraries_. Consists of a single JAR file and is cross-platform.
For C++/Java Type mappings see slides page 31.

=== Loading Libraries
```java
public interface CplaLib extends Library {
  CplaLib INSTANCE = (CplaLib) Native.load("cpla", CplaLib.class);
  void printInt(int number); // matches the function in the next chapter
}
```
Calling the loaded library handle _`INSTANCE`_ is only by convention.
The _loader_ searches for a suitable library, first in the path specified by `jna.library.path`,
otherwise in the system default library search path. Fallback is the class path.

=== Interfacing with Functions
```cpp
extern "C" { void printInt(int number); }
```
Function names and parameter types _must match_. However, the types are _not_ validated. Parameter names don't matter.

=== Interfacing with Plain `structs`
#hinweis[(see example on slides starting at page 34)]\
Plain non-opaque `struct` types must _inherit from `Structure`_.
You must override _`getFieldOrder()`_ and you can use the tag-interface _`Structure.ByValue`_.
You can access pointers to such types using _`getPointer()`_.

Opaque `struct` types should _inherit from `Pointer`_ and provide a constructor using the `create...()` function.
_Managing lifetime_ is _not trivial_. Using `dispose...()` API functions in finalizers is not recommended.
Either provide a dispose method on your Java type or implement `AutoClosable` and use your objects with `try-with-resources`.

=== Working with Raw Byte Arrays
#hinweis[(see example on slides starting at page 42)]\
Use _`IntByReference`_ to retrieve the size of the buffer. Requires that the API supports it.
_`getByteArray()`_ copies the data from the buffer.
Make sure to free the buffer either using an API `free...()` functions or `Native.free()` #hinweis[(tends to crash on windows)].


= Build Systems
#v(-0.5em)
== Build Automation
Good for _reproducibility_, _productivity_, _maintainability_ and _shareability_.
There are many IDEs which help build our projects. But sometimes, you don't want to rely on an IDE
#hinweis[(like on a build server, when sharing or reproducing with others)]

Do _not write your own scripts_ for this process, because then every source file gets built _every time_,
the commands tend to be _platform specific_, build order must be managed _manually_ and scripts tend to become
_messy_ over time.

== Build Tools
There are plenty of _build-tools:_ GNU make, Scons, Ninja, CMake, autotools, ... \
*Features of Build Tools:*
Incremental builds, parallel builds, automatic dependency resolution, package management, automatic test execution,
platform independence, additional processing of build products.\
*Different Classes of Build Automation Software:*
- _Make-style Build Tools:_ Run build scripts, produce your final products, often verbose,
  use a language agnostic configuration language
- _Build Script Generators:_ Generate configurations for Make-style Build Systems or Build Scripts,
  configuration is independent of actual build tool, often have advanced features like download dependencies.

=== GNU make
Well-known tool to build all kinds of projects. _Many IDEs_ "understand" make projects.
The workflow description is in _Makefile via "Target" rules_. Each target may have one or more _prerequisites_
and execute one or more _commands_ to generate one or more _results_. Targets are then executed "top-down".
A target is only executed if required.

```make
target: prereq_target
prereq_target: prereq_file other_target
  command_to_generate_output
other_target:
```

- _Pros:_ Very generic, powerful pattern matching mechanism, builds only what is needed, when its needed
- _Cons:_ Often platform-specific commands, need to specify how to do thins

== Build Script Generators
_Define what we want to achieve, not how to do it_. Work on a higher level, let the tool create the actual build configurations.
Platform independent build specification, tool independent.

=== CMake
Has support for many languages and is platform independent.

#grid(
  [
    ```cpp
    // main.cpp
    #include <iostream>
    int main() { std::cout << "Hello There!\n";}
    ```
  ],
  [
    ```cmake
    # CMakeLists.txt
    project("my_app" LANGUAGES CXX)
    add_executable("my_app" "main.cpp")
    ```
  ],
)

#definition[
  ```sh
  $ mkdir build # create separate build directory for the build outputs
  $ cd build
  $ cmake ..
  $ cmake --build . # don't use "make" to build ("cmake && make" or just "make").
  # Cmake uses the correct configured build tool, whereas make always assumes MakeFile
  ```
]

- _`cmake_minimum_required(...)`_ sets the minimum required CMake version. This implicitly defines the available feature set.
- _`project(...)`_ command defines the name of the project and which language we use
- _`add_executable(...)`_ defines binaries
- _`target_compile_features(...)`_ defines which language features are used by the target
  i.e. the C++ Standard or specific features. Prefer requiring standards rather than specific features!
- _`target_include_directories`_ is used to define the include search path of the target.
  Default is non-system include path, specify `SYSTEM` to define path as being a system include path
  #hinweis[(includes using `<...>`)]. Can be `PUBLIC` or `PRIVATE`
- _`set_target_properties(...)`_ defines additional target properties
- _`add_library(...)`:_ Defaults to static libraries, can be overridden at configuration time.
  All features, include paths and dependencies should be `PUBLIC`.
- _`target_link_libraries`_ is used to define libraries required by a target. Can be `PUBLIC` or `PRIVATE`,
  applies `PUBLIC` features/dependencies/includes of the library

*Variables* can be defined using `set(VAR_NAME VALUE)`. They are referenced using `${VAR_NAME}$`.
There are global variables like `PROJECT_NAME`, `PROJECT_SOURCE_DIR` or `PROJECT_BINARY_DIR`.
Can be used in place of concrete values: ```cmake add_executable(${PROJECT_NAME} "source1.cpp" "source2.cpp" ...)```.

=== Testing with CMake
CMake includes CTest. Enable it with `enable_testing()`. Create a "Test Runner" executable.

```cmake
enable_testing()
add_executable("test_runner" "Test.cpp")
```

```sh
$ cmake ..  # configure build environment
$ cmake --build . # build the project
$ ctest --output-on-failure # run ctest
```

== Project Layout
*Best Practices:* Separate headers from implementation files, group files by submodule / functionality. Be consistent!

#grid(
  [
    *Project Layout (General)*\
    #image("img/cpla_05.png")
  ],
  [
    *Project Layout (Libraries)*\
    #image("img/cpla_06.png")
  ],
)

- _`include`_: Contains headers. Add subfolders for separate subsystems if needed
- _`src`_: Contains implementations. Subfolder layout should match `include` folder
- _`lib`/`third_party`:_ Contains external resources like libraries
- _`test`_: Contains tests. Add above folders as necessary
- Build config files should be in the project root
- When creating a library, introduce another layer of nesting to avoid filename clashes in clients


= Move Semantics Output
```cpp
struct Example {
  Example(int a) { std::cout << "Ctr\n"; }
  Example(Example const&) { std::cout << "Copy Ctr\n"; }
  Example(Example&&) { std::cout << "Move Ctr\n"; }
  ~Example() { std::cout << "Dtor\n"; }
};
```

1. Creating new object with `=` still calls Constructor.
```cpp
Example a = 5; // "Ctr"
Example b = std::move(a); // "Move Ctr"
Example c = Example(std::move(f)); // "Move Ctr"
Example const d = c; // "Copy Ctr"
Example e = std::move(d); // "Copy Ctr" (Moving const not possible, fallback)
// "Dtor" 5 times
```

2. Constructor elides creation of temporaries (Optimization)
```cpp
auto defaultExample() -> Example { return Example{5}; }
Example f{Example{5}}; // "Ctr"
Example g{defaultExample()}; // "Ctr"
// "Dtor" 2 times
```

3. Temporary lvalue in methods
```cpp
auto moveExample(Example e) { auto h = std::forward<Example>(e); } // "Move Ctr" "Dtor"
moveExample(g); // "Copy Ctr" "Dtor"
```
