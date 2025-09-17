#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Standard Containers and Iterators
#v(-0.5em)
== Standard Containers
#hinweis[#cppr("container")[CPPReference: Containers library]]\
The standard library provides _different categories_ of containers:

#table(
  columns: (1fr, 1fr, 1fr),
  table.header([Sequence Containers], [Associative Containers], [Hashed Containers]),
  [
    Elements are accessible _in order_ as they were inserted / created.

    Find in _linear time_ $O(n)$ through the algorithm `find`.

    *Examples:*\
    - #cppr("container/vector")[`std::vector`]
    - #cppr("container/array")[`std::array`]
    - #cppr("container/list")[`std::list`]

    #image("img/cpl_03.png")
  ],
  [
    Elements are accessible in _sorted_ order.

    `find` as a member function in _logarithmic time_ $O(log(n))$ .

    *Examples:*\
    - #cppr("container/set")[`std::set`]
    - #cppr("container/map")[`std::map`]
    - #cppr("container/multimap")[`std::multimap`]

    #image("img/cpl_04.png")

  ],
  [
    Elements are accessible in _unspecified_ order.

    `find` as member function in _constant time_ $O(1)$.

    *Examples:*\
    - #cppr("container/unordered_set")[`std::unordered_set`]
    - #cppr("container/unordered_map")[`std::unordered_map`]
    - #cppr("container/unordered_multimap")[`std::unordered_multimap`]

    #image("img/cpl_05.png")
  ],
)

=== Common Features of Containers
All containers have a similar basic interface.
#grid(
  columns: (1.2fr, 1fr),
  align: horizon,
  [
    #table(
      columns: (auto, 1fr),
      table.header([Member Function], [Purpose]),
      [`begin()`, `end()`], [Get iterators for algorithms and iteration in general],
      [`erase(iter)`], [Removes the element at position the iterator `iter` points to],
      [`insert(iter, value)`], [Inserts `value` at the position the iterator `iter` points to],
      [`size()`, `empty()`], [Check the size of the container],
    )
  ],
  image("img/cpl_06.png"),
)

#grid(
  columns: (1.25fr, 1fr),
  [
    Containers can be...
    - _default-constructed_
    - _copy-constructed_ from another container of the same type
    - _equality compared_ if they are of the same type and their elements can be compared
    - _emptied with `clear()`_.

  ],
  [
    ```cpp
    // Default construction: Empty container
    std::vector<int> v{};
    // Copy construction: Creates a copy of v
    std::vector<int> vv{v};
    // Elements in vector can be compared, so
    // container comparison is possible
    if (v == vv) {
      // Remove all elements from container
      v.clear();
    }
    ```
  ],
)

=== Common Container Constructors
- _Construction with initializer List:_ ```cpp std::vector<int> v{1, 2, 3, 5, 7, 11};```
- _Construction with a number of elements:_ ```cpp std::list<int> l(5, 42); // 5 list elements with value "42"```\
  Can provide a default value. Often needs parenthesis instead of `{}` to avoid ambiguity from list of values initialization.
- _Construction from a range given by a pair of iterators:_ ```cpp std::deque<int> q{cbegin(v), cend(v)};``` \
  Might need parenthesis instead of `{}` #hinweis[(rare)]

=== Sequence Containers
#grid(
  [
    #hinweis[#cppr("container#Sequence_containers")[CPPReference: Containers library - Sequence Containers]]\
    `std::vector<T>, std::deque<T>, std::list<T>, std::array<N,T>`\
    _Order_ is defined in order of inserted/appended elements.
    `std::list` is good for _splicing_ and _"in the middle" insertions_.
    `std::vector`/`std::deque` are _efficient_ unless bad usage #hinweis[(frequent `insert()` calls)].

    Can all _grow_ in size, except `std::array` because it is a fixed-size container.
  ],
  image("img/cpl_07.png"),
)

==== Double-Ended Queue: `std::deque<T>`
#hinweis[#cppr("container/deque")[CPPReference: `std::deque`]]
#h(1fr) ```cpp #include <deque>``` #v(-0.5em)

#grid(
  [
    Like `std::vector` but with additional, efficient front insertion/removal
    #hinweis[(`push_front(x)`, `pop_front()`)].

    ```cpp
    std::deque<int> q{begin(v), end(v)};
    q.push_front(42);
    q.pop_back();
    ```
  ],
  image("img/cpl_08.png"),
)

