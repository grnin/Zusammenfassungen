#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= STL Algorithms <algorithms>
#hinweis[#cppr("algorithm")[CPPReference: Algorithm library]]
#v(-0.5em)
It is almost always better to use an algorithm instead of a loop.
- _Correctness:_ It is much easier to use an algorithm correctly than implementing loops correctly.
- _Readability:_ Applying the correct algorithm expresses your intention much better than a loop.
- _Performance:_ Algorithms might perform better than handwritten loops.

== Basics
Algorithms work with _ranges_ specified by iterators. They usually take 1 or 2 ranges as the input (`start`, `end`)
and 1 iterator as the output (`start` only, `end` is not required).
However, there are some things that need to be kept in mind when working with iterators, see chapter @algorithm-pitfalls.

=== Iterator for Ranges
#grid(
  [
    - _`First`:_ Iterator pointing to the first element
    - _`Last`:_ Iterator pointing beyond the last element
    - _If `First == Last`:_ the range is empty
  ],
  [
    ```cpp
    std::vector<int> values{54, 23, 17, 95, 85};
    std::xxx(begin(values), end(values), ...);
    ```
  ],
)

=== Iterators as Output of Ranges
#grid(
  [
    Streams need a wrapper to be used with algorithms
    - `std::ostream -> std::ostream_iterator<T>`
    - `std::istream -> std::istream_iterator<T>`
    - Default-constructed `std::istream_iterator<T>` marks `EOF`
  ],
  [
    ```cpp
    auto redirect(std::istream& in,
    std::ostream& out) -> void {
      using in_iter = std::istream_iterator<char>;
      using out_iter = std::ostream_iterator<char>;
      std::copy(in_iter{in},in_iter{},out_iter{out});}
    ```
  ],
)

=== Reading Algorithm Signatures
Each algorithm has a name, parameters and a return type. The description specifies the requirements.
Algorithms work with the iterator categories, see chapter @Iterator-Categories

```cpp
/*             Template-Header            */
template<class InputIt, class UnaryFunction>
UnaryFunction    for_each    (InputIt first, InputIt last, UnaryFunction f);
/* Returntype */ /* Name */  /*                Parameters                */
```

== Functor <functor>
#hinweis[#cppr("utility/functional")[CPPReference: Function objects]]
#v(-0.5em)
#grid(
  [
    A functor is a type that _provides a call operator:_ `()`. An object / instance of that type can be called like a function.
    It can provide multiple overloads of the call operator #hinweis[(Usually not necessary)].

    They can hold a _state_ between calls, like closures in functional languages. _Lambdas_ are realized with functors internally.

    ```cpp
    // Usage with for_each algorithm
    auto average(std::vector<int> values) -> int {
      auto acc = Accumulator{};
      // for_each() returns acc again
      return std::for_each(begin(values),
       end(values), acc).average();
    }
    ```
  ],
  [
    ```cpp
    struct Accumulator {
      int count{0};
      int accumulatedValue{0};
      // The functor
      auto operator()(int value) -> void {
        count++; accumulatedValue += value;
      }
      auto average() const -> int {
        return accumulatedValue / count;
      }
    };
    // Usage with for-loop
    auto average(std::vector<int> values) -> int {
      Accumulator acc{};
      // Functor call here
      for(auto v : values) { acc(v); }
      return acc.average();
    }
    ```
  ],
)

=== Predicate
A function or a lambda returning `bool`. For checking a criterion / condition.
#table(
  columns: (1fr, 1fr),
  table.header([Unary Predicate], [Binary Predicate]),
  [
    Has _one_ Parameter.\
    ```cpp
    auto is_odd = [](auto i) -> bool
      { return i % 2 };
    ```
  ],
  [
    Has _two_ Parameters.\
    ```cpp
    auto divides = [](auto i, auto j) -> bool
      { return !(i % j); };
    ```
  ],
)

=== Standard Functor Template Classes
#hinweis[#cppr("header/functional")[CPPReference: Standard Library Header `<functional>`]]
#h(1fr) ```cpp #include <functional>``` #v(-0.5em)

Lambdas make applying `transform` etc. quite easy:\
```cpp transform(v.begin(), v.end(), v.begin(), [](auto x){ return -x; }); // Make all numbers negative```

