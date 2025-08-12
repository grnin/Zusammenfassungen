#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Sequences and Iterators
#hinweis[#cppr("container/array")[CPPReference: std::array ]] #h(1fr) ```cpp #include <array>``` \
`std::array<T, N>` is a _fixed-size_ container. It is not possible to shrink or grow an array after its creation.
- `T` is a _template_ type parameter to specify the type of elements the array should contain.
- `N` is a _positive integer_ to specify the number of elements in the array.

Both can be _deduced_ from the initializer, so you can write ```cpp std::array name {1, 2, 3, 4, 5}```.
This only works if you write out the elements inside the `{}`.

```cpp
#include <array>
std::array<int, 5> name{1, 2, 3, 4, 5};
```

The _size_ of the array must be _known_ at compile-time and _cannot be changed_.
Otherwise, it contains `N` default-constructed elements: ```cpp std::array<int, 5> emptyArray{}``` contains 5 zeroes.
The size can be queried using _`.size()`_.

Elements of the array can be accessed via the _subscript operator `[]`_ or the _`.at()` member function_.
`.at()` throws an exception on invalid index access, while `[]` has undefined behavior.

Plain C-style arrays should be avoided, as they are only passed as pointers, thus the array size gets lost.
This can lead to memory errors!\
#strike[```cpp int arr[]{1, 2, 3}```]

=== Array Iterators <array-iterators>
#hinweis[#cppr("container/array#Iterators")[CPPReference: std::array Iterators]]

#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    - _`begin()`:_ returns an Iterator to the first element of the array
    - _`end()`:_ returns an Iterator to _after_ the last element of the array
    - _`rbegin()`:_ returns a reverse Iterator to the _last_ element of the array
    - _`rend()`:_ returns a reverse Iterator to _before_ the first element

    Whenever a iterator is incremented, it will point to the next element in line.
    To access the element an iterator points to, the iterator needs to be _dereferenced_ with the `*` operator
    #hinweis[(indirection operator)]:
  ],
  image("img/cpl_01.png"),
)

```cpp
std::array arr{42, 1337, 666};
auto *iterator = arr.begin() + 1; // "auto *" because iterator is a pointer-like type
int secondElement = *iterator;    // secondElement = 1337
```

_Reverse Iterators_ will iterate the array from the back, meaning the last element will be accessed first.
The next element will be the second last element and so on.\
All of the Iterators also have a _`const` version_ #hinweis[(`cbegin()`, `cend()`, `crbegin()`, `crend()`)]
which return a `const` Iterator, meaning the element the iterator points to can't be modified.

== `std::vector`
#hinweis[#cppr("container/vector")[CPPReference: std::vector ]] #h(1fr) ```cpp #include <vector>```\
`std::vector<T>` is a _Container_. There is _no need_ to allocate the elements inside, as it already contains them
#hinweis[(unlike Java, where a `ArrayList` contains references to its elements)].
`T` is a _template_ type parameter to specify the type of the elements to store.

`std::vector` can be initialized with a list of elements, but the list _can be empty:_ ```cpp std::vector<double> vd{}```.\
When an _initializer_ is given, the element type can be deduced.

```cpp
#include <vector>
std::vector<int> name{1, 2, 3, 4, 5}
```

During _initialization_, the initial size of the vector can be specified inside parenthesis:\
```cpp std::vector<int>(6) /* size = 6 */ != std::vector<int>{6} /* has one 6 inside */```

#grid(
  columns: (2fr, 1.4fr),
  gutter: 1em,
  [
    === Vector Iterators
    #hinweis[#cppr("container/vector#Iterators")[CPPReference: std::vector Iterators ]] \
    In addition to the Iterators of `std::array` #hinweis[(see @array-iterators)],
    `std::vector` has two additional functions to work with.
    - _`.insert(<iterator>, <value>)`:_ Insert a value at the position the iterator points to.
      All succeeding elements are moved one position up #hinweis[(inefficient!)].
    - _`.push_back(<value>)`:_ Inserts a value at the end of the vector\ #hinweis[(more efficient)]
  ],
  image("img/cpl_02.png"),
)

```cpp
std::vector vec{1, 2, 4};
vec.insert(vec.begin() + 2, 3); // vec = {1, 2, 3, 4}
vec.push_back(5);               // vec = {1, 2, 3, 4, 5}
```

=== Array vs. Vector
Arrays are _stack allocated_, Vectors are _heap allocated_. Arrays should be used when the number of elements doesn't change,
otherwise Vectors should be used.