==== Double-Linked List: `std::list<T>`
#hinweis[#cppr("container/list")[CPPReference: `std::list`]]
#h(1fr) ```cpp #include <list>``` #v(-0.5em)

#grid(
  [
    Efficient _insertion_ in _any_ position
    #hinweis[(`push_front(x)`, `insert(next(begin(), 3), x)`, `push_back(x)`)].\
    Lower efficiency in _bulk_ operations, requires member-function call for `sort()` etc.
    Only _bi-directional_ iterators - no index access!

    ```cpp
    std::list<int> l{5, 1};
    ```
  ],
  image("img/cpl_09.png"),
)


==== Singly-Linked List: `std::forward_list<T>`
#hinweis[#cppr("container/forward_list")[CPPReference: `std::forward_list`]]
#h(1fr) ```cpp #include <forward_list>``` #v(-0.5em)

#grid(
  [
    Efficient insertion _after_ any position, but clumsy with iterator to get "before" position.\
    Only _forward-iterators_, clumsy to search and remove, use member-functions instead of algorithms.
    _Avoid!_ Better use `std::list` or even better `std::vector`.

    ```cpp
    std::forward_list<int> l{1, 2, 3, 4, 5, 6};
    ```
  ],
  image("img/cpl_10.png"),
)

#pagebreak()

==== LIFO Adapter: `std::stack`
#hinweis[#cppr("container/stack")[CPPReference: `std::stack`]]
#h(1fr) ```cpp #include <stack>``` #v(-0.5em)

#grid(
  [
    Uses `std::deque` internally and limits its functionality to stack operations.
    _Pops from the back._
    Delegates to `push_back()`, `back()` and `pop_back()`.
    Iteration _not possible_. No longer a container!

    ```cpp
    std::stack<int> s{};
    s.push(42);
    std::cout << s.top(); // Get value on stack top
    s.pop(); // Removes value without returning it
    ```
  ],
  image("img/cpl_11.png"),
)

==== Priority Queue Adapter: `std::priority_queue`
#hinweis[#cppr("container/priority_queue")[CPPReference: `std::priority_queue`]]
#h(1fr) ```cpp #include <queue>``` #v(-0.5em)
#grid(
  [
    Like `std::stack`, but keeps elements partially sorted as (binary) heap.
    Requires element type to be _comparable._ `top()` element is always the smallest. No longer a container!
  ],
  image("img/cpl_11.png"),
)


==== FIFO Adapter: `std::queue`
#hinweis[#cppr("container/queue")[CPPReference: `std::queue`]]
#h(1fr) ```cpp #include <queue>``` #v(-0.5em)

#grid(
  [
    Uses `std::deque` and limits its functionality to queue operations.
    _Pops from the front._
    Delegates to `push_back()` and `pop_front()`.
    Iteration _not possible_. No longer a container!

    ```cpp
    std::queue<int> q{};
    q.push(42);
    std::cout << q.front(); // Get value
    q.pop(); // Remove value without returning it
    ```
  ],
  image("img/cpl_12.png"),
)

=== Example: Stack and Queue
```cpp
#include <iostream>
#include <deque>
#include <stack>
#include <string>

auto main() -> int {
  std::stack<std::string> lifo{}; // Last in, first out
  std::queue<std::string> fifo{}; // First in, first out
  for (std::string s : { "Fall", "leaves", "after", "leaves", "fall" }) {
    lifo.push(s);
    fifo.push(s);
  }
  while (!lifo.empty()) {
    std::cout << lifo.top() << ' '; // fall leaves after leaves Fall
    lifo.pop();
  }
  std::cout << '\n';
  while (!fifo.empty()) {
    std::cout << fifo.front() << ' '; // Fall leaves after leaves fall
    fifo.pop();
  }
}
```

#pagebreak()

=== Associative Containers
#hinweis[#cppr("container#Associative_containers")[CPPReference: Containers library - Associative Containers]]\
Associative containers are _sorted tree containers_. Allow searching by content, not by sequence
#hinweis[(Search by key, can access key or key-value pair)].

#table(
  columns: (1fr, 1fr, 1fr),
  table.header([], [Only Key storable], [Key-Value Pair storable]),
  [_Unique Key_], [`std::set<T>`], [`std::map<K, V>`],
  [_Multiple Equivalent Keys_], [`std::multiset<T>`], [`std::multimap<K, V>`],
)