However, the STL provides standard Functor Classes, which make it even easier:\
```cpp transform(v.begin(), v.end(), v.begin(), std::negate<>{});```
#v(1em)
#grid(
  columns: (1fr,) * 3,
  [
    ==== Binary arithmetic and logical
    - ```cpp plus<>        // (+)```
    - ```cpp minus<>       // (-)```
    - ```cpp divides<>     // (/)```
    - ```cpp multiplies<>  // (*)```
    - ```cpp modulus<>     // (%)```
    - ```cpp logical_and<> // (&&)```
    - ```cpp logical_or<>  // (||)```
  ],
  [
    ==== Unary
    - ```cpp negate<>      // (-)```
    - ```cpp logical_not<> // (!)```

  ],
  [
    ==== Binary Comparison
    - ```cpp less<>          // (<)```
    - ```cpp less_equal<>    // (<=)```
    - ```cpp equal_to<>      // (==)```
    - ```cpp greater_equal<> // (>=)```
    - ```cpp greater<>       // (>)```
    - ```cpp not_equal_to<>  // (!=)```
  ],
)

#pagebreak()

=== Example: `set<string>` for dictionary
```cpp
#include <set>
#include <algorithm>
#include <cctype>
#include <iterator>
#include <iostream>
struct caseless {
  using string = std::string;
  // Binary predicate with strings as ranges and lambda as binary predicate on char
  auto operator()(string const & l, string const & r) const -> bool {
    // run a lexicographical compare on the two strings
    return std::lexicographical_compare(l.begin(), l.end(), r.begin(), r.end(),
      // make each char lowercase before comparing them
      [](char l, char r){ return std::tolower(l) < std::tolower(r); });
  }
};
auto main() -> int {
  using std::string;
  // pass predicate functor as template argument, the strings are now sorted
  using caseless_set = std::multiset<string, caseless>;
  using in = std::istream_iterator<string>;
  auto const word_list = caseless_set{in{std::cin}, in{}};
  auto out = std::ostream_iterator<string>{std::cout, "\n"};
  copy(word_list.begin(), word_list.end(), out);
}
```

== Common Algorithms
*Syntax:*\
- _`first1`:_ Iterator to the start of the first range #hinweis[(usually `.begin`/`std::begin()`)]
- _`last1`:_ Iterator to the end of the first range #hinweis[(usually `.end()`/`std::end()`)]
- _`first2`:_ Iterator to the start of the second range #hinweis[(usually `.begin`/`std::begin()`)]
- _`out_first`:_ Iterator to the start of the output range #hinweis[(usually `.begin`/`std::begin()`)]
- _`c`:_ The container itself
- _`unary_op`/`binary_op`:_ Unary/binary function, lambda or functor to apply to the range
- _`comp`:_ Custom comparison function. Usually optional.
- _`init`:_ A initial value

Almost all algorithms have a `std::ranges` variant, where `first1` and `last1` can be replaced with `c`.
This does not work on `std::istream`, as it needs a dummy stream that acts as the end, see chapters @std-ranges and @io-iterators.

=== `transform`
#hinweis[
  #cppr("algorithm/transform")[CPPReference: `std::transform`],
  #cppr("algorithm/ranges/transform")[CPPReference: `std::ranges::transform`]
]
#h(1fr) ```cpp  #include <algorithm>```\
```cpp std::transform(first1, last1, [first2], out_first, [unary_op|binary_op]);```

#grid(
  columns: (1fr, 2fr),
  [
    Mapping one range #hinweis[(or two ranges of equal or greater size)] to new values and store the result in a new range.
    Uses a Lambda, Function or Functor for map operation.

    Input and output types can be different, as long as the operation has the same type.
  ],
  [
    ```cpp
    auto counts = std::vector{3, 0, 1, 4, 0, 2};
    auto letters = std::vector{'g', 'a', 'u', 'y', 'f', 'o'};
    auto combined = std::vector<std::string>{};
    auto times = [](auto i, auto c) { return std::string(i, c); };
    // Put chars from 'letters' 'count'-times into 'combined'
    std::transform(begin(counts), end(counts), begin(letters),
      std::back_inserter(combined), times);
    // combined = {"ggg", "", "u", "yyyy", "", "oo"}
    ```
  ],
)