== Iteration
#v(-0.5em)
=== Index-based Iteration
Vectors can be accessed via _`for`-Loop_. The type of the index variable is _`size_t`_
#hinweis[(Works on all OS and platforms, `int` may cause problems)]. Using `.at()` prevents undefined behavior on
invalid index access. _Caution: Only use if the actual index value is required!_ Otherwise, prefer access via iterators.

```cpp
for (size_t i = 0; i < v.size(); ++i) {
  std::cout << v.at(i) << '\n';
}
```

=== Element Iteration (Range-Based for, foreach)
_No index error_ possible, works with _all containers_, even value lists `{1,2,3}`

#table(
  columns: (1fr, 1fr, 1fr),
  table.header(
    [],
    [
      `const`\
      Element cannot be changed
    ],
    [
      `non-const`\
      Element can be changed
    ],
  ),

  [
    _`reference`_ #hinweis[(marked with `&` operator)]\
    _Element in Vector is accessed_ \
    #hinweis[for big elements and changes to the original]
  ],
  [
    ```cpp
    for (auto const & cref : v) {
      std::cout << cref << '\n';
    }
    ```
  ],
  [
    ```cpp
    for (auto & ref : v) {
      ref *= 2;
    }
    ```
    #hinweis[Modifies elements in the original container]
  ],

  [
    _`copy`_ \
    _Loop has own copy of the element_
  ],
  [
    ```cpp
    for (auto const ccopy : v) {
      std::cout << ccopy << '\n';
    }
    ```
    #hinweis[constant copy is rarely used]
  ],
  [
    ```cpp
    for (auto copy : v) {
      copy *= 2;
      std::cout << copy << '\n';
    }
    ```
    #hinweis[Modifies elements in the copied container]
  ],
)

=== Iteration with Iterators
A _range-based for-loop_ uses _iterators_ internally. Iterators can also be used in a regular for-loop, but this is only useful
if the iterator itself is required inside the loop. Otherwise ranged-for-loops or algorithms are preferred for
memory safety reasons.

Start with ```cpp std::begin(vec)``` and compare if the current iterator is not equal to ```cpp std::end(vec)```.
The current element can be accessed with `*iterator`; if the iterator and container are non-`const`,
elements can also be modified this way.\
To have read-only access to the container, use ```cpp std::cbegin(vec)``` and ```cpp std::cend(vec)```.

```cpp
for (auto it = std::cbegin(v); it != std::cend(v); ++it) {
  std::cout << *it << ", ";
}
```

For more Information on Iterators, see chapter @Iterators.

== Iterator Algorithms
Algorithms perform _frequently used operations on ranges and containers_, such as counting values, copying or
searching for elements. Each algorithm takes iterators as arguments -- the range(s) of elements to apply an
algorithm to is specified by them.

For a more in-depth look at algorithms, see chapter @algorithms.

Containers _cannot_ be used with algorithms _directly_. Iterators _connect_ containers and algorithms.

#table(
  columns: (1fr, 1fr, 1fr),
  table.header([Container], [Iterators], [Algorithms]),
  [
    ```cpp
    std::vector<T>
    std::string
    std::set<T>
    std::map<K,V>
    ...
    ```
  ],
  [
    ```cpp
    std::begin()
    std::end()
    std::rbegin()
    std::rend()
    ...
    ```
  ],
  [
    ```cpp
    std::count(b, e, val)
    std::ranges::count(r, val)
    std::find(b, e, val)
    std::accumulate(b, e, start)
    std::copy(b, e, b_target)
    ...
    ```
  ],
)


=== Using Iterators with Algorithms
#hinweis[#cppr("algorithm")[CPPReference: Algorithms library], #cppr("iterator")[CPPReference: Iterator library]]
#h(1fr) ```cpp #include <algorithm>```\
#hinweis[#cppr("iterator/begin")[CPPReference: std::begin, std::cbegin], #cppr("iterator/end")[CPPReference: std::end, std::cend]]

_Avoid programming your own loops!_ The corresponding algorithm is _more correct_, _more readable_ and has _better performance_.

To also support _containers_ and other data types that do not have a `.begin()`/`.end()` etc. member function
#hinweis[(such as plain-C-arrays)] the iterator library provides `std::begin()`/`std::end()` etc.
These are functionally the same as the member functions and can for the most part be used interchangeably.

=== Basic Examples of Algorithm use
#v(-0.5em)
===== Counting values
#hinweis[#cppr("algorithm/count")[CPPReference: std::count], #cppr("algorithm/ranges/count")[CPPReference: std::ranges::count]]\
Returns the number of occurrences of a value in range. Works with all ranges denoted by a pair of iterators.