Associative containers allow an _additional template argument_ for the comparison operation.
It must be a functor class returning a binary predicate that is _irreflexive_ and _transitive._
Own functors can provide special sort order #hinweis[(i.e caseless-string comparison)].
The sorting requirement must be fulfilled #hinweis[(i.e. `>=` is not allowed, because it is reflexive!)]\
```cpp std::set<int, std::greater> reversed_int_set{}```

For more details about functors and predicates, see chapter @functor.

==== Set of Elements: `std::set`
#hinweis[#cppr("container/set")[CPPReference: `std::set`]]
#h(1fr) ```cpp #include <set>``` #v(-0.5em)

#grid(
  [
    Stores elements in _sorted order_ #hinweis[(ascending by default, can be overwritten by the 2nd parameter)].
    Iteration walks over elements in order.
    Keys cannot be modified through iterators because this would destroy the sorting and invalidate the current iterator.

    Use member-functions for `.find()` and `.count()`. The result of `count()` is either 0 or 1 #hinweis[(present/not present)].

    Initializer does not need to be sorted. `s.contains(x)` checks if `x` is present in `std::set`
    #hinweis[(more performant than using `find()`/`count()`)].

    ```cpp
    std::set<int> values{7,1,4,3,2,5,6}
    ```
  ],
  [
    ```cpp
    #include <iostrem>
    #include <set>
    auto filterVowels(std::istream& in,
     std::ostream& out) -> void
    {
      std::set const v{'a','e','o','u','i','y'};
      char c{};
      while (in >> c) {
        if (!v.contains(c)) { out << c; }
      }
    }
    auto main() -> int {
      filterVowels(std::cin, std::cout);
    }
    ```
  ],
)

==== Map of Key-Value-Pairs: `std::map`
#hinweis[#cppr("container/map")[CPPReference: `std::map`]]
#h(1fr) ```cpp #include <map>``` #v(-0.5em)

#grid(
  [
    Stores key-value pairs in _sorted order_. Sorted by key in ascending order.
    Order can be overwritten by the 3rd template parameter.

    The _indexing operator `[]`_ inserts a new entry automatically if the given key is not present.
    Returns the value _by reference_.

    When using an _iterator,_ the item returned is a `std::pair<key, value>`.
    Use `.first` to access the key and `.second` for the value.

    ```cpp
    std::map<char, size_t> vowels{
      {'a', 3}, {'e', 8}, {'i', 5},
      {'o', 4}, {'u', 2}
    }
    ```
  ],
  [
    ```cpp
    auto countVowels(std::istream& in, std::ostream& out) -> void {
      std::map<char, size_t> v{
        {'a',0},{'e',0},{'i',0},{'o',0},{'u',0}};
      char c{};
      while (in >> c) {
        // Only insert chars already present in map
        if (v.contains(c)) {
          ++v[c];
          // Output new count for all vowels
          std::for_each(cbegin(v), cend(v), [&out]
           (auto const& e) {
            out << e.first <<" = "<<e.second<<'\n';
          });
    } } }
    ```
  ],
)

```cpp
auto countStrings(std::istream& in, std::ostream& out) -> void { // Counts how many times a
  std::map<std::string, size_t> occurrences{};                   // word appears in the input
  std::istream_iterator<std::string> inputBegin{in};
  std::istream_iterator<std::string> inputEnd{};
  for_each(inputBegin, inputEnd, [&occurrences](auto const &str) { ++occurrences[str]; });
  for (auto const &occ : occurrences) { out << occ.first << " = " << occ.second << '\n'; }
}
```

#pagebreak()

==== `std::multiset` and `std::multimap`
#hinweis[
  #cppr("container/multiset")[CPPReference: `std::multiset`],
  #cppr("container/multimap")[CPPReference: `std::multimap`]
]
#h(1fr) ```cpp #include <set>``` ```cpp #include <map>``` #v(-0.5em)