#pagebreak()

=== `merge`
#hinweis[
  #cppr("algorithm/merge")[CPPReference: `std::merge`],
  #cppr("algorithm/ranges/merge")[CPPReference: `std::ranges::merge`]
]
#h(1fr) ```cpp  #include <algorithm>```\
```cpp std::merge(first1, last1, first2, last2, out_first, [comp]);```
#grid(
  columns: (1fr, 2fr),
  [
    Merge two _sorted_ ranges into a output range. Undefined behavior if ranges are unsorted.
  ],
  [
    ```cpp
    std::vector r1{9, 12, 17}; std::vector r2{2, 15, 32};
    // initialize empty vector with correct size
    std::vector d(r1.size() + r2.size(), 0);
    std::merge(begin(r1), end(r1), begin(r2), end(r2), begin(d));
    // d = {2, 9, 12, 15, 17, 32}
    ```
  ],
)

=== `accumulate`
#hinweis[#cppr("algorithm/accumulate")[CPPReference: `std::accumulate`]]
#h(1fr) ```cpp #include <numeric> ```\
```cpp std::accumulate(first1, last1, init, [binary_op]);```

#grid(
  columns: (1fr, 2fr),
  [
    Some numeric algorithms, like `accumulate`, can be used in non-numeric context.
    This function sums elements that are addable\ #hinweis[(+ Operator)], starting at an initial value.
  ],
  [
    ```cpp
    std::vector<std::string> months{"Jan", "Feb", ..., "Dec"};
    auto accumulatedString = std::accumulate(
      next(begin(months)), // Second element
      end(months), // Last element
      months.at(0), // First element, usually the neutral element
      [](std::string const & acc, std::string const & element) {
        return acc + ", " + element;
    }); // accumulatedString = "Jan, Feb, ..., Dec"
    ```
  ],
)

== `std::remove`, Erase-Remove-Idiom
#hinweis[
  #cppr("algorithm/remove")[CPPReference: `std::remove`, `std::remove_if`],
  #cppr("algorithm/erase2")[CPPReference: `std::erase`, `std::erase_if`]
]
#h(1fr) ```cpp  #include <algorithm>```\
```cpp std::remove(first, last, value);```
#grid(
  [
    _`std::remove`_ does _not_ actually _remove_ the elements, it _moves_ the "not-removed" elements to the _front_ and
    _returns an iterator_ to the end of the "new" range. The "removed" elements can still be dereferenced,
    but their behavior is undefined. To get _rid_ of the "removed" elements, usually the _`erase` member function_ is called.
  ],
  [
    ```cpp
    auto values = std::vector{54, 13, 17, 95, 2};
    auto is_prime = [](unsigned u) { ... };
    auto removed = std::remove_if(
      begin(values), end(values), is_prime);
    // values = {54, 95, ???, ???, ???}
    values.erase(removed, values.end());
    // values = {54, 95}
    ```
  ],
)

== \_if-Versions of Algorithms
#grid(
  [
    Some algorithms have a variation with the `_if` suffix.
    They take a predicate #hinweis[(instead of a value)] to provide a condition.
  ],
  [
    ```cpp
    auto numbers = std::set{1,2,3,4,5,6,7,8,9};
    auto isPrime = [](auto u) { /* ... */ }
    auto noOfPrimes = std::count_if(
      begin(numbers), end(numbers), isPrime);
    // noOfPrimes = 4
    ```
  ],
)

==== Algorithms with the `_if` Suffix
```
count_if  find_if       replace_if         remove_if
copy_if   find_if_not   replace_copy_if    remove_copy_if
```

== \_n-Versions of Algorithms
#grid(
  [
    The `_n` suffix is related to a number provided instead of the "last" iterator.
  ],
  [
    ```cpp
    auto numbers = std::set{1,2,3,4,5,6,7,8,9};
    auto top5 = std::vector<int>(5);
    std::copy_n(rbegin(numbers), 5, begin(top5));
    // top5 = {9, 8, 7, 6, 5}
    ```
  ],
)

==== Algorithms with the `_n` suffix
```
search_n     fill_n          for_each_n        copy_n       generate_n
```