```cpp
#include <algorithm>
#include <iterator>
auto count_blanks(std::string s) -> size_t {
  return std::count(s.cbegin(), s.cend(), ' '); // Counts all spaces in a string
}
```

===== Summing up values
#hinweis[#cppr("algorithm/accumulate")[CPPReference: std::accumulate]\ ]
Applies the `+` operator to elements, requires the initial value #hinweis[(here `0`)].

```cpp
#include <algorithm>
#include <iterator>
#include <numeric>
std::vector<int> v{5, 4, 3, 2, 1};
std::cout << std::accumulate(std::cbegin(v), std::cend(v), 0) << " = sum\n"; // Output: 15 = sum
```

===== Number of elements in range
#hinweis[#cppr("iterator/distance")[CPPReference: std::distance]\ ]
Containers provide a `size()` member function, useful if you only have iterators as `size()` may be unavailable
inside an algorithm. Both `size()` and `std::distance()` provide the same value.

```cpp
#include <algorithm>
#include <iterator>
void printDistanceAndLength(std:string s) {
  std::cout << "distance: " << std::distance(s.begin(), s.end()) << '\n';
  std::cout << "in a string of length: " << s.size() << '\n';
}
```

=== `std::for_each` Algorithm
#hinweis[#cppr("algorithm/for_each")[CPPReference: std::for_each]] \
The most basic algorithm. Like a `for` statement, executes an action _for each element in a range_.
The _last argument_ is a _function_ that takes one parameter of the element `type` #hinweis[(in the example below, one `int`)].
Most of the time, the function is a _lambda._

```cpp
#include <algorithm>
#include <iterator>
auto print(int x) -> void {
  std::cout << "print: " << x << '\n';
}
auto printAllReversed(std::vector<int> v) -> void {
  std::for_each(std::crbegin(v), std::crend(v), print); // for each element, print() is run
}
```

=== Lambda Functions Basics
Using `std::cout` outside `main` is discouraged. If we want to print to a given `std::ostream`, we need to use a
_lambda structure_. For more detailed information about Lambda Functions, see @lambda-functions.

#definition[
  ``` [<capture>](<parameters>) -> <return-type> { <statements> }```
]

#table(
  columns: (auto, 1fr),
  table.header([Term], [Definition]),
  [*Capture*],
  [
    Variables from outside the lambda to access inside of the lambda. Can either be copies or references
    #hinweis[(`[&x]`: by reference, `[x]`: by value, `[=]`: all local variables by value, `[&]`: all local values as references)]
  ],

  [*Parameters*],
  [
    New variables to be used inside the lambda. When used with algorithms, there is usually one parameter that contains
    the current element of the range/container.
  ],

  [*Return Type*],
  [
    Return type of the lambda function. Can be _omitted_ if `void` or consistent return statements in the body
    #hinweis[(Compiler can guess the return type)].
  ],
)

A _lambda expression_ creates a function object that can be passed to an algorithm.
_Capture names variables_ are taken from the surrounding scope.

```cpp
auto printAll(std::vector<int> v, std::ostream & out) -> void {
  std::for_each(std::cbegin(v), std::cend(v), [&out](auto x) /* -> return-type omitted */ {
    // Lambda captures "out", can be used inside lambda
    out << "print: " << x << '\n';
  });
}
```

=== `std::ranges` <std-ranges>
#hinweis[
  #cppr("ranges")[CPPReference: Ranges library],
  #cppr("algorithm/ranges")[CPPReference: Constrained Algorithms (list of all `ranges` algorithms)]
]
#h(1fr) ```cpp #include <algorithms>```

A lot of times, we use an algorithm to _iterate_ over a container from the _start to the end_. So the first two parameters
of an algorithm are _`begin()`_ and _`end()`_. To simplify this, most algorithms have a version in the `std::ranges` namespace,
where only the container is taken as an argument.

```cpp
#include <algorithm>
auto printAll(std::vector<int> v, std::ostream & out) -> void {
  // No v.begin() and v.end(), just "v" is enough :)
  std::ranges::for_each(v, [&out](auto x) {
    out << "print: " << x << '\n';
  });
}
```