#grid(
  [
    Multiple equivalent keys allowed. Use member functions/algorithms to find boundaries of equivalent keys:
    - _`equal_range()`_ #hinweis[(returns pair with start and end position)]
    - _`lower_bound()`/`upper_bound()`_ #hinweis[(returns position of first/last element or next/previous element if not found)]

    ```cpp
    std::multiset<char> letters{
      'a','a','c','c','c','e','e','f'};
    // 0   1   2   3   4   5   6   7
    letters.lower_bound('b'); // iter to elem 2
    letters.upper_bound('e'); // iter to elem 7
    // pair with iter to elem 2 & iter to elem 5
    letters.equal_range('c');
    ```
    #image("img/cpl_13.png")
  ],
  [
    ```cpp
    // Prints the same words on the same line
    // different words on different lines
    auto sortedStringList(std::istream& in, std::ostream&out) -> void {
      using inIter =
         std::istream_iterator<std::string>;
      using outIter =
         std::ostream_iterator<std::string>;
      // Copy words from istream into multiset
      std::multiset<std::string> w{
        inIter{in}, inIter{}};

      auto current = cbegin(w);
      while (current != cend(w)) {
        auto endOfRange = w.upper_bound(*current);
        copy(current,endOfRange,outIter{out,", "});
        out << '\n';
        current = endOfRange;
      }
    }
    ```
  ],
)

=== Hashed Containers
#hinweis[#cppr("container#Unordered_associative_containers_.28since_C.2B.2B11.29",
  )[CPPReference: Containers library - Unordered Associative Containers]]\
Hashed containers offer more efficient lookups, but offer no sorting.
If you want to use these hashed containers with your own types, you would need to create your own hashing function.
Because creating your own hashing function is hard, you stick to standard types like `std::string` for keys instead.

==== `std::unordered_set`
#hinweis[#cppr("container/unordered_set")[CPPReference: `std::unordered_set`]]
#h(1fr) ```cpp #include <unordered_set>``` #v(-0.5em)

#grid(
  [
    More _efficient lookup_, no sorting.
    Usage is almost equivalent to `std:set`, except for lack of ordering.

    Don't use `std::unordered_set` with your own types.
  ],
  [
    ```cpp
    auto main() -> int {
      std::unordered_set<char> const vowels
       {'a','e','o','u','i','y'}
      using in = std::istreambuf_iterator<char>;
      using out = std::ostreambuf_iterator<char>;
      // Remove all words with vowels
      remove_copy_if(in{std::cin}, in{},
       out{std::cout},[&](char c) {
           return vowels.contains(c);
       });
    }
    ```
  ],
)

==== `std::unordered_map`
#hinweis[#cppr("container/unordered_map")[CPPReference: `std::unordered_map`]]
#h(1fr) ```cpp #include <unordered_map>``` #v(-0.5em)

#grid(
  [
    Usage is almost equivalent to `std:map`, except for lack of ordering.

    Don't use `std::unordered_map` with your own types.
  ],
  [
    ```cpp
    auto main() -> int {
      std::unordered_map<std::string, int> w{};
      std::string s{};
      while (std::cin >> s) { ++w[s]; }
      for (auto const& p : w) {
        std::cout<<p.first<<" = "<<p.second<<'\n';
      }
    }
    ```
  ],
)

#pagebreak()

== Iterators <Iterators>
#hinweis[#cppr("iterator")[CPPReference: Iterator Library]]
#v(-0.5em)
=== STL Iterator Categories <Iterator-Categories>
#grid(
  [
    Different containers support iterators of different capabilities. Categories are formed around _"increasing power"_
    - _`std::istream_iterator`_ corresponds to `input_iterator`'s capabilities
    - _`std::ostream_iterator`_ is an `output_iterator`
    - _`std::vector<T>`_ provides `random_access` iterators
  ],
  image("img/cpl_14.png"),
)

Some algorithms _only work_ with _powerful iterators_
#hinweis[(For example, `std::sort()` requires a pair of random access iterators to jump backwards and forwards)].
Some algorithms can be _implemented better_ with more powerful iterators
#hinweis[(For example, `std::advance()` or `std::distance()` are faster with a random access iterator than a forward iterator)].

==== `const_iterator != const` Iterator!
Declaring an iterator _`const`_ would not allow modifying the iterator object, meaning the iterator cannot be
incremented with `++` or `std::next()`.\
`cbegin()` and `cend()` return _`const_iterators`_. This does _not_ imply the iterator to be `const`,
but the _elements_ the iterator walks over are `const` and therefore can't be modified.