#pagebreak()

== Heap Algorithms
#hinweis[#cppr("algorithm#Heap_operations")[CPPReference: Algorithms -- Heap operations]]
#v(-0.5em)
#grid(
  [
    A heap can be implemented on any _sequenced container_ with _random access iterators_ #hinweis[(i.e. `vector`)].
    Containers with the heap property in C++ are essentially _balanced binary trees_.\
    _Guarantees:_ Top element is the largest, adding and removing elements have performance guarantees.

    Used for _implementing priority queues_.
  ],
  [
    ```cpp
    std::vector<int> v{3,1,4,1,5,9,2,6};
    make_heap(v.begin(), v.end());
    pop_heap(v.begin(), v.end());
    v.pop_back();
    v.push_back(8);
    push_heap(v.begin(), v.end());
    sort_heap(v.begin(), v.end());
    // Corresponding images in the slides:
    // Week 8, page 32 onwards
    ```
  ],
)
==== Heap operations
`make_heap` #hinweis[$O(3 dot N)$], `pop_heap` #hinweis[$O(2 dot log(N))$], `push_heap` #hinweis[$O(log(N))$],
`sort_heap` #hinweis[$O(N dot log(N))$].

_The most important operation is `make_heap`: _It can be applied to any range with a random access iterator to turn it into a
heap. It rearranges the elements to satisfy the max-heap property: _Each parents node is greater or equal to the value of its
children_. The first element in the container is the root node, with the second and third being its children and the next four
elements being their child nodes.

The _heap creation process_ starts at the bottom of the tree at the last non-leaf node to the root.
Its value is then compared to its children and if one of the children is greater, the nodes will swap places.
This continues until the root is reached and the heap is sorted.
#grid(
  columns: (1fr,) * 4 + (auto, 1fr),
  gutter: 2em,
  align: horizon,
  [
    ```
    1)      3
          /   \
         1     4
        / \   / \
       1   5 9   2
      /
     6 <- 1 > 6?
    ```
  ],
  [
    ```
    2)     3
         /   \
        1     4
       / \   / \
      6   5 9   2
     / | swapped
    1 <-
    ```
  ],
  [
    ```
    3)     3
         /   \
        1     4
       / \   / \
      6   5 9   2
     /      ^   ^
    1    9>4||9>2?
    ```
  ],
  [
    ```
    4)     3
         /   \
        1     9
       / \   / \
      6   5 4   2
     /      ^
    1     swapped
    ```
  ],
  [
    ...
  ],
  [
    ```
    12)    9
         /   \
        6     4
       / \   / \
      1   5 3   2
     /
    1    done :)
    ```
  ],
)

== Pitfalls <algorithm-pitfalls>
#v(-0.5em)
=== Mismatching Iterator Pairs
It is _mandatory_ that the iterators specifying a range _need to belong to the same range_.
Otherwise, access of the value might result in undefined behavior.

```cpp
std::vector<int> first{1, 2, 3};
std::vector<int> second{4, 5, 6};
auto f = [](int i) { ... };
std::for_each(std::begin(first), std::end(second), f); // iterators from different objects, UB!
```

=== Not reserving enough space
If you use an _iterator_ for _specifying the output_ of an algorithm, you need to make sure that _enough space is allocated_.
Otherwise the end of allocated memory will be overwritten, resulting in _undefined behavior!_

It is possible to insert elements into a container _without_ pre-allocating the required memory with the inserter
functions `back_inserter`, `front_inserter` and `inserter` that call the respective member functions of the container.

```cpp
std::set<unsigned> numbers {1,2,3,4,5,6,7,8,9};
std::vector<unsigned> primes{};
auto is_prime = [](unsigned u) { /* ... */ };
std::copy_if(begin(numbers), end(numbers), begin(primes), is_prime); // not enough space, UB!
std::copy_if(begin(numbers), end(numbers), back_inserter(primes), is_prime); // works :)
```

=== Input Invalidation
Some operations on containers _invalidate its iterators_. _Example:_ `std::vector<T>::push_back`.\
If the new `size()` is greater than the `capacity()`, then all iterators and references are _invalidated._
This means it is _undefined behavior_ to do a `push_back()` on a container inside a `std::for_each` or similar.