==== Appending Elements to an `std::vector<T>`
#hinweis[
  #cppr("container/vector/push_back")[CPPReference: std::vector<>.push_back()],
  #cppr("container/vector/insert")[CPPReference: std::vector<>.insert()],
  #cppr("algorithm/copy")[CPPReference: std::copy],
  #cppr("algorithm/ranges/copy")[CPPReference: std::ranges::copy]
]
- _Append:_ ```cpp v.push_back(<value>)``` #hinweis[(Append at the back, relatively efficient)]
- _Insert anywhere:_ ```cpp v.insert()(<iterator-position>, <value>)``` #hinweis[(Has to move succeeding elements, inefficient)]

When using the _`std::copy`_ algorithm, the _target_ has to be an _iterator_ too.
#definition[
  ```cpp
  std::copy(<input-begin-iterator>, <input-end-iterator>, <output-begin-iterator>);
  std::ranges::copy(<input-range>, <output-begin-iterator>);
  ```
]

_Caution:_ Using `begin()` or `end()` as the output begin iterators are not allowed, because they can't insert values
in a container. Additionally `end()` is not allowed, since it is outside of the allocated memory.
Instead, we can use an _`std::back_inserter`_, which performs `push_back()` for us:

```cpp
std::vector<int> source{1, 2, 3}, target{};
// Use either ranges or non-ranges copy()
std::copy(source.cbegin(), source.cend(), std::back_inserter(target));
std::ranges::copy(source, std::back_inserter(target));
```

==== Filling an `std::vector<T>` with values
#hinweis[#cppr("algorithm/fill")[CPPReference: std::fill], #cppr("algorithm/ranges/fill")[CPPReference: std::ranges::fill]]\
Requires either a vector with _existing elements_ to be overwritten, or a newly created vector directly initialized
with the wanted size.

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    _Manual resize of vector_
    #v(-0.5em)
    ```cpp
    std::vector<int> v{};
    v.resize(10); // set size of vector to 10
    std::fill(std::begin(v), std::end(v), 2);
    std::ranges::fill(v, 2);
    ```
  ],
  [
    _Initialize vector with correct size_
    #v(-0.5em)
    ```cpp
    std::vector<int> v(10); // Caution: () not {}!
    // Use either ranges or non-ranges fill()
    std::fill(std::begin(v), std::end(v), 2);
    std::ranges::fill(v, 2);
    ```
  ],
)

But `std::vector` provides a constructor to do this operation in one line: ```cpp std::vector v(10, 2);```

==== Filling an `std::vector<T>` with different values
#hinweis[
  #cppr("algorithm/generate")[CPPReference: std::generate],
  #cppr("algorithm/ranges/generate")[CPPReference: std::ranges::generate],
  #cppr("algorithm/generate_n")[CPPReference: std::generate_n],
  #cppr("algorithm/ranges/generate_n")[CPPReference: std::ranges::generate_n]
]\
The algorithms _`std::generate()`_ and _`std::generate_n()`_ fill a range with computed values:

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    _`back_inserter` on empty vector_
    #v(-0.5em)
    ```cpp
    std::vector<double> powerOfTwos{};
    double x{1.0};
    std::generate_n(
      std::back_inserter(powerOfTwos),
      5, // Number of elements
      [&x] { return x *= 2.0; }
    );
    ```
  ],
  [
    _Fill vector with specified size_
    #v(-0.5em)
    ```cpp
    std::vector<double> powerOfTwos(5);
    double x{1.0};
    std::ranges::generate(
      powerOfTwos,
      [&x] { return x *= 2.0; }
    );
    // powerOfTwos = {2, 4, 8, 16, 32}
    ```
  ],
)

#hinweis[#cppr("algorithm/iota")[CPPReference: std::iota]]\
_`std::iota()`_ #hinweis[(named after the Greek letter $Iota$)] fills a range with _subsequent values_ #hinweis[(1, 2, 3...)].
The last parameter is the starting value:

```cpp
#include <numeric>
#include <iterator>
#include <algorithm>
std::vector<int> v(100);
std::iota(std::begin(v), std::end(v), 1); // fills v with numbers 1-100
```

==== Finding and Counting Elements
#hinweis[
  #cppr("algorithm/find")[CPPReference: std::find, std::find_if],
  #cppr("algorithm/ranges/find")[CPPReference: std::ranges::find, std::ranges::find_if]
]\
_`std::(ranges::)find()`_ and _`std::(ranges::)find_if()`_ return an iterator to the first element that matches
the value or condition. If no match exists, the end of the range is returned #hinweis[(`.end()`)].

```cpp
#include <iterator>
#include <algorithm>
auto zero_it = std::ranges::find(v, 0); // find first 0
if (zero_it == std::end(v)) {
  std::cout << "no zero found \n";
}
```