=== Input Iterator
#hinweis[#cppr("iterator/input_iterator")[CPPReference: `std::input_iterator`]]
#v(-0.5em)
#grid(
  [
    Supports _reading_ the "current" element #hinweis[(but not changing it)].
    Allows for _one-pass input algorithms_ #hinweis[(read everything once)].

    Can _not_ step _backwards._ Models the `std::istream_iterator` and `std::istream`.

    Can be _compared_ with `==` and `!=` to other iterator objects of the same type: `It`. Can be _copied._
    After incrementing #hinweis[(calling `++`)], all other copies are _invalid_.
  ],
  [
    ```cpp
    struct input_iterator_tag{};
    auto operator* () -> Element;
    auto operator++() -> It&;
    auto operator++(int) -> It;
    auto operator==(It const&) -> bool;
    auto operator!=(It const&) -> bool;
    auto operator= (It const&) -> It&;
    It(It const&); // copy constructor
    ```
  ],
)

=== Forward Iterator
#hinweis[#cppr("iterator/forward_iterator")[CPPReference: `std::forward_iterator`]]
#v(-0.5em)
#grid(
  [
    Can do whatever an input iterator can, plus ...\
    - Supports _changing_ the "current" element, unless the container or its element are `const`.
    - Can _not_ step backwards, but can keep iterator copy around for later reference.\
    Models the `std::forward_list` iterators.
  ],
  [
    ```cpp
    struct forward_iterator_tag{};
    auto operator*() -> Element&;
    // Otherwise has the same operators as the
    // input iterator
    ```
  ],
)


=== Bidirectional Iterator
#hinweis[#cppr("iterator/bidirectional_iterator")[CPPReference: `std::bidirectional_iterator`]]
#v(-0.5em)
#grid(
  [
    Can do whatever a forward iterator can, plus ...\
    - Can go _backwards,_ allows for _forward-backward-pass_ algorithms.

    Models the `std::set` iterators.
  ],
  [
    ```cpp
    struct bidirectional_iterator_tag{};
    auto operator--() -> It&;
    auto operator--(int) -> It;
    // Otherwise has the same operators as the
    // forward iterator
    ```
  ],
)

#pagebreak()

=== Random Access Iterator
#hinweis[#cppr("iterator/random_access_iterator")[CPPReference: `std::random_access_iterator`]]
#v(-0.5em)
#grid(
  [
    Can do whatever a bidirectional iterator can, plus ... \
    - _Directly access_ element at index #hinweis[(Offset to current position)]: Distance can be positive or negative.
    - _Go n steps_ forward or backward.
    - _Subtract_ two iterators to get the distance.
    - _Compare_ with _relational operators_ #hinweis[(`<`,`<=`,`>`,`>=`)]

    Models the `std::vector` iterators.
  ],
  [
    ```cpp
    struct random_access_iterator_tag{};
    auto operator[](distance) -> Element&;
    auto operator+(distance) -> It;
    auto operator+=(distance) -> It&;
    auto operator-(distance) -> It;
    auto operator-=(distance) -> It&;
    auto operator-(It const &) -> distance;
    // relational operators, like <
    // Otherwise has the same operators as the
    // bidirectional iterator
    ```
  ],
)

#v(-0.5em)
=== Output Iterator
#hinweis[#cppr("iterator/output_iterator")[CPPReference: `std::output_iterator`]]
#v(-0.5em)
#grid(
  [
    Can _write_ value to current element, but only once\ #hinweis[(`*it = value`)]. After that, an increment is required.

    Most _other iterators_ can also _act as output iterators_, unless the underlying container is _`const`_.
    *Exception:* associative containers only allow read-only iteration.

  ],
  [
    ```cpp
    struct output_iterator_tag{};

    auto operator*() -> Element&;
    auto operator++() -> It&;
    auto operator++(int) -> It;
    ```
  ],
)
_No comparison_ possible and end to an `out`-range is not queryable. Models the `std::ostream_iterator`.

=== Iterator Functions
#hinweis[#cppr("iterator#Iterator_operations")[CPPReference: Iterator library - Iterator Operations]]
#v(-0.5em)
- _`std::distance(start, goal)`:_ Counts the number of "hops" iterator `start` must make until it reaches `goal`.
  Efficient for random access iterators, for other iterators it needs to traverse the iterator.
- _`std::advance(itr, n)`:_ Lets `itr` "hop" `n` times. Requires a step, no default step size. Modifies the argument iterator.
  Returns void. Efficient for random access iterators. Allows negative `n` for bidirectional iterators.
- _`std::next(itr, n)`:_ Lets `itr` "hop" `n` times.  Has a default step size of 1. Makes a copy of the argument
  #hinweis[(returns a input iterator pointing to the n-th element)].