#hinweis[
  #cppr("algorithm/count")[CPPReference: std::count, std::count_if],
  #cppr("algorithm/ranges/count")[CPPReference: std::ranges::count, std::ranges::count_if]
]\
_`std::(ranges::)count()`_ and _`std::(ranges::)count_if()`_ return the number of matching elements in a range.
`count()` takes a value, `count_if()` a predicate #hinweis[(function or lambda)] to compare to.

```cpp
#include <iterator>
#include <algorithm>
std::cout << std::ranges::count(v, 42) << " times 42\n";
auto isEven = [](int x) { return !(x % 2); };
std::cout << std::ranges::count_if(v, isEven) << " even numbers\n";
```

#pagebreak()

== Iterators for I/O <io-iterators>
Streams _cannot_ be used with algorithms directly. Instead, _`std::ostream_iterator`_ and _`std::istream_iterator`_
are used to take _multiple values_ from the `istream` or put multiple values on the `ostream` respectively.

=== `std::ostream_iterator`
#hinweis[#cppr("iterator/ostream_iterator")[CPPReference: std::ostream_iterator]]\
A `std::ostream_iterator<T>` can be used to _copy_ the values of a container to a `std::ostream`.
It can also take a optional _delimiter character_ to separate the output values.
In the example below, the vector values are printed with a comma and a space between them.

```cpp std::ranges::copy(v, std::ostream_iterator<int>{std::cout, ", "});```

A `ostream_iterator<T>` _outputs_ values of type `T` to the `std::ostream`. There is no `end()` marker needed for the output,
it ends when the input range ends.

=== `std::istream_iterator`
#hinweis[#cppr("iterator/istream_iterator")[CPPReference: std::istream_iterator]]\
`std::istream_iterator<T>` _reads_ values of type `T` from the given `std::istream`.
To mark the _end of the input_ for an algorithm that requires it, a empty ```cpp std::istream_iterator<T>{}``` is needed.
The `istream_iterator` ends when the stream is no longer `good()`
#hinweis[(i.e. no more characters in input or characters that can't be assigned to `T`)].

```cpp
std::istream_iterator<std::string> in{std::cin};
std::istream_iterator<std::string> eof{}; // dummy stream that acts as in.end()
std::ostream_iterator<std::string> out{std::cout, " "};
std::copy(in, eof, out); // writes chars from input directly to output, separated by spaces
```

#hinweis[#cppr("ranges/basic_istream_view")[CPPReference: std::ranges::istream_view]]\
_`std::ranges::istream_view<T>`_ combines `in` and `eof`, the dummy `istream_iterator` is no longer required.

```cpp
std::ranges::istream_view<std::string> in{std::cin};
std::ostream_iterator<std::string> out{std::cout, " "};
std::ranges::copy(in, out);
```

=== Type Alias
#hinweis[#cppr("language/type_alias")[CPPReference: Type alias]\ ]
Type names can be given alias names. Useful if _long type names_ occur _more than once_.

#definition[`using <alias-name> = <type>`;]

```cpp
using input = std::istream_iterator<std::string>;
input eof{};
input in{std::cin};
std::ostream_iterator<std::string> out{std::cout, " "};
std::copy(in, eof, out);
```

==== Unformatted Input: `std::istreambuf_iterator`
#hinweis[#cppr("iterator/istreambuf_iterator")[CPPReference: std::istreambuf_iterator]\ ]
`std::istream_iterator` skips whitespaces. For an _exact copy_, we need _`std::istreambuf_iterator<char>`_.
Works only with _`char`-like_ types, because it uses `std::istream::get()` internally.

```cpp
using input = std::istreambuf_iterator<char>;
input eof{};
input in{std::cin};
std::ostream_iterator<char> out{std::cout, " "};
std::copy(in, eof, out);
```

#pagebreak()

==== Filling an `std::vector<T>` from Standard Input
#hinweis[#cppr("iterator/back_inserter")[CPPReference: std::back_inserter]\ ]
#grid(
  [
    _With `back_inserter`_
    #v(-0.5em)
    ```cpp
    using input = std::ranges::istream_view<int>;
    std::vector<int> v{};
    std::ranges::copy(input{std::cin}, std::back_inserter(v));
    ```
  ],
  [
    _Construct vector from iterators_
    #v(-0.5em)
    ```cpp using input = std::istream_iterator<int>;
    input eof{};
    std::vector<int> const v{input{std::cin}, eof};
    ```
  ],
)
